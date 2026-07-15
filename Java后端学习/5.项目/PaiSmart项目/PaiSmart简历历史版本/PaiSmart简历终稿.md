> 📇 返回 [[求职项目MOC]]

## PaiSmart 简历终稿

**项目名称：PaiSmart — 企业级 RAG 智能知识库系统**
**GitHub：** https://github.com/Epoch-1483/PaiSmart
**时间：** 2025.04 — 2026.05
**技术栈：** Spring Boot 3.4、Elasticsearch 8、Kafka、Redis、MinIO、MySQL、WebSocket、Vue 3、TypeScript

**项目介绍：** 面向企业级文档管理与知识问答场景，搭建从文档上传、智能解析切块、向量化存储到混合检索与流式对话的全链路 RAG 系统，支持多租户数据隔离与 Token 计量计费。

**核心职责：**

1. 基于 Kafka 构建"文件合并→解析→切块→向量化→入库"异步流水线，通过事务投递保证上传与处理的一致性，消费端失败重试 4 次后转死信队列兜底；大文件采用分片上传（SparkMD5 指纹去重 + Redis BitMap 追踪分片状态），支持断点续传与秒传校验。

2. 设计 ES 混合检索索引（2048 维 dense_vector + IK 分词器），KNN 宽召回（k=topK×30）+ BM25 Rescore 精排，bool.filter 层注入权限条件实现检索级租户隔离；文档解析采用 LiteParse OCR + Apache Tika 多引擎适配，切块策略为"段落→句子→HanLP 分词"三级粒度 + 语义 overlap。

3. 构建 ReAct Agent 对话架构（最大 4 轮推理、8 次工具调用），LLM 自主决策调用 search_knowledge 等工具；WebSocket 推送 JSON 帧（start/chunk/tool_call/completion）实现打字机式流式对话，内置心跳保活、自动重连与断线生成快照恢复。

4. 基于 Spring Security + JWT + RBAC 构建三层数据隔离（私有/组织/公开），JWT 支持 5 分钟窗口自动续签与 Redis 黑名单注销；Token 计量采用 Redis 预扣-结算模式，按实际消耗扣费。

---

### 相比上一版的改动

| 条目 | 改动 | 原因 |
|------|------|------|
| 第 1 条 | "幂等消费"→"事务投递保证一致性"，去掉"MinIO composeObject 合并" | "幂等消费"追问风险高且容易被理解为只是去重；去掉 MinIO 方法名但保留 SparkMD5 + BitMap 作为区分度锚点 |
| 第 2 条 | 无改动 | 反馈确认无需修改 |
| 第 3 条 | 无改动 | 反馈确认无需修改 |
| 第 4 条 | 砍掉"运行时热切换 LLM/Embedding 供应商"和"集成微信支付完成充值闭环" | 微信支付与 RAG 核心能力无关，热切换只是配置读取，都撑不起追问 |
