> 📇 返回 [[《PaiCLI》项目学习笔记]]

# Function Calling 工具定义

Agent 把可用工具定义塞进 LLM 请求，模型决定调用哪个并产出结构化 `arguments`；运行时按参数名取值执行。

## name / description / parameters 各管什么
| 字段 | 回答的问题 | 给谁看 |
|------|-----------|--------|
| `name` | 工具叫什么、运行时按它路由 | 框架（runtime） |
| `description` | 什么时候用、能干啥 | LLM（决策是否调用） |
| `parameters` | 传什么、什么类型、哪些必填（JSON Schema） | LLM + 框架（填表 & 校验） |

一句话：name+description 解决「要不要调、调哪个」；parameters 解决「调的时候怎么传参」。

## 为什么不能只有 name+description
LLM **看不到你的 Java 代码**，只收到工具定义 JSON。没有 `parameters`：模型不知道该传 `query` 还是 `keyword`、类型对不对、必填项有没有漏 → 无法结构化提取，Function Calling 机制崩塌。parameters 是「模型输出」与「代码输入」之间唯一的契约桥梁。

## 协议形态
```json
{ "type": "function",
  "function": { "name": "web_search",
    "description": "搜索互联网…",
    "parameters": { "type":"object",
      "properties": { "query":{"type":"string"}, "top_k":{"type":"integer"} },
      "required": ["query"] } } }
```
模型据此生成 `{"query":"Java 21","top_k":5}`，代码用 `args.get("query")` 取值。`true/false` 的必填标志对应 `required` 数组。

## 在 PaiCLI
`ToolRegistry` 用 `createParameters(new Param("query","string","…",true), new Param("top_k","integer","…",false))` 把 `required` 编译成上面的 JSON Schema。例见 [[web_search与web_fetch]] 的 `web_search` / `web_fetch` 定义。
