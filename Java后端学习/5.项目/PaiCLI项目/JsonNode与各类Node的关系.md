# JsonNode 与各类 xxxNode 的关系

> 关联：[[GLMClient中的ObjectMapper]]、[[ObjectNode的作用]]、[[ObjectNode与ArrayNode的区别]]、[[StringBuilder的作用]]

## 1. 一句话关系

`JsonNode` 是 Jackson 树模型里**所有节点类的抽象父类**；你之前问的 `ObjectNode`、`ArrayNode`，以及没细问的 `TextNode`、`IntNode`、`BooleanNode`、`NullNode` 等，全都是 `JsonNode` 的**具体子类**。

所以"xxxNode"= 整个节点家族，它们**全部继承 `JsonNode`**。

## 2. 类层级（文字版）

```
JsonNode (抽象，所有节点的父类型)
├── ContainerNode (抽象，可包含子节点)
│   ├── ObjectNode   ← JSON 对象 {...}
│   └── ArrayNode    ← JSON 数组 [...]
└── ValueNode (抽象，叶子节点，无子节点)
    ├── TextNode     ← 字符串
    ├── IntNode / LongNode / DoubleNode ← 数字
    ├── BooleanNode  ← true / false
    └── NullNode     ← null
```

- `ObjectNode` / `ArrayNode` 是**容器节点**（能挂子节点），对应之前讲的两类。
- `TextNode` 等是**叶子节点**（值本身，不可再挂东西）。

## 3. 各层提供什么能力

**JsonNode（基类，类型无关）** —— 不管实际是哪种节点都能调：
- 类型判断：`isObject()` / `isArray()` / `isTextual()` / `isNumber()` / `isMissingNode()`
- 通用取值：`asText()` / `asInt()` / `asBoolean()` / `asDouble()`（按节点类型智能转换，缺失或类型不符给默认值）
- 安全导航：`path("key")` / `path(index)` —— 字段不存在返回 `MissingNode`（**不会 NPE**）
- 通用遍历：`get(key)` / `get(index)` / `size()` / `elements()` / `fieldNames()` / `toString()`

**ObjectNode / ArrayNode（容器子类）** —— 在基类之上**额外加了"可写"的改树方法**：
- `ObjectNode`：`put(key, val)`、`putObject`、`putArray`、`set(key, node)`
- `ArrayNode`：`add(val)`、`addObject()`、`addArray()`、`set(index, node)`

**ValueNode 子类** —— 基本只读（值固定），用基类 `asXxx()` 取值即可。

## 4. 什么时候用哪一个

| 场景 | 持有 / 创建的类型 | 用法 |
|---|---|---|
| **写（拼 JSON）** | 具体 `ObjectNode` / `ArrayNode` | `mapper.createObjectNode()` 造出来，用 `put` / `add` 等"改树"方法搭建 |
| **读（解析 JSON）** | 抽象 `JsonNode` | `mapper.readTree(json)` 返回 `JsonNode`（运行时真实类型可能是 ObjectNode / ArrayNode / 叶子节点），用 `path()` / `asText()` 等通用 API 导航 |

关键点：**读的时候通常不关心具体子类**——`readTree` 给的是 `JsonNode`，用通用方法就能取值；只有需要"改树"时才转型成 `ObjectNode` / `ArrayNode` 去调 `put` / `add`。

## 5. 在 GLMClient 里的印证

- 写侧：`ObjectNode root = mapper.createObjectNode();` —— 明确造 `ObjectNode`，用 `put` / `putArray` 搭请求体。
- 读侧：`JsonNode chunk = mapper.readTree(data);` —— 拿到 `JsonNode`，用 `chunk.path("choices").path(0).path("delta")` 安全导航；`path()` 一路返回 `JsonNode`，字段缺失也不抛异常（返回 `MissingNode`），所以流式分片解析不会 NPE。

## 一句话总结

`JsonNode` 是**父类型 / 通用接口**，提供"读和判断"的能力；`ObjectNode` / `ArrayNode` 是它的**具体容器子类**，额外提供"写和改"的能力；其余 `TextNode` 等是叶子子类。写 JSON 时造具体子类、读 JSON 时拿 `JsonNode` 通用操作——这就是它们的关系。
