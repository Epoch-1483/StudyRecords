# MCP 学习路径（从简单到困难）

> 目标：从零理解 MCP（Model Context Protocol），并能自己写 Server、接入 Agent。
> 学习方法：引导式 + 动手。每阶段先回答问题，再写代码验证。
> 创建：2026-07-14 ｜ 方向：Java 后端 + AI Agent

## 难度梯度总览

| 阶段 | 主题 | 做完的标志 |
|------|------|------------|
| L0 | 概念启蒙：为什么需要 MCP | 能用自己的话解释 Host / Client / Server 分别是谁 |
| L1 | 跑通最小例子 | 能说出 client.py 的三步调用流程 |
| L2 | 协议三件套：Tools / Resources / Prompts + 传输 | 能区分三类能力，说清 stdio 与 SSE/HTTP 区别 |
| L3 | 自己写有价值的 Server | 写出一个读文件 / 查 DB 的真实 MCP 工具 |
| L4 | 接进 Agent | 把 MCP Server 挂到你的 Agent 上被调用 |
| L5 | 进阶：Java SDK / 远程传输 / 安全 | 用 Java 写 Server，或部署成 HTTP 服务 |

---

## L0 概念启蒙

**引导问题：**
1. 你打开浏览器访问一个网站时，谁是客户端、谁是服务器、它们之间"说"的是什么（协议）？
2. 类比到 MCP：AI 应用（Host）要调一个"外部能力"（比如查数据库），谁是 Client、谁是 Server？
3. 在 MCP 出现之前，LangChain 的 `@Tool` 有什么不方便的地方？

**我的笔记 / 答案：**（2026-07-15 用户原答 + 导师核对）

1. 浏览器是客户端，后端接口是服务端，之间用 JSON 格式传数据。 ✅ 准确
2. AI 程序去调接口时，它扮演客户端。 ✅ 准确
3. `@Tool` 换框架大概不能直接用。 ✅ 直觉正确——这正是 MCP 要解决的痛点

> 导师批注：第 1 点补一层——HTTP 规定"怎么传"（请求/响应结构），JSON 规定"传的数据长什么样"，两者是不同层。第 3 点再推一步：MCP 把"工具适配"这层标准化成协议，Server 写一次、任何支持 MCP 的 Client 都能用，不用为每个框架重写工具。

---

## L1 跑通最小例子

参考已跑通的 `mcp_demo/`：
- `server.py`：用 `@mcp.tool()` 暴露 `add` / `greet`
- `client.py`：`StdioServerParameters` → `stdio_client` → `ClientSession` → `call_tool`

**引导问题：**
1. `client.py` 里"拉起 server 并调用工具"分哪三步？
2. 为什么 `server.py` 末尾要写 `if __name__ == "__main__": mcp.run()`？
3. `res.content[0].text` 为什么 IDE 会画红线（类型检查）？怎么消掉？

**我的笔记 / 答案：**（2026-07-15 用户原答 + 导师核对，L1 已过关）

1. server 是被 `stdio_client` **拉成子进程**运行，不是被 import。原因：只有被当脚本运行（`python server.py`）时 `__name__` 才是 `"__main__"`，`mcp.run()` 才启动监听；被 import 时 `__name__` 是模块名，`mcp.run()` 不执行。 ✅ 准确
2. `sys.executable` = 用哪个 Python 解释器；`args` = 执行哪个文件（server.py）；目的为了运行 `__main__` 里的 `mcp.run()`。 ✅ 准确
3. 先 `list_tools()` 查看有哪些工具可用，再 `call_tool`；类比 HTTP 的握手 / 探明能力。 ✅ 准确

> 红线收尾（`res.content[0].text`）：`content` 是多种内容类型的联合（TextContent / ImageContent / EmbeddedResource），IDE 不能确定 `content[0]` 必有 `.text`。消法：① `isinstance(res.content[0], TextContent)` 判断后取值（推荐，兼运行时安全）；② 行尾 `# type: ignore` 跳过检查。

---

## L2 协议三件套 + 传输

**引导问题：**
1. MCP Server 对外暴露的三类能力（Tools / Resources / Prompts）分别是什么、有什么区别？
2. `stdio` 和 `SSE / Streamable HTTP` 两种传输方式，分别在什么场景下用？

**我的笔记 / 答案：**（2026-07-15 用户原答 + 导师核对，L2 已过关）

1. 我们 demo 里的 `add` / `greet` 是用 `@mcp.tool()` 注册的，属于 **Tools 类**（模型能"调用"、有副作用的函数）。MCP Server 还能再暴露两类：**Resources**（给模型"读"、无副作用，如文件内容/配置）和 **Prompts**（预设好的提示词模板，给模型"套用"）。 ✅ 准确
2. 若 Server 跑在**远程机器**上、要被本地多个 Agent 连，`stdio` 不合适——因为 stdio 是"同机进程间通过标准输入输出对话"，跨机器用不了。应换成 **SSE / Streamable HTTP** 传输。 ✅ 准确
3. 类比 JavaWeb：`stdio` 像**本地进程间通信**（同一台机器两个进程对话）；`SSE / HTTP` 像**远程网络请求**（跨机器的 HTTP 调用）。 ✅ 准确

> 导师批注：三类能力一句话记——**Tools = 调（action）、Resources = 读（data）、Prompts = 套（template）**。注意 Resources 和 Tools 容易混：Tools 有"副作用"（写库、发邮件），Resources 是"只读"（取数据）。你 demo 只用了 Tools，L3 我们会写一个 Resources 版（读文件）加深区分。

---

## L3 自己写有价值的 Server

**引导问题：**
1. 你想让 MCP Server 暴露的第一个"真实工具"是什么？（读本地文件？查数据库？调某个 API？）
2. 工具函数的参数怎么声明、返回值长什么样？

**我的笔记 / 答案：**（2026-07-15 用户原答 + 导师核对，L3 已实现并跑通 ✅）

用户设计：
1. 第一个真实工具 = **读本地文件内容**。 ✅ 零依赖、立刻能验证，最适合入门
2. 输入 = 文件路径；输出 = 全文内容；出错 = 返回错误原因（不抛异常）。 ✅ 设计合理
3. 注册为 `@mcp.tool()`。用户直觉理由："需要防止一些意外情况"。

> 导师批注（修正第 3 点理由）：**Tool 与 Resource 的区别不在于"防不防意外"**——错误处理两者都要做。真实区别：
> - **Tool** = 模型主动"调用"的能力（像函数调用），`@mcp.tool()` 最常用、最通用；
> - **Resource** = 模型"读取"的地址化数据（像 `file:///xxx` 这种 URI），更适合"被动引用"。
> 选 `@mcp.tool()` 完全对，但正确理由是"它是个被调用的函数"，不是"防意外"。**防意外是所有工具都要写的基础功**（见下方实现）。

**实现（已写入 `mcp_demo/server.py`，client.py 已验证跑通）：**
- `read_file(path: str) -> str`：用 `try/except` 包住读取：
  - `FileNotFoundError` → 返回"文件不存在"
  - `PermissionError` → 返回"没有读取权限"
  - 其他 `Exception` → 返回"读取失败：{原因}"
- **路径穿越防护**：`ALLOWED_ROOT` 限定只能读 `mcp_demo/` 目录内；用 `os.path.realpath(path)` 解析 `../` 后检查是否仍在允许范围内，越界返回"拒绝访问"。（这是 L5 安全的雏形）
- 验证：`read_file(server.py)` 返回全文；`read_file(不存在的文件)` 返回 `❌ 文件不存在：...`，未崩溃。

---

## L4 接进 Agent

**引导问题：**
1. 你的 Agent（LangChain4J 那套）怎么把一个 MCP Server 当成一个"工具节点"挂上去？
2. 如果有多个 MCP Server，Agent 怎么决定调哪一个？

**我的笔记 / 答案：**（2026-07-15 已实现并跑通 ✅，Python 版 LangChain；因为该目录是 Python 代码，按用户要求用 LangChain 框架，对照 LangChain4J 讲解）

> 注：用户主战场是 Java（LangChain4J），本次为学 MCP 互操作用 Python LangChain 演示。概念完全互通。

实现（`mcp_demo/agent.py`，依赖 `langchain-openai` + `langchain-mcp-adapters` + `langgraph`）：
1. `MultiServerMCPClient({"read_file_server": {"command": sys.executable, "args": [server_path], "transport": "stdio"}})` —— **和 client.py 的 `StdioServerParameters` 是同一件事**：把 server.py 当子进程拉起。回忆 L1：必须子进程、不能 import。
2. `tools = await client.get_tools()` —— 把 MCP 工具变成 LangChain 的 Tool 列表。**这一步就是"MCP Server → Agent 工具节点"的桥**。
3. `ChatOpenAI(model="qwen-max", base_url="https://dashscope.aliyuncs.com/compatible-mode/v1")` —— 用 Qwen 走 OpenAI 兼容协议（即"模型层"）。
4. `agent = create_react_agent(llm, tools)` —— LLM + 工具 = 会自己调工具的 Agent。
5. `agent.ainvoke({"messages": "读取 server.py 并总结有几个工具"})` —— **只给自然语言任务，不告诉它去调 read_file**；调不调、调哪个、传什么参数，由 Agent 看工具描述自己决定（Tool Calling）。

验证结果（真实跑通）：
```
Agent 已加载工具： ['add', 'greet', 'read_file']
Agent 轨迹：
  Human → "读取 server.py，总结定义了几个工具"
  AI   → Tool Call: read_file(path=.../server.py)   ← Agent 自己决定调工具
  Tool → 返回 server.py 全文
  AI   → "该文件一共定义了 3 个工具：add / greet / read_file"   ← 读结果后总结
```
> 导师批注（对照 LangChain4J）：`MultiServerMCPClient≈McpToolProvider`、`get_tools≈getTools`、`create_react_agent≈ToolsAgent`、`ainvoke≈invoke`。**同一套思想，Java/Python 写法不同而已**。

> ⚠️ 已知小提示：`create_react_agent` 在 LangGraph V1.0 被标记 deprecated（将移到 `langchain.agents`），当前版本仍可正常用；不影响学习。

---

## L5 进阶

**引导问题：**
1. 用 Java（mcp-java-sdk）写一个 MCP Server，和 Python 版结构上有何异同？
2. 把 Server 部署成 HTTP 服务后，多个 Client 远程连，要注意什么（认证 / 权限 / 沙箱）？

**我的笔记 / 答案：**（2026-07-15 已实现并跑通 ✅，Java 版 mcp-java-sdk 2.0.0）

> 用户主战场是 Java，所以 L5 用官方 `mcp-java-sdk` 重写了一遍 `read_file`，和 Python 版 server.py 做结构对比。

项目目录：`D:\Workspace\Code_Test\Agent_study\mcp_java_server`（pom.xml + `src/main/java/com/example/mcp/ReadFileServer.java` + `test_java_server.py` 验证脚本）。

### 1) Java 版 vs Python 版结构对比
| 概念 | Python（FastMCP） | Java（mcp-java-sdk 2.0.0） |
|------|------|------|
| 依赖坐标 | `pip install mcp` | `io.modelcontextprotocol.sdk:mcp:2.0.0`（聚合包，内含 `mcp-core` + `mcp-json-jackson3`） |
| 传输层 | `mcp.run(transport="stdio")` | `new StdioServerTransportProvider(McpJsonDefaults.getMapper())` |
| 建 Server | 隐式（装饰器即注册） | `McpServer.sync(provider).serverInfo(...).capabilities(...).build()` 链式构建 |
| 注册工具 | `@mcp.tool()` 装饰函数 | `SyncToolSpecification.builder().tool(Tool.builder(name, mapper, jsonSchema).description(...).build()).callHandler((exchange, req) -> {...}).build()` 然后 `server.addTool(spec)` |
| 工具入参 schema | 函数参数 + 类型注解自动生成 | 必须显式给 JSON Schema 字符串（用 `Tool.builder(name, mapper, jsonString)` 重载） |
| 返回值 | `return "文本"` | `CallToolResult.builder().content(List.of(new McpSchema.TextContent(文本))).build()` |
| 错误处理 | `try/except` 返回人话 | 同样 `try/catch`，返回 `❌ ...` 文本（不抛异常） |

### 2) 踩坑记录（Java SDK 环境相关，新手必看）
- **包名没有 `.sdk`！** 真实包是 `io.modelcontextprotocol.server` / `io.modelcontextprotocol.spec` / `io.modelcontextprotocol.json`（不是 `io.modelcontextprotocol.sdk.*`）。`Tool`/`CallToolResult`/`TextContent`/`ServerCapabilities` 全是 `McpSchema` 的**嵌套类**（用 `McpSchema.Tool` 等）。
- `StdioServerTransportProvider` 在 **`io.modelcontextprotocol.server.transport`** 子包。
- `Tool.builder` 有三个重载，最省事的是 `builder(String name, McpJsonMapper mapper, String jsonSchema)` —— 直接吃 JSON 字符串，不用自己 `readTree`。
- `mcp` 聚合包本身只有 1.8KB，真正代码在 `mcp-core-2.0.0.jar`（所谓"便捷包"只是把 core + jackson3 聚一起）。
- **本地 Maven 环境坑**：机器上 `MAVEN_HOME` 指向的 `apache-maven-3.9.14` 的 `bin/mvn` 脚本在 Git Bash 下会因 `/d/...` 路径不被 Windows 版 java 识别而报 `ClassNotFoundException: classworlds.Launcher`。**解法**：用 PowerShell 调 `mvn.cmd`（它内部用 `%~dp0` 生成原生 Windows 路径）；或设 `MAVEN_HOME` 为 Windows 风格路径后走 `cmd`。本地仓库被 `settings.xml` 改到了 `D:\Workspace\DevTools\m2_repository`。

### 3) 验证结果（真实跑通，Python 客户端拉起 Java Server）
```
TOOLS: ['read_file']                       ← 工具被发现
READ_OK: True                             ← 读回自己源码首行 "package com.example.mcp;"
MISSING_ERR: True                         ← 读不存在文件返回 "❌ 文件不存在" 不崩溃
TRAVERSAL_BLOCKED: True                   ← 路径穿越被 "❌ 拒绝访问" 拦下
```
> 学以致用：`mcp_demo/.venv` 里的 Python `mcp` SDK 当客户端，把 Java Server 当子进程 `java -cp <classpath> com.example.mcp.ReadFileServer` 拉起 —— **证明"跨语言 MCP 互操作"成立**：Python 写的客户端能无缝调 Java 写的 Server。这正呼应前面学的"MCP 让 Server 写一次、任意客户端都能用"。

---

## 关联
- 已跑通的 demo：项目目录 `D:\Workspace\Code_Test\Agent_study\mcp_demo`
- 前置知识：Agent 基础、LangChain4J 的 `@Tool`、Python 异步（`async/await`）
- 学习原则：每个阶段先回答问题，再动手验证，不跳级


---

## 🔗 关联笔记
- [[MCP与JSON-RPC]]
- [[Java后端转AI Agent 技能分层清单]]
