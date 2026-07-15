# 1. 1

1

# 2. 2

2

# 3. NoSQL 数据库分类

## 3.1. Key—Value 存储

Key—Value 存储这一类数据库主要会使用到哈希表，在这个表中有一行特定方键和一个指针指向特定的数据。Key_value 模型对于 IT 系统来说优势在于简单、易部署。典型的 Key-Value 数据库有 MemcacheDB,Redis。

## 3.2. 文档存储

文档存储以【文档】为基本单位，数据以 JSON/BSON 格式存储，无需预选定义表结构，每个文档可拥有不同的字段，天然适配灵活的业务场景。典型的文档存储的数据库有 **MongoDB**、CouchDB。（文档存储可以随机构建层次结构的关系）

# 4. 数据库架构

## 4.1. 单机架构

单机架构的优点：

能部署集中、运维方便

缺点：

只有纵向扩展

### 4.1.1. 分组架构、主备架构

### 4.1.2. 分组架构、主从架构

### 4.1.3. 分组架构、多主架构

# 5. MongoDB

## 5.1.

## 5.2. collection 操作

**（1）集合式创建：**

**db.createCollection(name)** #创建集合

**（2）集合的隐式创建：**

**db.集合名.insert({id:1,name:forlan})**;

没有这个集合不会报错会自动创建

**注意集合的命名规范：**

- 不能是空字符串
- 不能有 \0 字符（空字符），这个字符表示集合名的结尾
- 不能以"system."开头

**(3)查看集合**

**show tables** 或 **show collections**

**db.collections.status()**

**(4)删除集合**

删除当前集合（集合消失）

**db.collections.drop()**

清空一个集合（集合保留）

**db.collection.remove({})**

**db.collection.deleteMany()**

(5)

db.getCollectionNames()获取当前集合

---

## 5.3. document 操作

### 5.3.1. 文档增

（1）单文档插入

**db.collection.insertOne({k1:v1,k2:v2});**

（2）多文档插入

**db.collection.insertMany([{键值对}, {}，{}, ....]);**

（3）单 、 多个文档的插入

**db.collection.insert([{1:v1,k2:v2},{1:v1,k2:v2}...]);**

### 5.3.2. 文档查

（1）

**db.collections.find()**

（2）

（3）查询一个文档

**db.collections.findOne()**

（4）

（5）复合查询(并且，或者)

（6）type 查询

---

## 5.4. 模糊查询--查询排序

**db.集合名.find().sort({"age" : -1})**

注意： -1 逆序，1 顺序

---

## 5.5. 模糊查询--分页查询

①

**db.citys.find().limit(3)**

②

**db.citys.find().limit(4).skip(2)**

---

## 5.6. 模糊查询--正则表达式

**①**

**$regrex**

**②**

**{$regrex：/^xxx/}**

**③**

**{$regrex：/xxx$/}**

**④ 查询忽略大小写**

**{$regrex：/xxx/i}**

---

# 6. 复制集

## 6.1. 复制集的三大校色

主节点（Primary）

唯一的写入口，负责接收并处理

从节点（Secondary）

仲裁节点（Arbiter）

# 7. 分片

## 7.1.

Shard（分片节点）：集群的数据存储核心

集群中真正负责存储业务数据的物理节点。

Config Server（配置服务器）：集群的“大脑”与元数据中心

Mongos （路由节点）：应用程序的唯一接入入口

解析请求，路由转发

## 7.2. 核心原理：水平分片与 Chunk

### 7.2.1. 水平分片（Sharding）

按"行"拆分数据

### 7.2.2. Chunk（数据库块）

### 7.2.3. 均衡器（Balancer）

---

## 7.3. 核心原理：片键策略（Shard Key）

范围分片

哈希分片

组合分键

## 7.4. 工作流程：写入与查询
## 5.3. document 操作

### 5.3.1. 文档增

（1）单文档插入

**db.collection.insertOne({k1:v1,k2:v2});**

（2）多文档插入

**db.collection.insertMany([{键值对}, {}，{}, ....]);**

（3）单 、 多个文档的插入

**db.collection.insert([{1:v1,k2:v2},{1:v1,k2:v2}...]);**

### 5.3.2. 文档查

（1）

**db.collections.find()**

（2）

（3）查询一个文档

**db.collections.findOne()**

（4）

（5）复合查询(并且，或者)

（6）type 查询

---

## 5.4. 模糊查询--查询排序

**db.集合名.find().sort({"age" : -1})**

注意： -1 逆序，1 顺序

---

## 5.5. 模糊查询--分页查询

①

**db.citys.find().limit(3)**

②

**db.citys.find().limit(4).skip(2)**

---

## 5.6. 模糊查询--正则表达式

**①**

**$regrex**

**②**

**{$regrex：/^xxx/}**

**③**

**{$regrex：/xxx$/}**

**④ 查询忽略大小写**

**{$regrex：/xxx/i}**

---

# 6. 复制集

## 6.1. 复制集的三大校色

主节点（Primary）

唯一的写入口，负责接收并处理

从节点（Secondary）

仲裁节点（Arbiter）

# 7. 分片

## 7.1.

Shard（分片节点）：集群的数据存储核心

集群中真正负责存储业务数据的物理节点。

Config Server（配置服务器）：集群的“大脑”与元数据中心

Mongos （路由节点）：应用程序的唯一接入入口

解析请求，路由转发

## 7.2. 核心原理：水平分片与 Chunk

### 7.2.1. 水平分片（Sharding）

按"行"拆分数据

### 7.2.2. Chunk（数据库块）

### 7.2.3. 均衡器（Balancer）

---

## 7.3. 核心原理：片键策略（Shard Key）

范围分片

哈希分片

组合分键

## 7.4. 工作流程：写入与查询

---

## 🔗 关联笔记
- [[数据库与中间件]]
- [[MySQL笔记]]
- [[Redis笔记]]
