# 📑 全量笔记索引（wiki-index）

> LLM Wiki 式目录：每篇一句话摘要，按领域分组。配合 [[INDEX]] 总入口与 [[MOC]] / [[求职项目MOC]] 使用。
> 共 123 篇笔记。生成于 2026-07-15。

## Java后端学习（118 篇）

- [[Java8新特性]] — - 函数式编程范式第一次进入 Java
- [[JavaSE基础完整笔记]] — - [[多线程]] — 进程/线程、实现方式、线程安全、线程池、JUC
- [[IO流]] — 
- [[Java爬取网站姓名]] — 
- [[FIleReader]] — 
- [[FileWriter]] — 
- [[Java中的编码和解码]] — 
- [[字符打印流（PrintWriter）]] — 
- [[字符流]] — 
- [[字符缓冲流]] — 
- [[计算机存储规则]] — 
- [[转换流]] — 
- [[FileInputStream的作用]] — 
- [[FileOutputStream的作用]] — 
- [[IO流中的异常处理]] — 
- [[压缩流]] — 
- [[反序列化流]] — 
- [[字节打印流（PrintStream）]] — 
- [[字节缓冲流]] — 
- [[序列化流]] — 
- [[文件拷贝]] — 
- [[解压缩流]] — 
- [[对字符流和字节流的思考]] — 
- [[Commons-io]] — 
- [[Hutool]] — 
- [[常用工具包]] — 
- [[打印流]] — 
- [[缓冲流]] — 
- [[Javase]] — 
- [[动态代理]] — 
- [[利用反射获取成员变量]] — 
- [[利用反射获取成员方法]] — 
- [[利用反射获取构造方法]] — 
- [[反射]] — 
- [[反射的作用]] — 
- [[获取class对象的三种方式]] — 
- [[同步方法（锁）]] — 
- [[多线程]] — 
- [[多线程的实现方式]] — 
- [[常见的成员方法]] — 
- [[并发或并行]] — 
- [[等待唤醒机制]] — 
- [[线程安全问题]] — 
- [[线程池]] — 
- [[线程池核心要点]] — 传统方式"用到线程时创建、用完即销毁"，频繁创建/销毁开销大（见 [[线程池]]）。线程池复用线程：任务提交时若池中没有
- [[线程的6种状态]] — 
- [[线程的生命周期]] — 
- [[IP]] — 
- [[TCP协议]] — 
- [[UDP协议]] — 
- [[协议]] — 
- [[端口号]] — 
- [[网络编程]] — 
- [[网络编程三要素]] — 
- [[静态变量static]] — 
- [[Java基础知识扩展]] — Java 是一种 **编译型与解释型相结合** 的语言，更准确地说，它是一种 **“先编译、后解释（或即时编译）”** 
- [[JavaWeb笔记]] — - **概念**：Hyper Text Transfer Protocol，超文本传输协议，规定了浏览器和服务器之间数据
- [[Mybatis-Plus笔记]] — 
- [[Mybatis笔记]] — - 在文献中看到的framework被翻译为框架
- [[Spring6笔记]] — 阅读以下代码：
- [[SpringBoot2笔记]] — 在基础篇中，能够使用SpringBoot搭建基于SpringBoot的web项目开发，所以内容设置较少，主要包含如下内容
- [[SpringMVC笔记]] — MVC 是一种软件架构模式（是一种软件架构设计思想）
- [[SpringSecurity笔记]] — ---
- [[Spring框架注解详解]] — JAR（Java Archive）包和 WAR（Web Application Archive）包都是 Java 应用程
- [[Elasticsearch笔记]] — Lucene是一个Java语言的搜索引擎类库，是Apache公司的顶级项目，由Doug Cutting于1999年研发。
- [[MongoDB笔记]] — 1
- [[MySQL笔记]] — 
- [[RabbitMQ笔记]] — ![](../../图片/3.默认图片/1777118605463-948a5bba-e199-4d29-be9d-9f
- [[Redis笔记]] — ---
- [[RocketMQ笔记]] — ![](../../图片/3.默认图片/1776243754076-64ae6ed2-cdbf-4f7a-9da1-2f
- [[数据库与中间件]] — 排序规则决定了：
- [[黑马点评（Redis 企业实战）]] — 1. **导入资料提供的 SQL 文件：**
- [[Docker笔记]] — Docker： 快速构建、运行、管理应用的工具
- [[Git笔记]] — 在项目开发过程中，项目每开发到一个节点就会对当前项目进行备份，这个备份就是项目的一个版本；当我们继续开发一个阶段后，再次
- [[Linux笔记]] — Linux由林纳斯·托瓦兹在1991年创立并发展至今，成为**服务器操作系统领域**的核心系统。
- [[Maven笔记-补充篇]] — - [http://maven.apache.org/download.cgi](http://maven.apache
- [[Maven笔记]] — ![](../../图片/3.默认图片/1774952299184-7318484c-7b9e-434b-9835-d9
- [[Embedding与RAG配置]] — `EmbeddingClient` 统一封装两种 Embedding 来源，由 4 个环境变量切换。
- [[Function Calling工具定义]] — Agent 把可用工具定义塞进 LLM 请求，模型决定调用哪个并产出结构化 `arguments`；运行时按参数名取值执
- [[GLMClient中的ObjectMapper]] — `ObjectMapper` 是 Jackson（Java 最主流的 JSON 处理库）的**核心门面类**。所有"Ja
- [[HITL全部放行双维度]] — 放行判定在 `HitlToolRegistry.java:48-51`：
- [[MCP与JSON-RPC]] — MCP（Model Context Protocol）让 Agent 接入外部工具/数据源。PaiCLI 手写 JSON
- [[PaiCLI-Windows终端兼容性解决方案]] — [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
- [[Prompt Caching]] — Prompt Caching（提示词缓存）：把请求里重复不变的前缀（system prompt、工具定义、长文档）在服务
- [[Prompt注入防御]] — LLM 上下文里「系统指令」和「待处理数据」是同一串 token，无硬件级特权隔离（不像 CPU 内核态/用户态）。外部
- [[RAG语义检索]] — PaiCLI 的 RAG 代码库检索（`rag/` 包）让 Agent 用自然语言查找相关代码块，封装为 `search
- [[ReAct主循环]] — PaiCLI 的 ReAct 核心循环在 `src/main/java/com/paicli/agent/Agent.j
- [[ReAct循环保险阀]] — ReAct 循环的兜底退出机制，实现分布在 `AgentBudget.java`（三阀）与 `Agent.java:15
- [[ReAct循环退出条件]] — PaiCLI 的 ReAct 循环把**主退出条件交给模型语义判断**（`hasToolCalls()==false`）
- [[SPA与Jsoup]] — SPA（Single Page Application，单页应用）：浏览器请求 URL 时，服务器返回的 HTML 只是
- [[SSRF安全防护]] — SSRF（Server-Side Request Forgery，服务端请求伪造）：诱导服务器代替攻击者发起它本没想发的
- [[web_search与web_fetch]] — 联网双工具，分工协作：web_search 找地址，web_fetch 读内容。类似先用搜索引擎列结果、再点开某条看正文
- [[《PaiCLI》项目学习笔记]] — - [[RAG语义检索]] —— JavaParser 多粒度分块 + Embedding + SQLite + 三级混
- [[反爬与CDP边界]] — Chrome CDP 只破反爬最外层「JS 动态渲染」，且 headless 本身就是强 bot 信号——所以反爬远没失
- [[守护线程-Daemon]] — Java 的线程分两类：用户线程（non-daemon）和守护线程（daemon）。两者的唯一差别体现在 JVM 退出时
- [[并行工具执行与HITL]] — LLM 一轮 `chat()` 可能同时返回多个 `tool_calls`。PaiCLI 用线程池并行执行以提速，但两类
- [[请求响应配对]] — PaiCLI 里"请求和响应的配对"其实有**两套独立机制**，对应两个不同的通信边界。两者本质是相同的思想：发请求时生
- [[长上下文与RAG]] — 结论：长上下文不会让 RAG 失业，最佳实践是「长上下文 + RAG」混合。
- [[PaiSmart简历优化方案]] — 
- [[PaiSmart简历精简版]] — 
- [[PaiSmart简历终稿]] — 
- [[PaiSmart简历终稿v2]] — 
- [[PaiSmart简历终稿v3]] — 
- [[PaiSmart简历终稿v4]] — 
- [[《PaiSmart》项目学习笔记]] — 
- [[《苍穹外卖》项目学习笔记]] — 
- [[1. 短信登录：从思路到实现]] — 短信登录现在太常见了，点外卖、打车、刷短视频基本都是手机号 + 验证码一套。黑马点评这个项目的登录逻辑也是这套，但和传统
- [[2. 黑马点评商户缓存实战：穿透、击穿、雪崩与工具封装]] — 读多写少的场景下缓存几乎是必选项。黑马点评里的店铺信息就是典型的读多写少，谁进 App 都要查商户。这篇文章我把项目里商
- [[《黑马点评》项目学习笔记]] — 
- [[分布式与网关杂记]] — ```
- [[（实用篇）SpringCloud微服务笔记]] — **微服务** 是一种软件架构风格，它是以专注于单一职责的很多小型项目为基础，组合出复杂的大型应用。
- [[（面试篇）SpringCloud微服务笔记]] — - **服务提供者**：负责暴露接口，供其他微服务进行调用。
- [[（高级篇）SpringCloud微服务笔记]] — 1. **什么是雪崩问题？**
- [[Java后端学习笔记]] — - [[MOC]] — 知识库总览导航
- [[MOC]] — - [[Javase]] — JavaSE 概念综述与子主题导航
- [[Bug解决思路]] — **已查看文件** _pom.xml_
- [[CodeRunner乱码修复与IDEA风格输出配置]] — ```
- [[小知识]] — ---

## Agent开发学习（2 篇）

- [[Java后端转AI Agent 技能分层清单]] — ---
- [[MCP学习路径]] — | 阶段 | 主题 | 做完的标志 |

## (根)（3 篇）

- [[INDEX]] — - **[[MOC]]** — Java 后端学习总地图（基础 / 框架 / 中间件 / 微服务 / 工具 / 项目）
- [[README]] — ```
- [[求职项目MOC]] — - [[PaiSmart简历优化方案]] — 简历定位/写法优化建议（历史版本起点）

