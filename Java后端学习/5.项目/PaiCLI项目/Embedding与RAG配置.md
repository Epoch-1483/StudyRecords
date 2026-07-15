> 📇 返回 [[《PaiCLI》项目学习笔记]]

# Embedding 与 RAG 配置

`EmbeddingClient` 统一封装两种 Embedding 来源，由 4 个环境变量切换。

## 两个来源
- **Ollama 本地**（默认）：`localhost:11434/api/embeddings`。
- **OpenAI 兼容远程**：`{baseUrl}/embeddings` + `Bearer` 鉴权；provider 填 `openai` / `zhipu` / `glm` 走此路径（其他名字会错误回退 Ollama）。

## 环境变量
| 变量 | 默认 | 说明 |
|------|------|------|
| `EMBEDDING_PROVIDER` | ollama | openai / zhipu / glm / ollama |
| `EMBEDDING_MODEL` | nomic-embed-text:latest | 模型名 |
| `EMBEDDING_BASE_URL` | 按 provider 推断 | 远程地址 |
| `EMBEDDING_API_KEY` | 空 | Bearer token |

## 维度
**代码不写死维度**，运行时读 API 返回长度：`float[] embedding = new float[embeddingNode.size()]`。默认模型 `nomic-embed-text` 是 **768 维**；换 OpenAI `text-embedding-3-small` 即 1536 维，PaiCLI 无需改代码，只要同一次索引用同一模型。余弦相似度只校验两侧同维（`a.length != b.length → 0.0`）。

## 没装 Ollama 怎么办
设 `EMBEDDING_PROVIDER=openai`（或 glm）、填 `EMBEDDING_MODEL` / `EMBEDDING_BASE_URL` / `EMBEDDING_API_KEY`。自定义 OpenAI 兼容服务**必须填 provider=openai** + 自己 BASE_URL（provider 名字只决定请求格式，不决定服务器）。

## 换模型后必须重索引
向量存 SQLite（`~/.paicli/rag/codebase.db`），维度随模型定。换模型后旧向量长度对不上新向量，余弦相似度直接返回 0。需清掉旧索引重新 `/index`。索引前用 `/index` 命令构建，未索引时 `search_code` 会提示「代码库尚未索引」。
