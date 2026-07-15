> 📇 返回 [[求职项目MOC]]

> **标记说明：** 标注 `【待实现】` 的条目目前尚未编码，完成实现后请删除该标记。未标注的条目均来自现有代码，可直接使用。

---

**项目名称：PaiSmart — 企业级 RAG 智能知识库系统**
**GitHub：** https://github.com/Epoch-1483/PaiSmart
**时间：** 2025.04 — 2026.05
**技术栈：** Spring Boot 3.4、Elasticsearch 8、Kafka、Redis、MinIO、MySQL、WebSocket、Vue 3、TypeScript

**项目简介：** 面向企业级文档管理与知识问答场景，搭建从文档上传、智能解析切块、向量化存储到混合检索与流式对话的全链路 RAG 系统，支持多租户数据隔离与 Token 计量计费。

**核心职责：**

1. **异步文档流水线：** 基于 Kafka 构建"合并→解析→切块→向量化→入库"五级异步流水线，**事务投递**保证一致性，4 次重试（3s 退避）后转**死信队列**兜底，**三源一致性校验**（Redis BitMap + MySQL + MinIO）自动修复不一致状态；分片上传 SparkMD5 指纹去重 + Redis BitMap O(1) 状态判定（4 Worker × 3 并发），500MB 文件 **45s→8s 提升 80%+**；**Redisson 分布式锁**保证多实例部署下上传幂等性 `【待实现：替换 ConcurrentHashMap 锁为 Redisson RLock】`。

2. **混合检索引擎：** 设计 ES 混合检索索引（2048 维 dense_vector + IK 分词器），**KNN 宽召回（k=topK×30）+ BM25 Rescore 精排**，bool.filter 注入权限条件实现**检索级租户隔离**；解析层 LiteParse OCR + Tika 多引擎适配，切块"段落→句子→HanLP 分词"**三级粒度** + 语义 overlap 防断裂，**P95 延迟 ≤180ms**，召回率较纯向量检索**提升 28%**。

3. **流式对话架构：** 构建 **ReAct Agent** 架构（最大 4 轮推理、8 次工具调用），LLM 自主调用 search_knowledge 等工具；WebSocket 推送 JSON 帧实现打字机式流式对话，20s 心跳保活 + 自动重连 + **断线快照恢复**，**首 Token ≤280ms**；**多模型路由**（DeepSeek/Qwen/ZhipuAI）**运行时热切换** + 连接自动容错；Embedding API 3 次重试 + 1s 退避保障向量化稳定。

4. **多租户隔离与计量：** 构建**三层数据隔离**（私有/组织/公开），JWT 5 分钟自动续签 + Redis 黑名单注销；Token **预扣-结算** + **双窗口限流**（30 次/分钟、全局 12 万 Token/分钟）防恶意刷量；API 密钥 **AES-256-GCM 加密落库** + 随机 IV + 脱敏轮换；**MDC 链路追踪**（requestId 全链路贯穿）+ **4 通道结构化日志** + 慢请求 >3s 自动告警。

5. **工程化实践 `【待实现】`：** 基于 **Redisson 分布式锁**保证多实例部署下上传幂等性，看门狗自动续期；搭建 **GitHub Actions CI** 流水线，PR 自动触发编译 + 单测 + **JaCoCo 覆盖率报告**，核心链路覆盖率 ≥80%。

---

### 相比 v3 的改动对照

| 改动点 | v3 | v4 | 来源 |
|--------|-----|-----|------|
| 每条开头的"问题描述" | "同步文件处理导致上传接口阻塞…" 等 | 全部删除，腾出空间 | 精简 |
| 第 1 条 +三源一致性 | 无 | Redis BitMap + MySQL + MinIO 三源交叉校验 + 自动修复 | 第一层（代码已有） |
| 第 3 条 +多模型路由 | 无 | DeepSeek/Qwen/ZhipuAI 热切换 + 连接容错 | 第一层（代码已有） |
| 第 4 条 +AES 加密 | 无 | AES-256-GCM 加密 API Key + 随机 IV + 脱敏 | 第一层（代码已有） |
| 第 4 条 +结构化日志 | 无 | MDC requestId 追踪 + 4 通道日志 + 慢请求告警 | 第一层（代码已有） |
| 第 1/5 条 +Redisson | 无 | 分布式锁替换 ConcurrentHashMap 锁 | 第二层【待实现】 |
| 第 5 条 +工程化 | 无 | GitHub Actions CI + JaCoCo 覆盖率 | 第二层【待实现】 |
