> 📇 返回 [[求职项目MOC]]

## PaiCLI Windows 终端兼容性完整解决方案

本文档记录在 Windows 环境下运行 PaiCLI 时遇到的两大终端问题（中文乱码与 ANSI 回退）的根因分析、踩坑记录和最终解决方案。

---

### 环境信息

- 操作系统：Windows 10/11
- 终端：Windows Terminal + PowerShell 7（pwsh）
- JDK：17（路径 `D:\Study\Java\utils\jdk-17`）
- PaiCLI：v16.1.0，模型 glm-4.5-air
- JLine 版本：4.0.0（jdk11 classifier）

---

### 问题一：中文乱码（输入回显显示 ???）

**现象：** 用户输入中文后，PaiCLI 回显输入内容时显示为 `???????????`，但模型能正确理解输入并正常执行任务。PaiCLI 内置的中文 UI 文字（如"下一条任务将使用 Plan-and-Execute 模式"）显示正常。

**根因分析：** Windows 控制台默认使用 GBK 代码页（cp936），而 PaiCLI 内部（JLine + Java + LLM API）全链路使用 UTF-8。当用户输入的中文从控制台经 JLine 读取、传入模型、再从模型响应回显到控制台时，经历了 GBK → UTF-8 → GBK 的多轮编码转换，导致部分字符丢失变成问号。PaiCLI 的内置 UI 文字不经过这个往返链路，所以不受影响。

**解决方案（三层配置，缺一不可）：**

**第一层：PowerShell 配置文件（永久生效）**

编辑 PowerShell 7 的配置文件（路径：`C:\Users\<用户名>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`），添加：

```powershell
# 设置控制台输出编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
```

如果配置文件不存在，先创建：

```powershell
if (!(Test-Path -Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE
```

**第二层：JVM 环境变量（双重保险）**

设置用户级环境变量：

```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_TOOL_OPTIONS", "-Dfile.encoding=UTF-8", "User")
```

**第三层：启动前手动确认**

如果仍有问题，在启动 PaiCLI 前执行：

```powershell
chcp 65001
java -jar target/paicli-1.0-SNAPSHOT.jar
```

**重要提醒：** 配置完环境变量后必须重启终端才能生效。`chcp 65001` 必须在 JVM 启动之前执行，因为 JVM 启动时就已经初始化了 I/O 流的编码，之后再改代码页无效。

---

### 问题二：终端不支持 ANSI，inline 模式回退到 plain

**现象：** PaiCLI 启动时显示 `⚠️ 终端不支持 ANSI，inline 模式回退到 plain`，导致无法使用 inline 流式渲染（折叠工具块、彩色状态栏等）。

**根因分析：** PaiCLI 使用 JLine 库探测终端能力。JLine 的 `Terminal.getType()` 在 Windows 上可能返回 `"dumb"`（即使实际运行在支持 ANSI 的 Windows Terminal + pwsh 7 中）。PaiCLI 的 `TerminalCapabilities.supportsAnsi()` 方法在检测到 `"dumb"` 后直接返回 `false`，不会进一步检查 `TERM` 环境变量，导致 ANSI 模式被错误禁用。

**解决方案（需要两层同时配置）：**

**第一层：Windows 注册表启用虚拟终端处理**

在 `HKCU\Console` 下设置 `VirtualTerminalLevel` 为 1：

```powershell
Set-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -Value 1 -Type DWord
```

这告诉 Windows 控制台底层支持 ANSI/VT100 转义序列。

**第二层：设置 TERM 环境变量**

```powershell
[System.Environment]::SetEnvironmentVariable("TERM", "xterm-256color", "User")
```

**第三层：修改 PaiCLI 源码（TerminalCapabilities.java 补丁）**

由于原版代码在 JLine 报告 `dumb` 时直接返回 false，不检查 `TERM` 环境变量，需要打补丁：

```java
public static boolean supportsAnsi(Terminal terminal) {
    if (terminal == null) {
        return false;
    }
    // 系统属性强制覆盖
    if (Boolean.parseBoolean(System.getProperty("paicli.ansi.force"))) {
        return true;
    }
    String type = terminal.getType();
    if (type != null && type.equalsIgnoreCase("dumb")) {
        // JLine 报告 dumb 时，额外信任 TERM 环境变量
        String envTerm = System.getenv("TERM");
        return envTerm != null && !envTerm.equalsIgnoreCase("dumb");
    }
    if (System.getenv("NO_COLOR") != null) {
        return true;
    }
    String envTerm = System.getenv("TERM");
    return envTerm == null || !envTerm.equalsIgnoreCase("dumb");
}
```

补丁后重新编译：`mvn clean package`

**替代方案（不改代码）：** 启动时加 `-Dpaicli.ansi.force=true`：

```powershell
java -Dpaicli.ansi.force=true -jar target/paicli-1.0-SNAPSHOT.jar
```

**注意：** 此补丁每次 `git pull` 或重新 clone 后需要重新打。建议将此补丁提交到项目仓库。

---

### 踩坑记录：试过但不行的方案

**1. TerminalBuilder.encoding("UTF-8")**

在 `Main.java` 中给 `TerminalBuilder` 加 `.encoding("UTF-8")` 会导致更严重的乱码。原因是 JLine 被强制用 UTF-8 字节写入，但 Windows 控制台仍用 GBK 代码页解码，导致 PaiCLI 的 Unicode logo（`██`、`π` 等）全部变成乱码（如 `鋁焊枡`、`蟺`）。正确做法是不指定 encoding，让 JLine 自动匹配控制台编码。

**2. JAVA_TOOL_OPTIONS 加 -Djline.terminal.force.xterm=true**

这个参数会强制 JLine 使用 xterm 终端模式，导致所有输出（包括 logo、UI 文字、模型响应）全部乱码。绝对不要加这个参数。

**3. JAVA_TOOL_OPTIONS 加 -Dsun.stdout.encoding / -Dsun.stderr.encoding**

`-Dsun.stdout.encoding=UTF-8` 和 `-Dsun.stderr.encoding=UTF-8` 是 Java 18+ 才支持的属性，且在某些场景下可能与 Windows 控制台编码冲突。只保留 `-Dfile.encoding=UTF-8` 即可。

**4. 只设 chcp 65001 不设 PowerShell 配置**

`chcp 65001` 只对当前终端窗口有效，关闭窗口后失效。必须写入 `$PROFILE` 才能永久生效。

**5. 改完环境变量不重启终端**

所有环境变量修改（`JAVA_TOOL_OPTIONS`、`TERM`、注册表）都必须重启终端（或重启系统）后才能生效。当前终端中已经运行的 Java 进程不会读取到新值。

**6. 用 PowerShell 5.1 运行**

Windows 自带的旧版 PowerShell 5.1（`powershell.exe`）对 ANSI 和 UTF-8 支持很差。即使装在 Windows Terminal 里，JLine 仍会报 `dumb` 终端。必须用 PowerShell 7（`pwsh.exe`，通过 `winget install Microsoft.PowerShell` 安装），并在 Windows Terminal 设置中将其设为默认配置文件。

---

### 一键配置脚本

将以下 PowerShell 脚本保存为 `setup-paicli-env.ps1`，以管理员权限运行一次即可完成所有环境配置：

```powershell
# 1. 安装 PowerShell 7（如果未安装）
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "正在安装 PowerShell 7..."
    winget install Microsoft.PowerShell
}

# 2. 注册表：启用虚拟终端
Set-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -Value 1 -Type DWord
Write-Host "已启用虚拟终端支持"

# 3. 环境变量
[System.Environment]::SetEnvironmentVariable("JAVA_TOOL_OPTIONS", "-Dfile.encoding=UTF-8", "User")
[System.Environment]::SetEnvironmentVariable("TERM", "xterm-256color", "User")
Write-Host "已设置 JAVA_TOOL_OPTIONS 和 TERM"

# 4. PowerShell 7 配置文件
$pwshProfileDir = Split-Path (pwsh -NoProfile -c 'echo $PROFILE') -Parent
if (-not (Test-Path $pwshProfileDir)) { New-Item -ItemType Directory -Path $pwshProfileDir -Force | Out-Null }
$pwshProfile = Join-Path $pwshProfileDir "Microsoft.PowerShell_profile.ps1"
$utf8Config = @"

# UTF-8 encoding for PaiCLI and other Java CLI tools
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
"@
if (-not (Test-Path $pwshProfile) -or -not (Get-Content $pwshProfile | Select-String "chcp 65001")) {
    Add-Content -Path $pwshProfile -Value $utf8Config -Encoding UTF8
    Write-Host "已写入 PowerShell 7 配置文件: $pwshProfile"
} else {
    Write-Host "PowerShell 7 配置文件已包含 UTF-8 设置，跳过"
}

Write-Host ""
Write-Host "配置完成！请重启 Windows Terminal，然后运行："
Write-Host "  java -jar target/paicli-1.0-SNAPSHOT.jar"
```

---

### 最终配置清单

| 配置项 | 值 | 作用 | 设置方式 |
|--------|-----|------|----------|
| `HKCU\Console\VirtualTerminalLevel` | 1 (DWORD) | 启用 Windows 控制台 ANSI 支持 | 注册表 |
| `TERM` | `xterm-256color` | 让 TerminalCapabilities 信任终端能力 | 用户环境变量 |
| `JAVA_TOOL_OPTIONS` | `-Dfile.encoding=UTF-8` | JVM 内部使用 UTF-8 | 用户环境变量 |
| `$PROFILE` | `OutputEncoding + chcp 65001` | 每次启动 pwsh 自动设 UTF-8 | 配置文件 |
| `TerminalCapabilities.java` | 补丁（检查 TERM） | 修复 JLine dumb 误判 | 源码修改 |
| PowerShell 版本 | 7.x（pwsh） | 更好的终端兼容性 | `winget install` |
| Windows Terminal 默认 profile | PowerShell 7 | 确保新标签页用 pwsh 7 | Windows Terminal 设置 |
