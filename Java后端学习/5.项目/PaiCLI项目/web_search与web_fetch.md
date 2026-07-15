> 📇 返回 [[《PaiCLI》项目学习笔记]]

# web_search 与 web_fetch

联网双工具，分工协作：web_search 找地址，web_fetch 读内容。类似先用搜索引擎列结果、再点开某条看正文。

## 职责对比
| | web_search | web_fetch |
|--|--|--|
| 输入 | 关键词 query | 完整 url |
| 干什么 | 问搜索引擎，返回一批候选 | 访问某页面，取正文 |
| 输出 | 标题+摘要+URL 列表（默认 5） | 正文转 Markdown（默认截断 8000 字符） |
| 底层 | SerpAPI（默认）/ SearXNG / 智谱，`SEARCH_PROVIDER` 切换 | HTTP + readability（`WebFetcher` + `HtmlExtractor`） |
| 局限 | 依赖搜索质量，只给摘要 | 只吃静态/SSR；JS 渲染或防爬返回空正文（本期不重试） |

## 典型链路
`web_search("Java 21 新特性")` → 返回若干 URL → Agent 挑权威的一条 → `web_fetch(url)` 拉正文 → 基于正文回答。

## 为什么不合成一个
搜索可能召回无关链接需 Agent 判断哪条值得点；抓取可能空正文需决定换条还是升级浏览器工具（`browser_connect` 走 Chrome CDP 处理 JS 页）。拆两步让 Agent 在中间插入决策，而不是黑盒地「搜了就读第一条」。这也是 Claude Code / 主流 Agent 的通用设计：search 负责发现，fetch 负责精读，浏览器工具兜底动态页。

## 源码
`ToolRegistry.registerWebTools()`：`web_search → webSearch() → SearchProvider` 家族；`web_fetch → webFetch() → WebFetcher + HtmlExtractor`。
