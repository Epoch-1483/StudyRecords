> 📇 返回 [[《PaiCLI》项目学习笔记]]

# ReAct 主循环（Agent.run）

PaiCLI 的 ReAct 核心循环在 `src/main/java/com/paicli/agent/Agent.java` 的 `run(userInput)` 里。整体是「循环前准备 + 一个 `while(true)`」，靠 `conversationHistory` 持续变长把每一轮的「思考 → 行动 → 观察」串成链条回灌给模型。

![PaiCLI ReAct 主循环完整流程图|637](images/react-loop-whiteboard.svg)

> 上图按 `Agent.java` 真实代码绘制：`while(true)` 循环体内依次是「取消检查 → 历史压缩 → budget 检查 → chat() 思考/行动 → hasToolCalls? 分流 → 执行工具回写历史 / 写最终答案」。绿色虚线弧表示「下一轮迭代」回路。

## 一、整体结构：前置准备 + while(true)

**1. 进入循环前的准备（`:129-149`）**
- `pruneHistoricalImagePayloads()` 清掉历史里体积大的图片载荷（省 token）
- `memoryManager.addUserMessage(userInput)` 存短期记忆
- `getContextProfile()` + `buildContextForQuery()` **检索长期记忆**，经 `updateSystemPromptWithMemory()` 注入 system prompt
- `conversationHistory.add(... userMessage ...)` 把用户输入追加进对话历史
- 初始化 `budget`（token / 轮数预算）

**2. 主循环 `while (true)`（`:153`）** —— ReAct 循环本体。

## 二、循环怎么「转起来」

关键一句话：**`conversationHistory` 是贯穿所有轮次的唯一状态载体。**

- 每轮开始，`llmClient.chat(conversationHistory, toolDefinitions, ...)`（`:183`）把**整个历史**发给模型；
- 模型若决定调工具，就把「带 `tool_calls` 的 assistant 消息」和「工具结果消息」追加进**同一个 history**（`:204`、`:219`）；
- 下一轮 `chat()` 又带着变长后的 history 重发——模型于是「看到了」上一轮自己做了什么、拿到了什么结果，接着推理。

所以循环不是靠计数器硬转，而是**靠历史自己变长把「思考→行动→观察」串成链条回灌**。`continue`（`:225`）就是「这一轮还有工具结果要消化，再来一轮」。

## 三、一轮里的「思考 → 行动 → 观察」

| 阶段 | 代码位置 | 做的事 |
|------|---------|--------|
| 思考 THINK | `:183` `llmClient.chat(...)` | 把 history + 工具定义发给模型，拿回 `ChatResponse`（含 reasoning / content / toolCalls）。模型在这里「决定下一步调什么工具」 |
| 行动 ACT | `:216` `executeToolCalls(...)` → `toolRegistry.executeTools(...)` | 把每个 `ToolCall` 包成 `ToolInvocation`，真正执行工具。**HITL 审批就在这里触发**（危险工具 / 外部 MCP 在执行前弹确认）。多工具可并行 |
| 观察 OBSERVE | `:217-220` `conversationHistory.add(Message.tool(id, result))` | 每个工具结果用 `toolResult.id()` 配对回对应 tool_call，作为 tool 消息写回 history；同时 `memoryManager.addToolResult(...)` 记进短期记忆。这就是下一轮 THINK 的「Observation」输入 |

> 注意顺序：先 `:204` 把「我要调这些工具」的 assistant 消息写进历史（保留 `id`），再 `:216` 执行，再 `:219` 把结果按 `id` 回填——这正是 [[请求响应配对]] 里 `tool_call_id` 的落地。

## 四、循环什么时候停

1. **主退出 = 模型自己决定**：当 `response.hasToolCalls()` 为 `false`（`:199`）时走 `else` 分支（`:228-252`）——写最终答案、存记忆、记 token，直接 `return`。ReAct 天然以「模型不再调工具」作为任务完成信号。
2. **兜底 = budget / 取消**：每轮开头 `budget.check()`（`:164`）与两处 `CancellationContext.isCancelled()`（`:154`、`:189`）只在异常时提前 `return`。详见 [[ReAct循环退出条件]] 与 [[ReAct循环保险阀]]。

另外 `maybeCompactHistory()`（`:163`）在每次调 LLM 前把过长的早期历史压成摘要，保证窗口不爆。

## 一句话总结

`run()` 用一个 `while(true)`，靠 `conversationHistory` 持续增长把每轮的（assistant 工具意图 + tool 结果）串回去；一轮内 THINK=`chat()`、ACT=`executeToolCalls`、OBSERVE=把结果 `add` 回 history；模型不再返回 toolCalls 就写出最终答案退出，budget 只作兜底。

## 相关
- [[请求响应配对]] —— tool_call_id 如何把工具结果绑回对应调用
- [[ReAct循环退出条件]] —— 为什么退出交给 LLM 而非固定轮数
- [[ReAct循环保险阀]] —— 兜底四阀的触发条件与优先级
- [[HITL全部放行双维度]] —— ACT 阶段的工具审批机制
- [[Function Calling工具定义]] —— 工具定义如何让模型产出 toolCalls
