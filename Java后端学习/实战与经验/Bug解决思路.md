04月03日
# 1. Caused by: java.lang.IllegalArgumentException: No cache manager could be auto-configured, check your configuration (caching type is 'EHCACHE')

**已查看文件** _pom.xml_

**已检索仓库** _cache configuration ehcache spring boot_ 25 个结果

## 📝 笔记记录

### **问题标题：Spring Boot EhCache 配置缺失**

#### **1️⃣** **问题描述**

在 `springboot_19_cache` 项目中，`application.yml` 配置文件存在以下问题：

- 配置了使用 EhCache 作为缓存实现，但缺少 `ehcache.xml` 配置文件

---

#### **2️⃣** **错误现象**

启动应用时可能出现以下异常：

```
Caused by: java.lang.IllegalStateException: 
No CacheResolver specified, and no unique bean of type CacheManager found. 
Mark one as primary or declare a specific CacheManager to use.
```

---

#### **3️⃣** **根本原因**

**原因 1：缺少 ehcache.xml 配置文件**

- 在 `pom.xml` 中已引入依赖：

```
<dependency>
    <groupId>net.sf.ehcache</groupId>
    <artifactId>ehcache</artifactId>
</dependency>
```

- 在 `application.yml` 中配置了：

```
spring:
  cache:
    type: ehcache
```

- **但** `src/main/resources/` **目录下缺少** `ehcache.xml` **配置文件**

---

#### **4️⃣** **解决方案**

**方案 1：创建 ehcache.xml 配置文件**

在 `src/main/resources/` 下创建 `ehcache.xml`：

```
<?xml version="1.0" encoding="UTF-8"?>
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://ehcache.org/ehcache.xsd">
    
    <!-- 磁盘存储路径 -->
    <diskStore path="java.io.tmpdir"/>
    
    <!-- 默认缓存配置 -->
    <defaultCache
        maxElementsInMemory="10000"
        eternal="false"
        timeToIdleSeconds="120"
        timeToLiveSeconds="120"
        overflowToDisk="true"
        maxElementsOnDisk="10000000"
        diskPersistent="false"
        diskExpiryThreadIntervalSeconds="120"
        memoryStoreEvictionPolicy="LRU"/>
    
    <!-- 短信验证码缓存 -->
    <cache name="smsCode"
           maxElementsInMemory="2000"
           eternal="false"
           timeToIdleSeconds="300"
           timeToLiveSeconds="300"
           overflowToDisk="true"/>
    
    <!-- 图书缓存 -->
    <cache name="books"
           maxElementsInMemory="1000"
           eternal="false"
           timeToIdleSeconds="600"
           timeToLiveSeconds="600"
           overflowToDisk="true"/>
</ehcache>
```

---

#### **5️⃣** **最佳实践建议**

✅ **EhCache 配置要点：**

- 必须提供 `ehcache.xml` 配置文件，放在 `classpath` 根目录（即 `src/main/resources/`）
- 缓存名称要与代码中 `@Cacheable(value = "xxx")` 的 value 值一致
- 合理设置过期时间（timeToIdleSeconds、timeToLiveSeconds）

✅ **其他可选方案：**  
如果不想使用 EhCache，可以改用其他缓存实现：

```
# 使用 Caffeine（推荐，性能更好）
spring:
  cache:
    type: caffeine
    caffeine:
      spec: maximumSize=500,expireAfterAccess=600s

# 或使用 Simple（仅用于开发测试）
spring:
  cache:
    type: simple
```

---

#### **6️⃣** **相关知识点**

🔗 **Spring Cache 常用注解：**

- `@EnableCaching` - 启用缓存（已在启动类添加）
- `@Cacheable` - 查询时缓存数据
- `@CachePut` - 更新缓存
- `@CacheEvict` - 删除缓存

🔗 **常见缓存类型对比：**

|   |   |   |   |
|---|---|---|---|
|缓存类型|优点|缺点|适用场景|
|Simple|无需配置|功能简单|开发测试|
|EhCache|成熟稳定|配置复杂|传统项目|
|Caffeine|性能最优|内存缓存|单机应用|
|Redis|分布式支持|需额外部署|集群环境|

---

#### **7️⃣** **参考链接**

- [Spring Boot Caching](https://docs.spring.io/spring-boot/docs/current/reference/html/io.html#io.caching)
- [EhCache 文档](http://www.ehcache.org/documentation/)
- [MySQL Connector/J 8.0 迁移指南](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-upgrading-to-8.0.html)

---

### 📌 **总结关键词**

`#SpringBoot` `#EhCache` `#缓存配置` `#application.yml` `#异常排查`

---

# 2. nacos 启动异常解决方案

```

需要分析可能的原因：
1. **MySQL 容器状态**：前面看到 MySQL 容器是 `Exited` 状态，可能还没启动。
2. **网络连通性**：Nacos 容器和 MySQL 容器是否在同一 Docker 网络？Docker 容器间用 IP 通信通常没问题，但如果 MySQL 没运行就肯定连不上。
3. **配置生效问题**：修改了 `custom.env` 后，必须**删除并重建容器**，配置才会生效。仅仅 `restart` 是不够的，因为环境变量在容器创建时就固定了。

我需要引导用户：
1. 先确认 MySQL 启动了。
2. 确认 Nacos 是否重建了（因为改了 IP）。
3. 提供
```

核心原因在于 **Docker 容器的环境变量是在创建时固定的，修改** `custom.env` **文件后，必须重建容器才能生效。**

另外，从之前的截图看到 **MySQL 容器是停止状态**，这也会导致 Nacos 报 `No DataSource set`。

请按以下步骤彻底解决：

### 第一步：启动 MySQL

Nacos 强依赖 MySQL，必须确保它先运行。

```
docker start mysql
# 验证一下
docker ps | grep mysql
```

### 第二步：重建 Nacos 容器（关键！）

仅仅 `docker restart` 是不会读取新的 `custom.env` 的。你需要删除旧容器，用新配置重新创建。

```
# 1. 停止并删除旧的 nacos 容器
docker stop nacos
docker rm nacos

# 2. 确保你在 nacos 目录下
cd /root/nacos

# 3. 重新运行创建命令（会重新读取 custom.env）
docker run -d \
--name nacos \
--env-file ./custom.env \
-p 8848:8848 \
-p 9848:9848 \
-p 9849:9849 \
--restart=always \
nacos/nacos-server:v2.1.0-slim
```

### 第三步：验证连接

```
# 1. 查看日志，确认没有报错
docker logs -f nacos

# 2. 看到 "Nacos started successfully" 后，在宿主机测试
curl http://192.168.179.140:8848/nacos/
```

---

# 3. 微服务启动故障排查笔记

## 3.1. 问题1：NoClassDefFoundError - MessageConverter

### 3.1.1. 错误现象

```
java.lang.NoClassDefFoundError: org/springframework/amqp/support/converter/MessageConverter
```

### 3.1.2. 根本原因

`hm-common` 模块中的 `MqConfig` 配置类使用了 Spring AMQP 的类，但 pom.xml 中 AMQP 依赖被标记为 `<scope>provided</scope>`，导致运行时找不到这些类。

### 3.1.3. 解决方案

在 `hm-common/pom.xml` 中移除 AMQP 依赖的 `provided` 作用域：

```
<!-- 修改前 -->
<dependency>
    <groupId>org.springframework.amqp</groupId>
    <artifactId>spring-amqp</artifactId>
    <scope>provided</scope>  <!-- 删除这行 -->
</dependency>
<!-- 修改后 -->
<dependency>
    <groupId>org.springframework.amqp</groupId>
    <artifactId>spring-amqp</artifactId>
</dependency>
```

### 3.1.4. 预防措施

- 公共配置类如果引用了某个依赖的类，该依赖不能使用 `provided` 作用域
- `provided` 仅适用于编译时需要但运行时有容器提供的场景（如 Servlet API）

---

## 3.2. 问题2：端口冲突 - Port 8080 was already in use

### 3.2.1. 错误现象

```
Web server failed to start. Port 8080 was already in use.
```

### 3.2.2. 根本原因

多个微服务配置了相同的端口号（hm-service 和 hm-gateway 都使用了 8080）。

### 3.2.3. 解决方案

修改其中一个服务的端口，确保每个微服务使用不同的端口：

```
# hm-service/src/main/resources/application.yaml
server:
  port: 8087  # 改为其他未被占用的端口
```

### 3.2.4. 端口分配规范

- hm-gateway: 8080（网关入口）
- item-service: 8081
- cart-service: 8082
- user-service: 8084
- trade-service: 8085
- pay-service: 8086
- hm-service: 8087（单体服务）

### 3.2.5. 快速排查命令

```
# 查看占用端口的进程
netstat -ano | findstr :8080

# 强制关闭进程（替换 <PID> 为实际进程ID）
taskkill /F /PID <PID>
```

---

## 3.3. 问题3：Nacos gRPC 连接失败

### 3.3.1. 错误现象

```
Server check fail, please check server 127.0.0.1, port 9848 is available
Connection refused: no further information: /127.0.0.1:9848
```

### 3.3.2. 根本原因

微服务缺少 `bootstrap.yaml` 配置文件，导致 Nacos 客户端使用默认配置连接到 `localhost:8848`，而 Nacos 2.x 的 gRPC 端口是 9848（8848 + 1000）。

### 3.3.3. 解决方案

创建 `bootstrap.yaml` 文件，明确指定 Nacos 服务器地址：

```
# src/main/resources/bootstrap.yaml
spring:
  application:
    name: pay-service
  profiles:
    active: dev
  cloud:
    nacos:
      server-addr: 192.168.179.140:8848  # 必须显式配置
      config:
        file-extension: yaml
        shared-configs:
          - data-id: shared-jdbc.yaml
          - data-id: shared-log.yaml
          - data-id: shared-swagger.yaml
          - data-id: shared-seata.yaml
```

### 3.3.4. 关键知识点

- **bootstrap.yaml** 优先于 application.yaml 加载
- Nacos 2.x 使用 gRPC 协议，端口规则：HTTP端口 + 1000

- HTTP: 8848
- gRPC: 9848

- 所有微服务都必须配置 bootstrap.yaml 指向正确的 Nacos 地址

---

## 3.4. 问题4：数据源初始化失败

### 3.4.1. 错误现象

```
can not init DataSourceResource with HikariDataSource (null)
```

### 3.4.2. 根本原因

pay-service 的 application.yaml 中硬编码了 datasource 配置并使用了占位符 `${hm.db.host}` 和 `${hm.db.pw}`，但这些值没有正确从 Nacos 配置中心获取。

### 3.4.3. 解决方案

移除 application.yaml 中的 datasource 配置，改用 Nacos 共享配置：

```
# 修改前 - 错误的配置
spring:
  datasource:
    url: jdbc:mysql://${hm.db.host}:3306/hm-pay?...
    username: root
    password: ${hm.db.pw}

# 修改后 - 正确的配置
hm:
  db:
    database: hm-pay  # 只指定数据库名称
```

### 3.4.4. 配置加载流程

1. **bootstrap.yaml** 先加载 → 连接 Nacos
2. **从 Nacos 获取 shared-jdbc.yaml** → 包含数据库主机、密码等敏感信息
3. **application.yaml** 提供本地配置 → 只指定数据库名称
4. **最终拼接** → `jdbc:mysql://<host>:3306/hm-pay?...`

### 3.4.5. 最佳实践

- ✅ 数据库连接信息（host、password）放在 Nacos 配置中心
- ✅ 本地 application.yaml 只配置数据库名称（hm.db.database）
- ✅ 所有微服务遵循统一的配置结构
- ❌ 不要在 application.yaml 中硬编码完整的 datasource 配置

---

## 3.5. 通用排查流程

### 3.5.1. 1. 查看完整错误堆栈

- 找到最底层的 `Caused by` 异常
- 识别核心错误类型（ClassNotFoundException、ConnectionRefused 等）

### 3.5.2. 2. 检查配置文件

- 确认 bootstrap.yaml 是否存在且配置正确
- 验证 application.yaml 中的占位符是否有对应值
- 检查端口是否冲突

### 3.5.3. 3. 验证外部依赖

- Nacos 服务器是否正常运行
- 数据库是否可访问
- RabbitMQ 等服务是否正常

### 3.5.4. 4. 对比正常服务

- 参考其他能正常启动的微服务配置
- 保持配置结构的一致性

---

## 3.6. 常用诊断命令

```
# 查看端口占用
netstat -ano | findstr :<端口号>

# 关闭占用端口的进程
taskkill /F /PID <进程ID>

# 测试 Nacos 连通性
curl http://192.168.179.140:8848/nacos/

# 查看 Maven 依赖树
mvn dependency:tree

# 清理并重新编译
mvn clean compile
```

---

## 3.7. 经验总结

1. **依赖作用域要谨慎**：公共模块的依赖不要随意使用 provided
2. **端口规划要明确**：提前规划好每个服务的端口，避免冲突
3. **配置文件要完整**：微服务必须有 bootstrap.yaml 指定注册中心地址
4. **配置分离要做好**：敏感信息放配置中心，本地只配差异化参数
5. **保持一致性**：所有微服务遵循相同的配置规范和结构

---

---

## 🔗 关联笔记
- [[小知识]]
- [[Java后端学习笔记]]
