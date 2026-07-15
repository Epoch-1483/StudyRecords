# ObjectNode 与 ArrayNode 的区别

> 关联：[[ObjectNode的作用]]（JSON 对象节点的可变内存表示）

## 1. 共同点

两者都是 Jackson **树模型**里的**容器节点（ContainerNode）**，都继承 `ContainerNode<JsonNode>`：

- 都是**可变的**：建好后能继续增删元素；
- 都能被 `ObjectMapper` 序列化（`toString()` 即 JSON 字符串）；
- 都通过 `mapper.createObjectNode()` / `mapper.createArrayNode()` 创建，或由别的节点派生（如 `obj.putArray("x")` / `arr.addObject()`）。

读响应时 `mapper.readTree()` 返回的是抽象父类型 `JsonNode`，它可能是二者之一——可用 `isObject()` / `isArray()` 判断或强制转型。

## 2. 核心区别：它代表什么 JSON 结构

| | ObjectNode | ArrayNode |
|---|---|---|
| 对应 JSON | 对象 `{...}` | 数组 `[...]` |
| 内存模型 | 有序的 `key → value` 映射（类似 `Map<String, JsonNode>`） | 有序的值列表（类似 `List<JsonNode>`） |
| 访问方式 | 按**字段名**（String key） | 按**整数下标**（index） |
| 典型用途 | 一条消息、一个 function 定义、一层嵌套对象 | 消息列表、工具调用列表、任意数组 |

## 3. 各自的常用 API

**ObjectNode（按名存字段）**
- `put(key, 值)` 加基础字段
- `putObject(key)` 加嵌套对象 → 返回 `ObjectNode`
- `putArray(key)` 加数组字段 → 返回 `ArrayNode`
- `set(key, JsonNode)` 挂已建好的节点
- `get(key)` / `has(key)` / `fieldNames()` 读取

**ArrayNode（按下标存元素）**
- `add(值)` 追加一个基础元素
- `addObject()` 追加一个对象 → 返回 `ObjectNode`
- `addArray()` 追加一个数组 → 返回 `ArrayNode`
- `set(index, JsonNode)` 替换某个位置
- `get(index)` / `size()` 读取

## 4. 在 GLMClient 里它们怎么配合

二者**互相嵌套**：靠 `putArray` 在对象里挂数组、靠 `addObject` 在数组里挂对象，从而拼出任意层级的 JSON 树：

```java
ObjectNode root = mapper.createObjectNode();
ArrayNode msgArray = root.putArray("messages");        // 对象里挂数组
for (Message msg : messages) {
    ObjectNode msgNode = msgArray.addObject();         // 数组里挂对象
    msgNode.put("role", msg.role());
    ArrayNode tcArray = msgNode.putArray("tool_calls");// 对象里再挂数组
    for (ToolCall tc : msg.toolCalls()) {
        tcArray.addObject();                           // 数组里再挂对象
    }
}
String json = root.toString();
```

## 一句话总结

**`ObjectNode` 是"带名字的抽屉 `{key:val}`"，`ArrayNode` 是"排好队的格子 `[val,val]`"**——前者按名字取、后者按下标取，二者嵌套就能表达任何 JSON 结构。
