# isMissingNode() 是判断什么的？

> 关联：[[JsonNode与各类Node的关系]]、[[GLMClient中的ObjectMapper]]

## 1. 它判断什么

`isMissingNode()` 判断**当前这个 JsonNode 是不是 Jackson 里的"缺失占位节点" `MissingNode`**——也就是"你导航的路径根本不存在"的标记。

- 返回 `true`：这个节点是 `MissingNode`（路径没解析到任何真实节点）。
- 返回 `false`：这是一个真实存在的节点（ObjectNode / ArrayNode / TextNode / 哪怕是表示 JSON `null` 的 `NullNode` 都算"存在"）。

所以 `!delta.isMissingNode()` 在 `GLMClient.parseSseStream()` 里的意思是：**"这个 chunk 里确实有 delta 这东西，可以处理了"**。

## 2. 关键：MissingNode ≠ NullNode（最容易混）

Jackson 里有两个容易被搞混的"空"概念：

| | MissingNode | NullNode |
|---|---|---|
| 含义 | 路径 / 字段**根本不存在** | 字段**存在，但值是 JSON `null`** |
| 例子 | `{}` 里取 `path("delta")` | `{"delta": null}` |
| 谁返回它 | `path()` 在路径缺失时返回它 | JSON 里真写了 `null` |
| 对应判断 | `isMissingNode()` → true | `isNull()` → true |
| 是否真实节点 | 否（占位符） | 是（ValueNode 子类） |

一句话：**`isMissingNode()` 查"有没有这个字段"，`isNull()` 查"字段在但值为 null"**——两码事。

## 3. 为什么配合 path() 用（而不是 get()）

Jackson 提供两种取子节点方式：
- `get("key")`：字段不存在时返回 **`null`**（不判空就 NPE）。
- `path("key")`：字段不存在时返回 **`MissingNode`**（永不返回 null，导航安全）。

`parseSseStream()` 用的是 `path(...)` 一路导航：
```java
JsonNode delta = chunk.path("choices").path(0).path("delta");
```
只要中间任何一环缺失（比如 usage-only 的 chunk 里 `choices` 是空数组，`choices[0]` 不存在），最终 `delta` 就是 `MissingNode`。于是用 `!delta.isMissingNode()` 兜底——**路径没解析到东西就跳过，绝不拿空壳去读 content**。

## 4. 在 GLMClient 里的实际意义

不是每个 SSE chunk 都有 `delta`：
- 普通内容 chunk：`choices[0].delta.content = "你"` → delta 是真实 ObjectNode，进入处理。
- 某些 usage chunk（开启 `include_usage` 时）：`choices` 可能是空数组 → `choices[0]`、`delta` 逐级变成 `MissingNode` → 跳过，不当成消息内容。
- `[DONE]` 行在前面已被 `break` 过滤。

所以 `if (!delta.isMissingNode())` 是一道**安全闸门**：只处理"确实带 delta"的 chunk。

## 一句话总结

`isMissingNode()` 判断"这个节点是不是路径缺失的占位符（MissingNode）"，用来区分"字段不存在"和"字段存在但值为 null（NullNode）"；它和 `path()` 配合使用，让链式导航即使中途断掉也返回占位符而非 null，从而安全跳过无效 chunk。
