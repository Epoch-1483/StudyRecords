> 📇 返回 [[《PaiCLI》项目学习笔记]]

# Prompt Caching

Prompt Caching（提示词缓存）：把请求里重复不变的前缀（system prompt、工具定义、长文档）在服务端缓存，下次命中同样前缀时跳过重复计算，省钱提速。

## 为什么能缓存
Transformer 处理输入时每个 token 要算 K/V（attention 的 key/value），同一前缀每次算出的 K/V 完全一样 → 存起来复用（即 KV Cache）。

## 关键：只能缓存「前缀」
从头部逐 token 匹配，某 token 不同则后面全失效。所以**不变内容放最前、变化内容放最后**：
```
[ 不变：system prompt / 工具定义 / 项目上下文 ]  ← 可命中缓存
[ 变化：用户本轮提问 ]                          ← 每轮重算
```

## 收益
- 输入 token 成本降到约 10%（OpenAI/DeepSeek）或便宜约 90%。
- 首 token 延迟（TTFT）在长前缀场景明显下降。
- 适用：多轮对话、Agent（system+工具定义每轮重复）、RAG、批量同模板请求。

## 形态
- 自动缓存（OpenAI/DeepSeek）：超长相同前缀自动命中，无需改代码，缓存几分钟有效。
- 显式缓存（Claude）：手动打 `cache_control` 标记要缓存的块。

## 与 PaiCLI
每轮 ReAct 请求都带相同的 system prompt + 16 个工具定义 + 注入的 PAI.md，是天然缓存前缀。只要这些内容稳定放最前、逐轮一致（别在前缀插变化的时间戳/随机内容），就能吃自动缓存，多轮成本显著下降。底部状态栏把 `cache` 单独统计即命中缓存的 token 数。
