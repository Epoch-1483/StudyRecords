# ToolRegistry 为什么把 JSON 参数解析为 Map<String, String>

> 关联：[[ToolRegistry中parameters参数的作用]]、[[GLMClient中的ObjectMapper]]、[[JsonNode与各类Node的关系]]

## 问题背景

在 `ToolRegistry.executeTool()` 中，大模型返回的 `tool_call.arguments` 是一个 JSON 字符串，例如：

```json
{"expression": "2+3*4", "precision": 2}
```

代码里通过 `parseArguments(argsJson)` 把它解析成 `Map<String, String>`，而不是某个具体的 Java 对象。

## 为什么要解析成 Map？

### 1. 工具参数是动态的、运行时才确定

`ToolRegistry` 是一个通用注册中心，它要支持**各种各样**的工具：
- `calculator` 需要 `expression`
- `get_weather` 可能需要 `city` 和 `date`
- `send_email` 可能需要 `to`、`subject`、`body`

如果为每个工具都写一个对应的 Java 对象（`CalculatorArgs`、`WeatherArgs`、`EmailArgs`），那么 `ToolRegistry` 就必须知道所有工具的具体参数类型，严重违反"通用注册中心"的设计。用 `Map<String, String>` 可以**统一接收任意工具的参数**。

### 2. ToolExecutor 接口签名的需要

`ToolExecutor` 被定义成函数式接口：

```java
public interface ToolExecutor {
    String execute(Map<String, String> args);
}
```

所有工具的执行器都按这个签名写。`Map<String, String>` 是最通用的形式——不管你注册什么工具，参数都按"名→值"传进来，执行器自己按需取用和转换。

### 3. 简化 demo，避免大量 POJO

PaiCLI 是一个 demo 项目，核心想展示的是 ReAct + Function Calling 流程。如果每加一个工具就要新写一个 Args 类，会增加很多样板代码，偏离重点。`Map<String, String>` 足够表达"模型给了我一组键值对参数"。

### 4. 参数值统一按字符串处理足够用

代码里把每个 JSON 字段的值都用 `.asText()` 转成字符串：

```java
result.put(entry.getKey(), entry.getValue().asText());
```

这是因为对于简单工具来说，参数基本都是字符串或数字。执行器需要时再自行转换：

```java
String expr = args.get("expression");          // 直接当字符串用
int precision = Integer.parseInt(args.get("precision")); // 需要时再转 int
```

这样 `parseArguments` 不必关心参数到底是什么类型，保持简单。

## 实际流转示例

假设用户问"北京今天天气怎么样"，模型生成 tool_call：

```json
{
  "name": "get_weather",
  "arguments": "{\"city\": \"北京\", \"date\": \"2026-07-15\"}"
}
```

`parseArguments` 解析后得到：

```java
Map<String, String> args = Map.of(
    "city", "北京",
    "date", "2026-07-15"
);
```

执行器这样用：

```java
args -> {
    String city = args.get("city");
    String date = args.get("date");
    // 调用天气 API...
    return "北京 2026-07-15 晴 25℃";
}
```

## 如果不用 Map，可以怎么做？

| 方案 | 优点 | 缺点 |
|------|------|------|
| `Map<String, String>`（当前） | 通用、无样板、适合动态工具 | 类型不安全，需要手动转换 |
| 每个工具一个 Args POJO | 类型安全、IDE 补全 | 工具一多 POJO 爆炸 |
| 直接用 `JsonNode` | 保留类型信息 | 执行器需要懂 Jackson API |

当前项目选 `Map<String, String>` 是**简单 demo 的合理权衡**。如果要做成企业级框架，可以走"每个工具一个 Args 类 + 泛型 + 反射/序列化"的路线，但代价是复杂度上升。

## 一句话总结

把 JSON 参数解析成 `Map<String, String>` 是因为 `ToolRegistry` 是**通用工具注册中心**，它需要同时支持各种不同参数的工具；`Map` 是最轻量、最通用的参数容器，执行器按需取字段、自行转换类型即可。这是 demo 级实现里的典型权衡。
