> 📇 返回 [[求职项目MOC]]

# PaiCLI 项目学习笔记（MOC）

> 围绕 PaiCLI（类 Claude Code 的 Java Agent CLI）展开的概念笔记，按主题拆分、互相链接。每条结论尽量可回溯到源码（`src/main/java/com/paicli/`）。
> 本页是索引（Map of Content），概念细节在下方各链接页面。

## 核心概念
- [[RAG语义检索]] —— JavaParser 多粒度分块 + Embedding + SQLite + 三级混合检索，封装为 `search_code`
- [[MCP与JSON-RPC]] —— 手写 JSON-RPC 2.0 客户端、stdio/HTTP 双传输、守护线程、SSRF 防护
- [[Function Calling工具定义]] —— 工具的 name / description / parameters 各自回答什么问题
- [[Embedding与RAG配置]] —— Ollama 本地 vs OpenAI 兼容远程、维度由模型决定、换模型需重索引
- [[长上下文与RAG]] —— 长上下文不取代 RAG，二者是「想得深」与「找得准」的分工
- [[Prompt Caching]] —— 缓存不变前缀的 KV，以存代算换成本与首字延迟
- [[web_search与web_fetch]] —— 搜索找地址、抓取读正文，两步协作
- [[SSRF安全防护]] —— 联网工具拦截内网/环回地址，防服务端请求伪造
- [[SPA与Jsoup]] —— SPA 靠 JS 渲染、Jsoup 只解析静态 HTML，故拿不到渲染后 DOM
- [[反爬与CDP边界]] —— CDP 只破反爬最外层 JS 渲染，headless 反而是 bot 信号
- [[HITL全部放行双维度]] —— 放行按「工具 / server」两维度，信任粒度不同
- [[Prompt注入防御]] —— 注入不能根治，只能纵深防御，执行侧是最后兜底
- [[请求响应配对]] —— ReAct 的 tool_call_id 与 MCP JSON-RPC 的 id+future 两套配对机制
- [[ReAct主循环]] —— Agent.run 的 while(true)，靠 history 串起 思考→行动→观察
- [[ReAct循环退出条件]] —— 主退出交给 LLM 语义判断，固定轮数只作兜底
- [[ReAct循环保险阀]] —— 取消／停滞／Token／硬轮数四阀的触发条件与优先级
- [[并行工具执行与HITL]] —— 4 工具 FixedThreadPool 并行 × synchronized 审批串行化 × 双层超时
- [[守护线程-Daemon]] —— 工具线程全部 setDaemon(true)，JVM 退出干净；finally shutdownNow + daemon 兜底 + shutdown hook 三道防御

## 更新记录
- 2026-07-10 初始化：根据 7/9–7/10 关于 RAG / MCP / 工具定义 / Embedding / 长上下文 / Prompt Caching / 联网工具 / SSRF 的对话建立本 MOC 与 8 个概念页
- 2026-07-10 补充：SPA与Jsoup / 反爬与CDP边界 / HITL全部放行双维度 / Prompt注入防御 4 个概念页，并将对应讲解图存入 `images/`（约定：show_widget 生成的图一并入 KB）
- 2026-07-10 无新增：本次检索 7/3–7/10 共 5 组查询（RAG/MCP/工具定义/Embedding/SSRF/Prompt Caching/联网工具/HITL/Prompt注入/源码架构）均无新对话命中，知识库维持现状
- 2026-07-10 手动入库：用户说「入知识库」，将「请求响应配对」讲解页（含 request-response-pairing.svg 对比图）写入 KB，MOC 已挂链；采用手动触发模式（删除自动化后）
- 2026-07-10 手动入库：ReAct 系列 3 页——[[ReAct主循环]]（Agent.run 结构）/ [[ReAct循环退出条件]]（为何交 LLM 而非固定轮数）/ [[ReAct循环保险阀]]（取消>停滞>Token>硬轮数四阀优先级，含纠错：停滞是严格连续相同签名判定、Token 阀默认关闭），各含内联样式 SVG（react-main-loop / react-exit-condition / react-safety-valves）
- 2026-07-11 手动入库：[[并行工具执行与HITL]]（FixedThreadPool(4) 并行执行 × synchronized requestApproval 弹窗串行化 × 双层超时：单工具命令超时 + 批次 invokeAll 90s；结果按原序回填 history），含 parallel-hitl-timeout.svg；行号已回源验证 ToolRegistry.java:63/1226/1227/1246、Agent.java:678/217-220
- 2026-07-11 手动入库：[[守护线程-Daemon]]（ToolRegistry.java:1226-1231 线程工厂 t.setDaemon(true)；全量干活线程均为 daemon，仅 main 入口与 Main.java:292/324/326/879 四个 shutdown hook 非 daemon；三道退出防御：finally{shutdownNow()} + daemon 兜底强杀 + shutdown hook 清理），含 daemon-jvm-exit.svg；行号已回源验证 ToolRegistry.java:1229/1277、Main.java:292/324/326/879/1051/1112、McpServerManager.java:95/176、StdioTransport.java:141/160 等
