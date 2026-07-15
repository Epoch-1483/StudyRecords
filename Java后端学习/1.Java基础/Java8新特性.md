# Java 8 新特性

> Java 8（2014 年发布）最大的变化是**引入函数式编程**，是 Java 从「纯面向对象」迈向「面向对象 + 函数式」的分水岭。

## 一、为什么 Java 8 重要
- 函数式编程范式第一次进入 Java
- 集合处理（Stream）、并发（CompletableFuture）、日期时间（java.time）三大痛点被解决
- 大量语法糖让代码更简洁、可读性更高

## 二、核心特性清单

| 特性 | 关键词 | 一句话作用 |
|------|--------|------------|
| Lambda 表达式 | `->` | 把行为当参数，替代匿名内部类 |
| 函数式接口 | `@FunctionalInterface` | 让 Lambda 拥有类型 |
| Stream API | `stream()` | 声明式处理集合，可链式可并行 |
| 方法引用 | `::` | 复用已有方法 |
| 接口默认/静态方法 | `default` / `static` | 接口里也能写实现 |
| Optional | `Optional<T>` | 专治空指针 |
| java.time | `LocalDateTime` | 新一代日期时间 API |
| CompletableFuture | `supplyAsync` | 异步任务链式编排 |
| 注解增强 | `@Repeatable` | 重复注解 + 类型注解 |
| JVM 改进 | Metaspace / 红黑树 | 内存与集合性能提升 |

### 1. Lambda 表达式

把「行为」当作参数传递，替代大量匿名内部类。

```java
// 旧写法：匿名内部类
new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("hi");
    }
}).start();

// Lambda 写法
new Thread(() -> System.out.println("hi")).start();
```

- 语法：`(参数) -> 表达式/语句块`
- 本质：编译后使用 `invokedynamic` 指令，运行时才绑定方法，而不是生成匿名内部类
- 变量捕获：Lambda 只能引用** effectively final** 的局部变量

### 2. 函数式接口（Functional Interface）

只有一个抽象方法的接口，`@FunctionalInterface` 注解可选（编译器会校验）。它是 Lambda 的类型载体。

Java 8 在 `java.util.function` 包中提供了大量现成函数式接口，最常用的四个：

| 接口 | 签名 | 用途 |
|------|------|------|
| `Function<T, R>` | `R apply(T t)` | 接收 T，返回 R，做转换 |
| `Predicate<T>` | `boolean test(T t)` | 接收 T，返回 boolean，做过滤 |
| `Consumer<T>` | `void accept(T t)` | 接收 T，无返回，做消费 |
| `Supplier<T>` | `T get()` | 无参数，返回 T，做供给 |

### 3. Stream API

对集合的**声明式、可链式、可并行**处理，且不会修改源数据。

```java
List<String> result = list.stream()
    .filter(s -> s.length() > 3)
    .map(String::toUpperCase)
    .sorted()
    .collect(Collectors.toList());
```

- 惰性求值：中间操作（`filter`、`map`、`sorted`）不会立即执行
- 及早求值：终结操作（`collect`、`forEach`、`count`）触发实际计算
- 并行流：`parallelStream()` 一行切换，底层使用 [[JavaSE基础完整笔记#多线程|ForkJoinPool]]
- ⚠️ 陷阱：默认共用公共 `ForkJoinPool`，并行流里不要做阻塞 IO 或慢任务，否则线程池会被占满

### 4. 方法引用

Lambda 的语法糖，复用已有方法。

```java
list.forEach(System.out::println);
```

四种形式：

| 形式 | 示例 | 说明 |
|------|------|------|
| 静态方法引用 | `Integer::parseInt` | 类名::静态方法 |
| 特定对象实例方法 | `System.out::println` | 对象::方法 |
| 任意对象实例方法 | `String::toUpperCase` | 类名::实例方法 |
| 构造方法引用 | `ArrayList::new` | 类名::new |

### 5. 接口默认方法 & 静态方法

接口里终于可以有方法实现：

- `default` 方法：实现类可继承也可重写，解决「给接口加方法要改所有实现类」的痛点
- `static` 方法：接口自己的工具方法

> 这是 Java 8 能给 `Collection` 接口增加 `stream()` 默认方法、却不破坏所有旧实现的关键。

```java
public interface MyInterface {
    default void hello() {
        System.out.println("default method");
    }

    static void utility() {
        System.out.println("static method");
    }
}
```

### 6. Optional&lt;T&gt;

专门解决 `NullPointerException` 的容器类，强制调用方处理「可能为 null」的返回值。

```java
String name = Optional.ofNullable(user)
    .map(User::getName)
    .orElse("未知");
```

常用方法：

- `of(T value)`：包装非 null 值，传入 null 会抛 `NullPointerException`
- `ofNullable(T value)`：可包装 null，返回空 Optional
- `empty()`：返回空 Optional
- `map(Function)` / `flatMap(Function)`：对值做转换
- `orElse(T other)` / `orElseGet(Supplier)`：为空时提供默认值
- `ifPresent(Consumer)`：值存在时消费

> ⚠️ 不要把 Optional 当成「万能 null 药」滥用，它更适合用于明确表达「可能缺失」的返回值。

### 7. 新的日期时间 API（java.time）

彻底重做 `Date` / `Calendar`（线程安全、不可变、API 清晰），全部位于 `java.time` 包。

```java
LocalDateTime now = LocalDateTime.now();
LocalDateTime tomorrow = now.plusDays(1);
String formatted = DateTimeFormatter
    .ofPattern("yyyy-MM-dd HH:mm:ss")
    .format(now);
```

- `LocalDate` / `LocalTime` / `LocalDateTime`：本地日期时间
- `ZonedDateTime`：带时区的日期时间
- `DateTimeFormatter`：替代 `SimpleDateFormat`，线程安全
- `Duration`：基于时间（秒、纳秒）的间隔
- `Period`：基于日期（年、月、日）的间隔

### 8. CompletableFuture

异步编程的「Future 增强版」，支持链式回调、组合多个异步任务，比 `Future.get()` 阻塞友好得多。

```java
CompletableFuture.supplyAsync(() -> "hello")
    .thenApply(s -> s + " world")
    .thenAccept(System.out::println);
```

常用组合方法：

- `supplyAsync(Supplier)`：异步执行，有返回值
- `runAsync(Runnable)`：异步执行，无返回值
- `thenApply(Function)`：对上一步结果做转换
- `thenAccept(Consumer)`：对上一步结果做消费
- `thenCompose(Function)`：连接两个异步任务
- `thenCombine(CompletionStage, BiFunction)`：合并两个异步任务的结果
- `exceptionally(Function)` / `handle(BiFunction)`：异常处理

### 9. 注解增强

- **重复注解**：通过 `@Repeatable` 让同一位置可以标注多次
- **类型注解**：注解能用在任何类型使用的位置（如泛型、局部变量），为编译器插件和类型检查工具铺路

```java
@Target(ElementType.TYPE_USE)
@Retention(RetentionPolicy.RUNTIME)
public @interface NonNull {}

List<@NonNull String> list; // 类型注解用法
```

### 10. JVM / 底层改进

- **Metaspace 取代 PermGen**：类元数据从永久代移到本地内存，减少 `OutOfMemoryError: PermGen`
- **HashMap 红黑树化**：链表长度 > 8 且桶容量 >= 64 时转成红黑树，最坏查询从 O(n) 降到 O(log n)
- **Base64 进入标准库**：`java.util.Base64`，无需再引第三方库
- **Nashorn JavaScript 引擎**：允许 JVM 内嵌执行 JS（已在后续版本废弃）

## 三、面试高频考点

1. **Lambda 与匿名内部类的本质区别**：
   - Lambda 使用 `invokedynamic` 指令，运行时动态生成调用点；匿名内部类编译时会生成独立的 `.class` 文件
   - Lambda 只能访问 effectively final 变量，捕获方式更轻量
2. **Stream 并行流的线程池陷阱**：
   - 默认共用公共 `ForkJoinPool`，如果并行流里做阻塞 IO，会拖慢整个线程池
3. **方法引用的四种形式**：静态方法、特定对象方法、任意对象方法、构造方法
4. **Optional 的合理使用场景**：不要滥用，不要直接 `get()`，不要用于字段和构造参数

## 相关笔记

- [[JavaSE基础完整笔记]]
- [[Java基础知识扩展]]
- 并发基础：[[JavaSE基础完整笔记#多线程|多线程]]
