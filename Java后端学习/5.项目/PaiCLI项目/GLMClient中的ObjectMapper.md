# GLMClient 中为什么要用 ObjectMapper？

> 源码位置：`src/main/java/edu/cqie/paiclidemo/llm/GLMClient.java`
> 关联：`LlmClient` 接口里的 `Message` / `Tool` / `ToolCall` record（上一讲：为什么用 record、工厂方法为什么传 null）

## 1. ObjectMapper 是什么

`ObjectMapper` 是 Jackson（Java 最主流的 JSON 处理库）的**核心门面类**。所有"Java ↔ JSON"的转换都要通过它：

- 序列化：Java 对象 / 数据 → JSON 字符串（`writeValueAsString` / `createObjectNode`）
- 反序列化：JSON 字符串 → Java 对象或 JSON 树（`readTree` / `readValue`）

在 `GLMClient` 里它被声明为：

```java
private static final ObjectMapper mapper = new ObjectMapper();
```

## 2. 为什么要专门创建一个（而不是每次 new）

- **它是所有 JSON 操作的入口**：没有 `ObjectMapper` 就无法 `readTree()`，也无法 `createObjectNode()`——它是"干活的锤子"，不创建就根本没法处理 JSON。
- **构建成本高、但线程安全**：`ObjectMapper` 内部会缓存序列化器/反序列化器、做大量配置。高频调用下反复 `new` 既浪费又拖性能。所以它被声明成 `static final`——整个类共享**一个**实例，跨多次 `chat()` 调用复用（`ObjectMapper` 线程安全，可放心共享）。
- 对照：`OkHttpClient` 也是 `final` 单例，思路一致——"重对象只建一次，到处复用"。

## 3. 它在本类里具体干了两件事

### (1) 序列化：拼请求体（Java → JSON）

`buildRequestBody()` 里用 `mapper.createObjectNode()` 手动搭一棵 JSON 树：

```java
ObjectNode root = mapper.createObjectNode();
root.put("model", MODEL);
root.put("stream", true);
ArrayNode msgArray = root.putArray("messages");
for (Message msg : messages) { /* 逐个拼 role/content/tool_calls */ }
String json = root.toString();
```

为什么不用 `mapper.writeValueAsString(messages)` 直接序列化？因为**API 要的 JSON 形状和 `Message` record 不一样**：

- record 里 `toolCalls` / `toolCallId` 可能为 `null`，而 OpenAI 协议里这些是"可选字段"；
- 协议要求 `tool_calls` 套成 `{id, type:"function", function:{name, arguments}}` 结构，`arguments` 还是从 `ToolCall.Function` 里拆出来拼的；
- 所以用**树模型（`JsonNode`）**手工拼，能精确控制输出、按需包含字段（用 `if` 判断跳过 `null`）。

### (2) 反序列化：解析 SSE 流式响应（JSON → Java 树）

`parseSseStream()` 里对每一行 `data:` 调用：

```java
JsonNode chunk = mapper.readTree(data);
JsonNode delta = chunk.path("choices").path(0).path("delta");
```

这里用 `readTree` 把 JSON 转成 `JsonNode` 树，再用 `path()` 一路导航。`path()` 的好处是**字段缺失也不抛异常**（返回 `MissingNode`），特别适合处理模型分片返回、结构不固定的流式 chunk。

## 4. 一个小细节：JsonNode 是贯穿全类的"通用货币"

注意 `Tool` record 里 `parameters` 字段本身类型就是 `JsonNode`：

```java
record Tool(String name, String description, JsonNode parameters) {}
```

在 `buildRequestBody` 里直接 `fnDef.set("parameters", tool.parameters())` 嵌进请求树。也就是说本类**全程用 `JsonNode` 树模型**，而不是到处定义 POJO，避免了为响应结构写一堆一次性类——`ObjectMapper` 正是操作这棵树的工具。

## 5. 和上一讲的呼应

之前讲 `Message` 用 record + 工厂方法把不适用的字段设 `null`。在这里这些 `null` 被消费掉了：

```java
if (msg.content() != null) msgNode.put("content", msg.content());
if (msg.hasToolCalls()) { /* 内部做了 toolCalls != null && !isEmpty() */ }
if (msg.toolCallId() != null) msgNode.put("tool_call_id", msg.toolCallId());
```

正是因为上游允许 `null`，下游才需要这些判空——`ObjectMapper` 只是忠实地把"有值才写、没值就跳"的逻辑落到 JSON 上。

## 6. 可延伸的优化点

- 若想让 `null` 字段（如 `tool_calls: null`）彻底不出现在 JSON 里，可给 `mapper` 配 `setSerializationInclusion(JsonInclude.Include.NON_NULL)`；当前代码用 `if` 手动控制，效果等价且更直观。
- 若响应结构固定，也可定义 `Chunk` / `Delta` record 用 `mapper.readValue(data, Chunk.class)` 代替 `JsonNode` 树，类型更安全；但流式分片下 `JsonNode` 的灵活性更实用。

## 一句话总结

`ObjectMapper` 是 Jackson 处理 JSON 的入口；在 `GLMClient` 中它被做成 `static final` 单例，**既负责把 `Message`/`Tool` 列表拼成符合 OpenAI 协议的请求 JSON 树，又负责把流式返回的 SSE `data:` 行解析成 `JsonNode` 树**——全程用 `JsonNode` 树模型，绕开为一堆一次性结构定义 POJO 的麻烦。


---

## 🔗 关联笔记
- [[《PaiCLI》项目学习笔记]]
- [[求职项目MOC]]
