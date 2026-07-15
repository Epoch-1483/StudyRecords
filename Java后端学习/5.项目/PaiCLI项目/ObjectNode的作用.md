# ObjectNode 是用来干嘛的？

> 关联：`GLMClient` 中用 `mapper.createObjectNode()` 拼请求体；配合 [[GLMClient中的ObjectMapper]] 一起看。

## 1. 它在 Jackson 里的定位

`ObjectNode`（`com.fasterxml.jackson.databind.node.ObjectNode`）是 Jackson **树模型（Tree Model）** 里的一个具体类，用来表示 JSON 里的**对象 `{...}`**——一个可变的、内存中的键值节点。

Jackson 处理 JSON 有三种方式：
- **Data Binding**：直接绑到 POJO（`readValue` / `writeValueAsString(pojo)`）
- **Streaming**：`JsonParser` / `JsonGenerator`，最快但最底层
- **Tree Model**：用 `JsonNode` 树在内存里表示 JSON 结构——`ObjectNode`（对象）、`ArrayNode`（数组）、`TextNode` / `IntNode` 等（值节点）。**`ObjectNode` 就是这棵树里"对象"节点的可写版本。**

## 2. 它为什么"可写 / 可变"

和 `record` / POJO 的不可变不同，`ObjectNode` 是**可变**的：建好之后还能继续 `put` / `set` / `remove` 字段。所以在 `buildRequestBody()` 里可以：先建一个空对象，再逐个往里塞字段，最后一次性转成 JSON 字符串发出去。

```java
ObjectNode root = mapper.createObjectNode();   // 建一个空 {}
root.put("model", MODEL);                       // → {"model": "glm-4.5-air"}
root.put("stream", true);
ArrayNode msgs = root.putArray("messages");     // → "messages": [...]
ObjectNode fn = root.putObject("function");     // → "function": {...}
```

## 3. 常用 API

| 方法 | 作用 | 例子 |
|---|---|---|
| `put(field, 值)` | 加一个基础类型字段 | `put("role", "user")`、`put("stream", true)` |
| `putArray(field)` | 加数组字段，返回 `ArrayNode` | `root.putArray("messages")` |
| `putObject(field)` | 加嵌套对象字段，返回 `ObjectNode` | `tcNode.putObject("function")` |
| `set(field, JsonNode)` | 挂一个已建好的 `JsonNode` | `fnDef.set("parameters", tool.parameters())` |
| `toString()` | 序列化成 JSON 字符串 | `String json = root.toString();` |

> `set(field, node)` 之所以有用：本类里 `Tool.parameters` 本身类型就是 `JsonNode`，直接整段嵌进去即可，不用再拆。

## 4. 为什么这里要用它（而不是 POJO 直出）

`Message` / `Tool` record 的形状和 OpenAI 协议要的 JSON 形状**不是 1:1**：
- 协议要求 `tool_calls` 写成 `{id, type:"function", function:{name, arguments}}` 这种嵌套结构；
- `null` 字段（如没工具调用时的 `tool_calls`）应该整体不出现，而不是写成 `null`。

用 `ObjectNode` 手工搭树，就能**精确控制字段名、嵌套层级、以及"有值才写"**。这是"树模型"相比"直接序列化 POJO"最大的灵活点。

## 5. 和 ObjectMapper / JsonNode 的关系

- `ObjectMapper` 是**工厂 + 转换器**：用 `mapper.createObjectNode()` 造节点，用 `mapper.readTree(json)` 把 JSON 读成 `JsonNode` 树。
- `ObjectNode` 是 `JsonNode` 的**子类**（可写版本）。读响应时拿到的 `JsonNode` 和写请求时建的 `ObjectNode` 是同一套树模型——所以同一个 `ObjectMapper` 既能拼请求、又能解析响应。

## 一句话总结

`ObjectNode` 就是 Jackson 树模型里"JSON 对象 `{...}`"的可变内存表示；用 `mapper.createObjectNode()` 造出来后，靠 `put` / `putArray` / `putObject` / `set` 手工拼出符合 API 协议的请求体，最后 `toString()` 成 JSON 发出去。
