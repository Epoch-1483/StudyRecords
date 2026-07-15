# 流式响应里的 delta 是什么？为什么叫 delta？

> 关联：[[GLMClient中的ObjectMapper]]（parseSseStream 解析它）、[[JsonNode与各类Node的关系]]（delta 在代码里就是个 JsonNode）

## 1. 它在这段代码里是什么

在 `GLMClient.parseSseStream()` 中，模型走的是**流式（SSE）**返回。每个 SSE chunk 大致长这样：

```json
data: {"choices":[{"delta":{"content":"你"}}], ...}
data: {"choices":[{"delta":{"content":"好"}}], ...}
...
data: [DONE]
```

代码里：
```java
JsonNode delta = chunk.path("choices").path(0).path("delta");
```

所以 **`delta` 就是每个 chunk 里 `choices[0]` 下的那个对象**，代表"这一小片新生成的内容"。

## 2. 为什么要叫 delta

`delta`（Δ，希腊字母）在数学 / 计算机里表示**"变化量 / 增量 / 差值"**。

流式接口不是一次性把整条消息发给你，而是**一点点吐**：每个 chunk 只携带"**相比于上一次，这次新生成了什么**"——也就是相对上一次的"差值（delta）"。客户端负责把这些 delta **累加起来**得到完整消息：

- 第一个 chunk 的 delta 通常带 `role: "assistant"`（告诉你消息开始了）；
- 中间 chunk 的 delta 带 `content` 文本片段（以及 `tool_calls` 工具调用的片段）；
- 最后一条是 `data: [DONE]` 表示结束。

完整消息 = 所有 `delta.content` 之和。这正对应代码里的 `contentBuilder.append(delta.get("content").asText());` 和 `mergeToolCallDeltas(...)`。

## 3. 它和"完整 message"的对照

- **非流式（一次返回）**：响应里直接给完整的 `message` 对象（`role` + `content` 全有）。
- **流式**：响应拆成一串 `chunk`，每个 `chunk.choices[0].delta` 只给增量。

所以 OpenAI 兼容协议里：非流式用 `message`，流式用 `delta`——`delta` 就是"增量版 message"。

## 4. 在 GLMClient 里的印证

```java
JsonNode delta = chunk.path("choices").path(0).path("delta");
if (!delta.isMissingNode()) {
    if (delta.has("content") && !delta.get("content").isNull())
        contentBuilder.append(delta.get("content").asText());   // 累积文本片段
    if (delta.has("tool_calls"))
        mergeToolCallDeltas(toolCallAccumulators, delta.get("tool_calls")); // 累积工具调用片段
}
```

注意 `tool_calls` 也是分片来的：第一个 delta 带 `id` + `function.name`，后续 delta 只带 `function.arguments` 的片段——所以才需要 `ToolCallAccumulator` 逐步拼。

## 一句话总结

`delta` = 流式响应中每个 chunk 携带的**增量片段**（文本或工具调用的"新生成的一小块"）。叫 delta 是因为它本意是"差值 / 变化量"——每次只发"相比上次新增了什么"，由客户端把一串 delta 累积成完整回复。
