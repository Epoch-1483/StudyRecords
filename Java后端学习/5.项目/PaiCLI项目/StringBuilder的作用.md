# StringBuilder 的作用（简要）

> 关联：[[GLMClient中的ObjectMapper]] 的 `parseSseStream()` 用它累积流式返回的 content 片段

## 1. 它解决什么问题

Java 的 `String` **不可变**：循环里用 `+` 拼接，每次都会生成一个新 `String` 对象，产生大量临时对象、触发频繁 GC，性能差。
`StringBuilder` 内部维护一个**可扩容的 char 数组**，拼接时直接追加，不生成中间 `String`，最后 `toString()` 一次性产出。循环拼接场景性能远优于 `+`。

## 2. 核心 API

- `append(各种类型)` —— 追加内容（最常用）
- `insert(index, ...)` / `delete(start, end)` / `deleteCharAt(i)` —— 增删
- `reverse()` —— 反转
- `toString()` —— 转成最终 `String`

## 3. StringBuilder vs StringBuffer

- `StringBuilder`：**非线程安全**，单线程下更快（默认选它）
- `StringBuffer`：方法加了 `synchronized`，线程安全，多线程共享同一缓冲区时用

## 4. 在 GLMClient 里的用法

`parseSseStream()` 中模型是流式返回，每个 SSE chunk 只带一小段 `delta.content`：

```java
StringBuilder contentBuilder = new StringBuilder();
// 每个 chunk:
contentBuilder.append(delta.get("content").asText());
// 最后:
return new ChatResponse(contentBuilder.toString(), ...);
```

这正是 `StringBuilder` 的典型场景——**循环里累积大量片段**。若改成 `String content += chunk`，每次都新建 String 并复制已累积内容，既慢又费内存。

## 一句话总结

`StringBuilder` = 可变的字符串缓冲区，专为"多次拼接/修改"设计，避免不可变 `String` 反复新建对象带来的性能浪费。
