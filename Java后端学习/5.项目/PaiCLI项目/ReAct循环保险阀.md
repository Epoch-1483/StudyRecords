> 📇 返回 [[《PaiCLI》项目学习笔记]]

# ReAct 循环保险阀：触发条件与优先级

ReAct 循环的兜底退出机制，实现分布在 `AgentBudget.java`（三阀）与 `Agent.java:153-172`（取消阀 + 调用）。它们**只在「模型持续调工具、不肯自己停」时才可能上场**；模型主动停就走主退出（见 [[ReAct循环退出条件]]），兜底永不抢戏。

![520](images/react-safety-valves.svg)

## 结构：1 个架构外最高阀 + budget 内部 3 个阀

容易误以为「三道阀都在 budget 里、平级」。真实结构是：**用户取消 `CancellationContext` 是架构外、独立的最高优先级检查**，不在 `budget.check()` 里；其余三个才在 `budget.check()` 内部，且有**固定先后**。

## 逐个触发条件

**① 用户取消 `CancellationContext` —— 最高优先级，架构外**
- 触发：用户 Ctrl+C / 点取消，外部把取消标志置位。
- 两处检查点（`Agent.java`）：`:154` 循环顶部每轮第一件事就查（连 `budget.check()` 都轮不到）；`:189` `chat()` 刚返回、还没处理工具结果前再查一次（生成中取消也不会执行本要跑的工具）。
- 动作：`return "⏹️ 已取消当前任务。"`。

**② 停滞检测 `STAGNATION_DETECTED` —— budget 第一分支 `:124`**
- 触发（`recordToolCalls` `:107-121`）：取每轮工具调用的「工具名＋参数」拼成签名 `signatureOf`（`:178-184`），维护最近 `stagnationWindow`（默认 **3**）个签名的滑动窗口；窗口满且**全部相同** → `stagnant=true`。
- **关键：是严格连续相同判定，不是「两工具 A↔B 振荡」检测**。A→B→A→B 只要参数不同，签名就不同，窗口不会全匹配 → 停滞检测抓不到，得靠第 ④ 道硬轮数拦。真正能抓的是「同一工具、同一套参数连调 3 轮」。
- 动作：`return "❌ 检测到连续 N 轮重复的工具调用，疑似死循环，已强制收尾"`。

**③ Token 预算 `TOKEN_BUDGET_EXCEEDED` —— budget 第二分支 `:127`**
- 触发：`totalInputTokens + totalOutputTokens >= tokenBudget`。
- **关键事实：默认 `tokenBudget = Integer.MAX_VALUE`（`:80`），实质是关闭的！** 只有显式 `-Dpaicli.react.token.budget=N` 才生效（类注释 `:28-31`：长上下文模型 + 套餐用户无限 token 诉求，默认不卡 token 墙，让 LLM 自然停；CI / 批跑要严控成本再开启）。
- 动作：`return "❌ Token 预算已用尽（x/y），任务被强制收尾"`。

**④ 硬轮数 `HARD_ITERATION_LIMIT` —— budget 第三分支 `:130`**
- 触发：`iteration >= hardMaxIterations`，默认 **50**（`:43`、`:82`）。最后一道地板：即使 token 无限、也没死循环，跑满 50 轮也强制停。
- 动作：`return "❌ 达到硬轮数上限（50），已强制收尾"`。

## 优先级怎么排

按循环体实际执行顺序（`Agent.java:153-172`）：

```
while(true):
  if (CancellationContext.isCancelled()) return;   // :154 ← 最高，先拦
  maybeCompactHistory();
  ExitReason r = budget.check();                    // :164
      if (stagnant)                       return STAGNATION_DETECTED;   // :124 ②
      if (tokens >= tokenBudget)          return TOKEN_BUDGET_EXCEEDED; // :127 ③
      if (iteration >= hardMaxIterations) return HARD_ITERATION_LIMIT;  // :130 ④
  ... chat() ...
  if (CancellationContext.isCancelled()) return;   // :189 ← 生成中取消也能拦
```

**有效优先级：① 用户取消 ＞ ② 停滞 ＞ ③ Token ＞ ④ 硬轮数。** 类注释 `:21` 的「先到先触发」，指 `check()` 里这三个 `if` 的先后——同时命中多个时靠前分支赢。三者本质不同维度（重复 / 累计量 / 计数），实际极少同时命中。

## 默认配置下真正「在岗」的阀

**默认 `tokenBudget = MAX_VALUE`，Token 阀是关的。** 开箱即用时真正会触发的兜底只有两道：**停滞（连续 3 轮相同调用）** 和 **硬轮数（50 轮）**。Token 阀留给 CI / 自动化批跑，用 `-Dpaicli.react.token.budget=N` 显式开启。

## 相关
- [[ReAct循环退出条件]] —— 为什么退出交给 LLM、budget 是保险丝
- [[ReAct主循环]] —— run() 的整体结构，budget.check 的调用点
- [[Prompt注入防御]] —— 执行侧护栏与「LLM 不可信」哲学
