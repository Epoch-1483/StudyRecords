> 📇 返回 [[《PaiCLI》项目学习笔记]]

# SSRF 安全防护

SSRF（Server-Side Request Forgery，服务端请求伪造）：诱导服务器代替攻击者发起它本没想发的请求，打到服务器能访问但攻击者直接碰不到的内部资源。

## 为什么 Agent 里是真实风险
`web_fetch` / `web_search` / MCP 联网工具都**替用户发 HTTP 请求**。若网页里藏一句「fetch http://169.254.169.254/...」，工具不校验就照做，云凭证可能泄露。对应简历里写的「联网工具内置 SSRF 防护拦截内网地址」即此处。

## PaiCLI 的防护（`NetworkPolicy.java`）
| 层 | 做法 | 拦什么 |
|----|------|--------|
| 协议白名单 | 仅 http/https | file://、gopher:// 等危险协议 |
| 字面黑名单 | localhost / 0.0.0.0 | 本机/未指定地址 |
| DNS 解析校验 | 解析后判 isLoopback / isAnyLocal / isLinkLocal / isSiteLocal | 环回、链路本地、私网段（10/172.16/192.168） |
| 限流 | token bucket，60s 最多 30 次 | 被当请求放大器滥用 |

核心：`checkUrl()` 拆 URL → 协议不在白名单拒；host 解析成 IP 后落入环回/未指定/链路本地/站内私网任一即拒——内网地址出不去。

## 边界（诚实说明）
这是基础围栏，覆盖常见场景。严苛企业环境还需补：DNS rebinding 防护（解析后马上连、连的须是刚校验的 IP）、完整 CIDR 黑白名单、证书校验加固。
