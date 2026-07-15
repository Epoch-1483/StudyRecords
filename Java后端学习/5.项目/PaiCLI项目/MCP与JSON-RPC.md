> 📇 返回 [[《PaiCLI》项目学习笔记]]

# MCP 与 JSON-RPC

MCP（Model Context Protocol）让 Agent 接入外部工具/数据源。PaiCLI 手写 JSON-RPC 2.0 客户端对接 MCP server。

## 为什么需要 MCP
把「工具接入」标准化：Agent 不必为每个外部系统写一套适配，统一走 MCP 协议即可复用社区 server（文件系统、Chrome DevTools 等）。

## 传输方式
- **stdio**：子进程通过 stdin/stdout 收发 JSON-RPC；`StdioTransport` 关闭用三级降级（stdin 关 → 等 1s → destroy → 等 2s → destroyForcibly）。
- **Streamable HTTP**：`StreamableHttpTransport` 用 OkHttp 发 POST，响应 `text/event-stream` 时按 SSE 解析（data: 行以空行分隔）。

## 异步配对
`JsonRpcClient` 用 `AtomicLong` 生成请求 id，`ConcurrentHashMap<Long, CompletableFuture<JsonNode>>` 暂存待响应，`scheduler` 守护线程处理超时；`handleMessage` 按 id 配对响应，`sendNotification` 是 fire-and-forget。

## 并发与安全
- 并发安全：`ConcurrentHashMap` / `AtomicLong` / 守护线程 + 超时调度。
- 自动清理 LLM 不兼容的 JSON Schema 方言，`description` 截断至 1000 字符。
- 多 server 启动 8s 超时非阻塞；联网工具内置 [[SSRF安全防护]] 拦截内网。
- 提供基于 Chrome DevTools Protocol 的浏览器工具（处理 SPA / JS 渲染页）。

## 配置位置
- 用户级：`~/.paicli/mcp.json`（首次运行 jar 自动创建，含 chrome-devtools）
- 项目级：`.paicli/mcp.json`（项目根，可覆盖/补充）
- 合并后支持 `${VAR}` 环境变量展开（`${PROJECT_DIR}` / `${HOME}` / 系统变量 / `.env`）。
