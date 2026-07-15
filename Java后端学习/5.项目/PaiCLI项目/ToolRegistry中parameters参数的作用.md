# ToolRegistry 中 parameters 参数的作用

> 关联：[[GLMClient中的ObjectMapper]]、[[JsonNode与各类Node的关系]]、[[isMissingNode方法的作用]]

## 一句话回答

`register(String name, String description, JsonNode parameters, ToolExecutor executor)` 里的 `parameters` 是**工具参数模式的 JSON Schema 描述**。它要告诉 LLM："这个工具叫什么、能干什么、调用它时需要传哪些参数、每个参数是什么类型"。只有把这些信息放进请求，`LLM` 才知道"什么场景下该调它、以及调它时要传什么"。

## 为什么必须传 parameters？

大模型（OpenAI / 智谱 / Claude 等）的 Function Calling 机制不是魔法。它之所以能"调用"你的工具，是因为它收到了一张**工具清单**，清单上每项都包含：

| 字段 | 作用 |
|------|------|
| `name` | 工具名，模型在 tool_call 里会写这个名字 |
| `description` | 工具用途，模型靠它判断什么时候该调 |
| `parameters` | **JSON Schema**，声明工具需要哪些参数、什么类型、是否必填 |

如果没有 `parameters`，模型就不知道调用时该传什么字段；传错了或漏传了，你的 `executor` 无法正确执行，只能返回错误。

## 实际案例：calculator 计算器

这是 `Main.java` 里注册的真实工具（`createToolRegistry` 方法）：

```java
registry.register(
    "calculator",
    "计算数学表达式。支持加减乘除、括号、幂运算。",
    createParameters(new Param("expression", "string", "要计算的数学表达式")),
    args -> {
        String expr = args.get("expression");
        // ... 计算表达式并返回结果
    }
);
```

`createParameters(new Param("expression", "string", "要计算的数学表达式"))` 会生成这样的 JSON Schema：

```json
{
  "type": "object",
  "properties": {
    "expression": {
      "type": "string",
      "description": "要计算的数学表达式"
    }
  },
  "required": ["expression"]
}
```

最终发给 LLM 的工具定义（整体被 LlmClient 拼进请求体）大概长这样：

```json
{
  "name": "calculator",
  "description": "计算数学表达式。支持加减乘除、括号、幂运算。",
  "parameters": {
    "type": "object",
    "properties": {
      "expression": { "type": "string", "description": "要计算的数学表达式" }
    },
    "required": ["expression"]
  }
}
```

### 当用户问 "帮我算 2+3*4" 时，LLM 会怎么做？

1. 模型看到 `calculator` 工具的描述，判断"需要计算，应该调用 calculator"；
2. 模型读取 `parameters` 里的 JSON Schema，知道必须传一个 `expression`（字符串类型）；
3. 模型生成 tool_call：

```json
{
  "name": "calculator",
  "arguments": "{\"expression\": \"2+3*4\"}"
}
```

4. `Agent` 收到 tool_call，调用 `ToolRegistry.executeTool(toolCall)`，把 `arguments` 解析成 `Map<String, String>`，然后执行 `executor`；
5. 执行器从 `args.get("expression")` 拿到 `"2+3*4"`，算出结果 `14` 返回；
6. 结果作为 `tool` 消息回传给 LLM，LLM 再生成自然语言回答："等于 14"。

## 无参数工具的例子

`get_current_time` 不需要参数，所以 `parameters` 传的是 `createParameters()`（空参数）：

```java
registry.register(
    "get_current_time",
    "获取当前系统日期和时间。",
    createParameters(),  // 无参数，生成空 JSON Schema
    args -> { /* 返回当前时间 */ }
);
```

生成的 JSON Schema 就是：

```json
{
  "type": "object",
  "properties": {},
  "required": []
}
```

这样模型就知道调用这个工具不需要带任何参数。

## 为什么用 JsonNode 而不是自定义对象？

`parameters` 本质上就是一段 JSON Schema，而 `JsonNode` 就是 Jackson 里操作 JSON 树的通用类型。用 `JsonNode` 的好处：

1. **直接透传**：可以用 `createParameters()` 或 `ObjectMapper` 手动拼，也可以直接读一个 JSON Schema 文件；
2. **无需定义专门类**：JSON Schema 结构复杂，各种类型（string/integer/boolean/array/object）、嵌套、required、enum 等，如果用 Java 类表达会写很多 POJO；
3. **发送给 LLM 时直接序列化**：`getToolDefinitions()` 里把 `tool.parameters()` 直接塞进 `LlmClient.Tool`，由 `ObjectMapper` 拼进请求体，无额外转换。

## 参数可以写多个

`createParameters` 是变参方法，可以一次性定义多个参数：

```java
createParameters(
    new Param("city", "string", "城市名，例如：北京、上海"),
    new Param("date", "string", "日期，格式 yyyy-MM-dd")
)
```

这样模型会生成 `{"city": "...", "date": "..."}` 这样的 arguments 字符串。

## 一句话总结

`parameters` 不是给程序执行的参数，而是**给 LLM 看的"工具说明书"（JSON Schema）**。它告诉模型：调用这个工具时必须传什么字段、字段类型是什么。`JsonNode` 只是用来承载这段 JSON Schema 的数据类型，因为它灵活、不需要额外 POJO，可以直接被 `ObjectMapper` 序列化到请求体里。

> 参数校验和真正执行是在 `ToolExecutor.execute(Map<String, String> args)` 里完成的，那才是"参数的实际使用处"。
