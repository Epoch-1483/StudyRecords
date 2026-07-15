# 求职项目 · MOC（总览）

> 求职与开源项目资料导航中心。串联 PaiSmart / PaiCLI 简历各版本、终端兼容性方案，以及课程笔记，消除孤立页面。

## PaiSmart 简历（演进顺序）
- [[PaiSmart简历优化方案]] — 简历定位/写法优化建议（历史版本起点）
- [[PaiSmart简历精简版]] — 一页纸精简版（4 条核心职责）
- [[PaiSmart简历终稿]] — 终稿 v1
- [[PaiSmart简历终稿v2]] — v2（问题→方案→效果 格式）
- [[PaiSmart简历终稿v3]] — v3（量化数据，对标大厂格式）
- [[PaiSmart简历终稿v4]] — v4（最新版，含【待实现】标记，投递请用此版）

> 演进链：优化方案 → 精简版 → 终稿 → v2 → v3 → v4。v4 中的量化指标标注 `[待测]`，需真实测评替换。

## PaiCLI 项目资料（21 篇设计文档，按模块分组）

> PaiCLI = Java Agent CLI（对标 Claude Code）。以下文档已全部链入本 MOC，消除孤岛。

### 总览
- [[《PaiCLI》项目学习笔记]] — PaiCLI 项目总笔记（入口）
- [[PaiCLI-Windows终端兼容性解决方案]] — Windows 终端中文乱码 / ANSI 回退根因与解决（实战踩坑）

### ReAct 主循环
- [[ReAct主循环]] — ReAct 推理-行动循环核心
- [[ReAct循环保险阀]] — 循环安全保险机制
- [[ReAct循环退出条件]] — 何时退出循环

### RAG 与上下文
- [[RAG语义检索]] — RAG 语义检索实现
- [[Embedding与RAG配置]] — Embedding 模型与 RAG 配置
- [[长上下文与RAG]] — 长上下文 vs RAG 取舍
- [[Prompt Caching]] — Prompt 缓存优化

### 工具与执行
- [[Function Calling工具定义]] — 工具/函数调用定义
- [[web_search与web_fetch]] — 网络搜索与抓取工具
- [[并行工具执行与HITL]] — 并行工具执行 + 人类在环确认
- [[HITL全部放行双维度]] — HITL 双维度放行策略
- [[请求响应配对]] — 请求-响应配对机制

### 安全
- [[Prompt注入防御]] — Prompt 注入攻击防御
- [[SSRF安全防护]] — SSRF 安全防护
- [[反爬与CDP边界]] — 反爬与 CDP 边界处理

### 通信与基础设施
- [[MCP与JSON-RPC]] — MCP 协议底层（JSON-RPC 2.0）
- [[SPA与Jsoup]] — SPA 页面与 Jsoup 解析
- [[GLMClient中的ObjectMapper]] — GLM Client 的 ObjectMapper 配置
- [[守护线程-Daemon]] — 守护线程管理

## 课程项目资料
- [[《黑马点评》项目学习笔记]] — 黑马点评总笔记（Redis 企业实战）
- [[黑马点评（Redis 企业实战）]] — Redis 缓存实战
- [[《苍穹外卖》项目学习笔记]] — 苍穹外卖项目
- [[《PaiSmart》项目学习笔记]] — PaiSmart 企业级 RAG 知识管理平台

## 相关附件（非 md，仅供参考）
- `简历/`：我的简历.pdf、我的简历（2）.pdf、郑昌军-Java后端开发工程师.pdf
- `学习资料/`：PaiCLI简历模版.docx、PaiSmart简历模版.docx、PaiCLI简历数据实测指南.docx
- `技术文档/`：Java 开发手册、JDK API

## 返回
- 总入口：[[INDEX]]
- Java 学习地图：[[MOC]]
