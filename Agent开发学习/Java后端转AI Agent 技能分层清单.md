---
tags: [Agent, 学习路线, Java后端]
---

# Java 后端转 AI Agent · 技能分层清单

> 适用对象：2028 届、Java 后端方向、已在学 LangChain4J 的同学。
> 核心判断：**主战场留 Java，Python 浅尝即可，协议/架构层语言无关最该下功夫。**
> 关联笔记：[[MCP学习路径]]

---

## 总览：三层模型

| 层 | 定位 | 深度 | 目标 |
|----|------|------|------|
| **A 层 · Java 深学** | 你的主战场，用它交付 Agent | 精通 | 能独立做生产级 Java Agent |
| **B 层 · Python 浅尝** | 消费生态、跑原型 | 够用 | 能读、能跑、能写极简脚本 |
| **C 层 · 语言无关内核** | 真正决定上限的东西 | 精通 | 换语言只是换语法 |

---

## A 层 · Java 深学（必须，且要精）

- [ ] **Spring Boot / Spring Cloud Alibaba**（你已会 SSM/SpringBoot，巩固即可）
      > 这是你接 Agent 的底座，企业落地全在这套上。
- [ ] **LangChain4J**（已在学）
      > Chain / Tool / Memory / Retriever 概念与 Python LangChain 互通。继续吃透 `@Tool`、ChatMemory、RAG。
- [ ] **Spring AI**（强烈建议补）
      > 与 Spring Boot 无缝集成，内置 ChatClient、Tool Calling、MCP 支持。校招差异化关键。
- [ ] **Spring AI MCP / mcp-java-sdk**
      > 把 MCP Server/Client 写进 Java 工程。对应你 [[MCP学习路径]] 的 L4/L5。
- [ ] **工程化能力**（你已有 Docker/Maven/Git/RabbitMQ）
      > Agent 的测试、部署、可观测（日志/链路追踪）、限流。企业最看重这部分。
- [ ] **向量库 & RAG**（你已会 ES、MongoDB）
      > 把 ES / 向量检索接成 RAG 检索器；Redis 做对话 Memory 缓存。

## B 层 · Python 浅尝（够用就好，别深陷）

- [ ] **能读懂 Python MCP Server 源码 + `mcp.json` 配置**
      > 社区大量现成 Server 是 Python/TS，你得会接。
- [ ] **能本地 `python server.py` 拉起并验证一个 MCP Server**
      > 参考 `mcp_demo/`（你已跑通过 stdio 模式）。
- [ ] **能跑通官方 SDK 的最小原型**（如 DashScope / OpenAI 兼容调用）
      > 试新模型时 Python 最快。
- [ ] **能写极简脚本**（文件处理、调 API、数据清洗）

> ❌ **不必花时间**：Django / FastAPI 深学、Python 异步框架原理、Python 性能调优、类型系统深究。

## C 层 · 语言无关内核（最该下功夫，决定上限）

- [ ] **Agent 架构范式**：ReAct、Plan-and-Execute、多 Agent 协作、反射/自省循环
- [ ] **Tool Calling / Function Calling**：模型如何决定调工具、参数怎么填
- [ ] **MCP 协议**：Host/Client/Server、Tools/Resources/Prompts、stdio vs HTTP（见 [[MCP学习路径]]）
- [ ] **RAG 全链路**：切分、embedding、检索、重排、生成、评测
- [ ] **Prompt 工程**：Few-Shot、角色设定、结构化输出、约束
- [ ] **多模态对齐**：共享表示空间、跨模态理解与生成（你已学过的概念）
- [ ] **Agent 评测与成本**：怎么衡量 Agent 好坏、token/延迟/费用优化

> 这一层 Java 和 Python 写法不同、思想完全一样。**把 C 层吃透，换语言只是换语法。**

---

## 时间线（大二下 → 大四）

- **大二下~大三上（现在）**：A 层 LangChain4J + Spring Boot 巩固；C 层 MCP/RAG 概念入门（跟 [[MCP学习路径]] 走）。
- **大三上~下**：A 层补 Spring AI + Spring AI MCP；C 层做 1~2 个完整 Agent 项目（接 RAG + 工具）。
- **大三暑假**：冲大厂**暑期实习**（最重要入口，表现好转正≈提前批上岸）。
- **大三下~大四上**：B 层浅尝（能读能跑 Python MCP）；投提前批 + 秋招。
- **大四下**：春招兜底。

---

## 一句话自检

> 校招时你的牌 = **Java 工程能力 + Agent 实战 + 懂 MCP 协议（能跨语言消费生态）**。
> 这比"纯 Python Agent 选手"更稀缺，因为企业 Agent 大多要嵌进现有 Java 后端。
