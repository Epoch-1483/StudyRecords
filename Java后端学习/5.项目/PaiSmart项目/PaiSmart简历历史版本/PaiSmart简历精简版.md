> 📇 返回 [[求职项目MOC]]

## PaiSmart 简历精简版（适配一页纸）

以下版本与 PaiCLI 篇幅一致，4 条核心职责，每条控制在 2-3 行以内。

---

**项目名称：PaiSmart — 企业级 RAG 智能知识库系统**
**GitHub：** https://github.com/Epoch-1483/PaiSmart
**时间：** 2025.04 — 2026.05
**技术栈：** Spring Boot 3.4、Elasticsearch 8、Kafka、Redis、MinIO、MySQL、WebSocket、Vue 3、TypeScript

**项目介绍：** 面向企业级文档管理与知识问答场景，搭建从文档上传、智能解析切块、向量化存储到混合检索与流式对话的全链路 RAG 系统，支持多租户数据隔离与 Token 计量计费。

**核心职责：**

1. 基于 Kafka 构建"文件合并→解析→切块→向量化→入库"异步流水线，事务投递+幂等消费，失败重试 4 次后转死信队列；大文件分片上传采用 SparkMD5 指纹 + Redis BitMap 状态追踪 + MinIO composeObject 合并，支持断点续传与秒传校验。

2. 设计 ES 混合检索索引（2048 维 dense_vector + IK 分词器），KNN 宽召回（k=topK×30）+ BM25 Rescore 精排，bool.filter 层注入权限条件实现检索级租户隔离；文档解析采用 LiteParse OCR + Apache Tika 多引擎适配，切块策略为"段落→句子→HanLP 分词"三级粒度 + 语义 overlap。

3. 构建 ReAct Agent 对话架构（最大 4 轮推理、8 次工具调用），LLM 自主决策调用 search_knowledge 等工具；WebSocket 推送 JSON 帧（start/chunk/tool_call/completion）实现打字机式流式对话，内置心跳保活、自动重连与断线生成快照恢复。

4. 基于 Spring Security + JWT + RBAC 构建三层数据隔离（私有/组织/公开），JWT 支持 5 分钟窗口自动续签与 Redis 黑名单注销；Token 计量采用 Redis 预扣-结算模式，支持运行时热切换 LLM/Embedding 供应商，集成微信支付完成充值闭环。

---

### 精简策略说明

| 原 7 条 | 合并后 4 条 | 合并逻辑 |
|---------|-----------|---------|
| 1. Kafka 流水线 + 2. 分片上传 | → 第 1 条 | 同属"文件处理链路"，面试时可分别展开 |
| 3. ES 混合检索 + 5. 文档解析切块 | → 第 2 条 | 同属"数据入库与检索"，解析是检索的前置环节 |
| 4. ReAct Agent + WebSocket | → 第 3 条 | 独立保留，AI 对话是最核心的用户侧能力 |
| 6. 安全多租户 + 7. Token 计量 | → 第 4 条 | 同属"平台治理层"，安全和计费都是运营能力 |

每条压缩后仍保留了关键面试锚点（BitMap、topK×30、4 轮推理、预扣-结算等），面试官追问时用之前详细方案里的内容展开即可。
