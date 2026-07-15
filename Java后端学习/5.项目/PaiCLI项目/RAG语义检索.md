> 📇 返回 [[《PaiCLI》项目学习笔记]]

# RAG 语义检索

PaiCLI 的 RAG 代码库检索（`rag/` 包）让 Agent 用自然语言查找相关代码块，封装为 `search_code` 工具。

## 整体流水线
源码 → `CodeChunker`（JavaParser AST 分块）→ `EmbeddingClient`（向量化）→ `VectorStore`（SQLite 持久化）→ `CodeRetriever`（混合检索）→ `search_code` 工具。

## 多粒度分块
- **文件级**：非 Java / 超长文本按 2000 字符切段。
- **类级**：每个类生成一个 *class chunk*，但**只存类声明开头几行**（类名/泛型/字段签名），不塞整个类。
- **方法级**：每个方法单独成 *method chunk*，含完整方法体。
- 设计原因：类 chunk 当「结构/导航入口」，方法 chunk 当「实现细节」；避免同一段方法代码同时存在于类 chunk 和方法 chunk 导致重复命中；长类塞一个 chunk 会被 Embedding 平均化、稀释语义。详见 [[长上下文与RAG]] 里「噪声稀释」。

## Embedding
见 [[Embedding与RAG配置]]。默认 Ollama 本地 `nomic-embed-text`（768 维），支持 OpenAI 兼容远程。

## 存储与检索
- `VectorStore`：向量以 JSON 存 SQLite（`~/.paicli/rag/codebase.db`），检索时全量加载在内存算余弦相似度（`cosineSimilarity()`）。
- `CodeRetriever.hybridSearch`：三级混合 —— ① 语义（向量）② 关键词（用 [[RAG语义检索#jieba]] 分词后的关键词）③ 类型权重（method +0.15 / class +0.10）。
- 双重命中有 +0.1 奖励（只加一次）；同文件最多保留 2 条，总数不超 top_k。
- jieba 分词见 `RagQueryTokenizer.java`（用 `com.huaban.analysis.jieba`），过滤停用词、保留类名/方法名等代码关键词。

## 关键源码
- `CodeChunker.java` / `EmbeddingClient.java` / `VectorStore.java` / `CodeRetriever.java` / `RagQueryTokenizer.java`
- 工具注册：`ToolRegistry.registerRagTools()` → `search_code`
