> 📇 返回 [[求职项目MOC]]

## PaiSmart 简历优化方案

> 以下内容全部基于你的真实代码验证，每一条都能在面试中展开深聊。

---

### 一、当前版本的主要问题

你现在的简历把 PaiSmart 定位为"大模型驱动的智能旅行规划系统"，但实际代码是一个完整的企业级 RAG 知识库平台。定位偏差会让面试官觉得项目和能力不匹配。另外，当前的 6 条描述过于笼统（比如"Spring AI Integration""High-Density MGP"），读起来像是功能罗列，看不出你做了什么、怎么做的、效果如何。对比模版可以看出，好的写法是"具体技术 + 实现方式 + 效果/数据"三要素缺一不可。

---

### 二、优化后的简历内容

**项目名称：PaiSmart — 企业级 RAG 智能知识库系统**
**GitHub：** https://github.com/Epoch-1483/PaiSmart
**时间：** 2025.04 — 2026.05
**技术栈：** Spring Boot 3.4、Elasticsearch 8、Kafka、Redis、MinIO、MySQL、WebSocket、Vue 3、TypeScript

**项目介绍：** 面向企业级文档管理与知识问答场景，搭建从文档上传、智能解析切块、向量化存储到混合检索与流式对话的全链路 RAG 系统，支持多租户数据隔离与 Token 计量计费。

**核心职责：**

1. 基于 Kafka 构建"文件合并 → 文档解析 → 文本切块 → 向量化 → 索引入库"异步处理流水线，Producer 使用事务投递（`executeInTransaction`）+ 幂等配置（`enable.idempotence=true`），Consumer 失败重试 4 次后自动转入死信队列（`DeadLetterPublishingRecoverer`），实现上传与处理的完全解耦。

2. 实现大文件分片上传方案：前端 SparkMD5 计算文件指纹后按 5MB 切片，采用 Worker Pool 模式（4 并发/文件、3 文件并行）上传；后端用 Redis BitMap 追踪每个分片状态，结合 MinIO `composeObject` 完成合并，支持断点续传与秒传校验。

3. 设计 Elasticsearch 混合检索索引（2048 维 `dense_vector` + IK 分词器），检索时先 KNN 宽召回（`k = topK × 30`），再 BM25 Rescore 精排（`queryWeight=0.2, rescoreQueryWeight=1.0`），在 `bool.filter` 层注入权限条件实现检索级租户隔离，支持关键词、语义、混合三种检索模式。

4. 构建 ReAct Agent 对话架构，LLM 自主决策是否调用 `search_knowledge`、`generate_summary` 等工具（最大 4 轮推理、8 次工具调用）；通过 WebSocket 推送 JSON 帧（start / chunk / tool_call / completion）实现打字机式流式对话，前端用 `@vueuse/core` 管理连接，内置心跳保活、自动重连与断线生成快照恢复。

5. 设计多引擎文档解析与切块策略：PDF 通过 LiteParse CLI 调用本地 OCR 处理图片型文档，非 PDF 格式走 Apache Tika 自动识别；文本切块采用"段落 → 句子 → HanLP 分词"三级粒度 + 语义 overlap（100 字符滑动窗口），减少硬切导致的语义断裂。

6. 基于 Spring Security + JWT + RBAC 构建三层数据隔离模型（私有 / 组织 / 公开），JWT 支持 5 分钟窗口自动续签与 Redis 黑名单注销；ES 查询层通过 `bool.should` 注入 `userId`、`orgTag`（含父级标签递归展开）、`isPublic` 条件，实现物理层检索隔离。

7. 实现 Token 计量与多模型路由：Redis 预扣-结算模式（`TokenReservationBundle`）管理分钟/日双窗口额度，支持日用量与累计余额双策略；管理员可运行时热切换 LLM / Embedding 供应商（`model_provider_configs` 表驱动），集成微信支付完成 Token 充值闭环。

---

### 三、每条的面试展开方向与高频追问

#### 第 1 条：Kafka 异步流水线

**大白话讲：** 用户传完文件之后，系统不是当场处理（解析、切块、向量化这些很重的事），而是往 Kafka 丢一条消息就返回了。后面 Consumer 慢慢取出来处理，处理失败还能重试，实在不行扔进死信队列，不会丢文件也不会卡住上传接口。

**高频追问：**
- "事务投递具体怎么配的？" → `kafkaTemplate.executeInTransaction`，Producer 配置 `transactional.id.prefix`，保证文件合并和消息发送要么都成功要么都失败。
- "死信队列怎么消费的？" → `DefaultErrorHandler` + `FixedBackOff(3000ms, 4)` + `DeadLetterPublishingRecoverer` 发到 `file-processing-dlt` topic。
- "怎么保证不重复处理？" → Consumer 端通过 `fileMd5` 做幂等检查，已有的文档会跳过或走 reindex 分支。

#### 第 2 条：分片上传 + Redis BitMap

**大白话讲：** 一个大文件（比如 500MB 的 PDF）被切成 100 个小块，每块 5MB。前端 4 个 Worker 同时上传，传到哪个块就在 Redis BitMap 里把对应的位置 1。断网了不怕，重新上传时先查 BitMap 看哪些块已经传过了，只补传缺失的。

**高频追问：**
- "为什么用 BitMap 而不是 Set？" → BitMap 按 chunkIndex 直接定位，内存开销极小（100 个分片只需 13 字节），`setBit/getBit` 都是 O(1)。
- "前端怎么控制并发？" → Worker Pool 模式，4 个递归函数各取队列中下一个 chunkIndex，某个 Worker 失败就 throw 终止剩余。
- "合并时怎么保证顺序？" → MinIO `composeObject` 传入按 chunkIndex 排好序的 source objects 列表。

#### 第 3 条：ES 混合检索

**大白话讲：** 用户问一个问题，系统先用向量搜索把语义相近的文档大范围捞出来（topK 的 30 倍），然后用 BM25 关键词打分重新排序，同时在过滤条件里加上"你只能看到自己的、公开的、或者同组织的文档"。这样既有语义理解，又有关键词精确匹配，还不会越权。

**高频追问：**
- "为什么 KNN 用 topK×30 这么大？" → 宽召回确保不遗漏，反正后面 BM25 Rescore 会精排，多捞比少捞安全。
- "BM25 Rescore 的 queryWeight 和 rescoreQueryWeight 怎么调的？" → `queryWeight=0.2` 让原始向量分占比小，`rescoreQueryWeight=1.0` 让 BM25 主导最终排序，这样关键词匹配的文档会靠前。
- "权限过滤为什么不放在应用层？" → 放在 ES `bool.filter` 里是物理层隔离，不经过应用层判断，性能更好也更安全（不会漏判）。

#### 第 4 条：ReAct Agent + WebSocket 流式对话

**大白话讲：** 用户发消息后，LLM 不直接回答，而是先想"我要不要搜一下知识库？要不要生成摘要？"，每一轮思考都可以调用工具，最多想 4 轮。同时回答通过 WebSocket 一个字一个字推给前端，用户看到的就像有人在打字。如果断网了，重连后系统会检查有没有正在生成的回答，直接恢复。

**高频追问：**
- "ReAct 和直接 Function Calling 有什么区别？" → ReAct 是多轮推理循环，LLM 每一轮都决定是调工具还是给最终答案；普通 Function Calling 通常是一轮就返回。
- "断线恢复怎么实现的？" → 前端重连后调 `syncGenerationAfterReconnect()`，后端返回当前 generationId 的最新快照（已生成的文本 + 状态），前端合并到消息列表里。
- "WebSocket 心跳怎么做的？" → 客户端每 20 秒发 `__chat_ping__`，10 秒内没收到 `__chat_pong__` 就认为连接断了，触发重连。

#### 第 5 条：文档解析与切块

**大白话讲：** PDF 文件用 LiteParse 命令行工具处理，它能调本地 OCR 识别图片里的文字（普通 PDF 解析器对扫描件无能为力）。Word、TXT 等格式用 Apache Tika 自动识别。切块的时候不是简单按字数切，而是先按段落切，太长就按句子切，句子还太长就用 HanLP 中文分词，最后还会在相邻块之间保留 100 字符的重叠，防止一句话被切成两半。

**高频追问：**
- "为什么要 overlap？" → 如果一句话刚好在切块边界，前半句在 chunk A、后半句在 chunk B，检索时两个 chunk 都可能不匹配。overlap 让相邻块有公共上下文，提高召回率。
- "LiteParse 的 OCR 怎么对接的？" → 通过 `--ocr-server-url` 参数桥接本地 Tesseract 或阿里云高清 OCR（`ocr-language chi_sim+eng`），做成插件式适配器。
- "大文件解析会不会 OOM？" → Tika 端自定义 `StreamingContentHandler` 继承 `BodyContentHandler`，边解析边输出，不会把整个文件内容堆在内存里。

#### 第 6 条：安全与多租户

**大白话讲：** 系统有三种数据可见级别——只有自己能看（PRIVATE_ 前缀）、同组织能看（orgTag 匹配）、所有人都能看（isPublic）。每个用户属于一个或多个组织标签，标签还有父子层级（比如"技术部"下面有"后端组"），查 ES 时自动把父标签也展开。JWT 里带着用户的组织信息，快过期时自动续签，用户无感。

**高频追问：**
- "orgTag 层级展开怎么做的？" → `OrgTagCacheService.getUserEffectiveOrgTags()` 递归遍历 `parentTag` 链路，结果缓存 24 小时。
- "JWT 续签逻辑？" → `JwtAuthenticationFilter` 检查 token 剩余有效期 < 5 分钟时签发新 token 放到 `New-Token` 响应头，前端拦截器自动替换。
- "注销怎么保证 token 真的失效？" → 把 tokenId 写入 Redis 黑名单（`jwt:blacklist:{tokenId}`），同时从用户的 token set 中移除。

#### 第 7 条：Token 计量与多模型路由

**大白话讲：** 每次调 LLM 之前先从 Redis 里"预扣"一笔 Token 额度，等流式响应结束后拿到实际用量再"结算"（多退少补）。管理员可以在后台切换用哪个大模型（DeepSeek、通义千问等），不需要重启服务。还集成了微信支付，用户买 Token 包后自动充值。

**高频追问：**
- "预扣-结算怎么防并发问题？" → `TokenReservationBundle` 用 Redis 原子操作（increment + expire），分钟窗口和日窗口各一个 key。
- "热切换怎么实现的？" → `model_provider_configs` 表存供应商配置，`LlmProviderRouter` 每次调用时读 `getActiveProvider()`，管理员改表就生效。
- "微信支付怎么对账？" → `RechargeOrder` 表记录 trade_no、amount、status，支付回调更新 status 为 SUCCEED 后触发 Token 充值。

---

### 四、写法对比（改前 vs 改后）

| 维度 | 改前 | 改后 |
|------|------|------|
| 项目定位 | "智能旅行规划系统"（与代码不符） | "企业级 RAG 智能知识库系统"（准确） |
| 技术深度 | "Spring AI Integration""SSE-Metric" 等笼统标签 | 每条都写明类名、方法名、参数值 |
| 数据支撑 | 基本无数据 | 2048 维、topK×30、4 轮推理、5MB 分片等 |
| 面试可聊性 | 面试官不知道追问什么 | 每一条都有明确的追问方向 |
| 架构感 | 功能罗列，看不出全貌 | 从上传→处理→检索→对话→安全→计量，完整链路 |
