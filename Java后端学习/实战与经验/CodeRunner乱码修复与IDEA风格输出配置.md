## VS Code Code Runner 中文乱码修复与 IDEA 风格输出配置

### 问题描述

在 Windows 中文系统下使用 VS Code 的 Code Runner 插件运行 Python 脚本时，中文输出显示为乱码（如 `?μ?ε?ε?εC??`），且输出格式与 IntelliJ IDEA 差异较大——没有显示执行的命令和退出码。

### 原因分析

Windows 中文系统的终端默认编码是 GBK（代码页 936），Python 的 `print()` 会按终端编码输出字节。但 Code Runner 的**输出面板**（Output Panel）内部按 UTF-8 解读这些字节，编码不匹配导致中文全部乱码。

简单来说：Python 用 GBK 编码输出 → 输出面板用 UTF-8 解码 → 对不上 → 乱码。

### 解决方案

#### 一、修复乱码：设置 PYTHONIOENCODING 环境变量

通过设置 `PYTHONIOENCODING=utf-8`，强制 Python 的 stdin/stdout/stderr 统一使用 UTF-8 编码输出，与 VS Code 输出面板的解读方式一致。

**设置方式（用户级环境变量，永久生效）：**

以管理员身份打开 PowerShell，执行：

```powershell
[System.Environment]::SetEnvironmentVariable('PYTHONIOENCODING', 'utf-8', 'User')
```

设置完成后**必须重启 VS Code**，让新的环境变量生效。

> 也可以在 VS Code 的 `settings.json` 中通过 `terminal.integrated.env.windows` 设置，但这只对集成终端生效，对 Code Runner 的输出面板无效。所以推荐用系统环境变量的方式。

**验证是否生效：**

```powershell
[System.Environment]::GetEnvironmentVariable('PYTHONIOENCODING', 'User')
# 应输出: utf-8
```

#### 二、配置 IDEA 风格输出

修改 VS Code 用户设置文件 `settings.json`（路径：`%APPDATA%\Code\User\settings.json`），调整 Code Runner 相关配置：

```json
{
  "code-runner.runInTerminal": false,
  "code-runner.clearPreviousOutput": true,
  "code-runner.showExecutionMessage": true,
  "code-runner.executorMap": {
    "python": "$pythonPath -u \"$fullFileName\" && echo. && echo Process finished with exit code %ERRORLEVEL%"
  }
}
```

**各配置项说明：**

| 配置项 | 值 | 作用 |
|--------|------|------|
| `runInTerminal` | `false` | 在输出面板运行，而非集成终端。终端模式会导致多次运行结果累积不清除 |
| `clearPreviousOutput` | `true` | 每次运行前清除上次的输出，保持面板干净 |
| `showExecutionMessage` | `true` | 在输出顶部显示正在执行的命令 |
| `executorMap.python` | 见上方 | 自定义 Python 执行命令，末尾追加退出码显示 |

**executorMap 命令拆解：**

```
$pythonPath -u "$fullFileName"    # 运行当前 Python 文件（-u 表示无缓冲输出）
&& echo.                           # 输出一个空行，分隔结果和退出码
&& echo Process finished with exit code %ERRORLEVEL%   # 显示退出码
```

其中 `$pythonPath` 和 `$fullFileName` 是 Code Runner 的内置变量，会自动替换为当前 Python 解释器路径和当前文件完整路径。`%ERRORLEVEL%` 是 Windows CMD 的环境变量，保存上一条命令的退出码。

#### 三、最终效果

运行后输出面板显示如下，与 IntelliJ IDEA 风格一致：

```
[Running] python -u "d:\Workspace\Code_Test\Agent_study\P3_LangChainRAG开发\12模版类的format和invoke方法.py"
我的邻居是：张小明,最喜欢：钓鱼 <class 'str'>

Process finished with exit code 0
```

### 常见问题

**Q：设置环境变量后重启 VS Code 仍然乱码？**

确认环境变量已正确写入用户级别（而非仅当前会话）。在 PowerShell 中运行 `[System.Environment]::GetEnvironmentVariable('PYTHONIOENCODING', 'User')` 应返回 `utf-8`。如果返回空值，说明没有写入成功，需要重新执行设置命令。

**Q：为什么不用 `chcp 65001` 切换终端编码？**

`chcp 65001` 只影响集成终端的编码，对 Code Runner 的输出面板无效。而且切换代码页可能影响其他命令行工具的行为。`PYTHONIOENCODING` 方案更精准，只影响 Python 的输入输出编码。

**Q：为什么 `runInTerminal` 要设为 `false`？**

终端模式下，Code Runner 不会在每次运行时清屏，多次运行的输出会累积在同一个终端中。而且终端的退出码显示依赖终端自身的提示符，不如输出面板可控。输出面板配合 `clearPreviousOutput: true` 可以实现每次运行都是干净的输出。


---

## 🔗 关联笔记
- [[小知识]]
