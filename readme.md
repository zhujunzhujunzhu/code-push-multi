# 多仓库推送工具

## 目标

实现将本地的代码仓库一次性推送到 Gitee、GitHub 和公司的内部 Git 仓库。

## 设计方案

我们将采用 Git 内置的 `remote` 功能来实现此目标。核心思路是为一个远程仓库名称（例如 `all`）配置多个推送 URL。

### 步骤

1.  **添加第一个远程仓库：**
    正常添加第一个远程仓库地址，例如 Gitee。

    ```bash
    git remote add all <gitee_repo_url>
    ```

2.  **添加额外的远程仓库：**
    使用 `git remote set-url --add` 命令，为我们刚刚创建的 `all` remote 添加更多的推送地址。

    ```bash
    # 添加 GitHub 仓库
    git remote set-url --add all <github_repo_url>

    # 添加公司仓库
    git remote set-url --add all <company_repo_url>
    ```

3.  **验证配置：**
    使用 `git remote -v` 可以查看到 `all` 这个 remote 已经配置了多个 push 地址。

    ```
    all <gitee_repo_url> (fetch)
    all <gitee_repo_url> (push)
    all <github_repo_url> (push)
    all <company_repo_url> (push)
    ```

4.  **一键推送：**
    当需要推送到所有仓库时，只需要执行：

    ```bash
    git push all <branch-name>
    ```

    这样，Git 就会将指定的 `<branch-name>` 分支推送到 `all` remote 下配置的所有 push 地址。

## 优点

*   **无需额外工具：** 完全利用 Git 自身功能，不需要安装任何第三方软件或脚本。
*   **简单易用：** 配置一次后，日常使用与普通的 `git push` 命令几乎没有差别。
*   **跨平台：** 只要安装了 Git，此方法在 Windows, macOS, Linux 上都完全适用。

## 后续扩展

为了让命令更加简便，我们可以考虑创建一个简单的脚本（例如 `push-all.sh` 或 `push-all.ps1`），来封装 `git push all` 命令，甚至可以增加一些参数处理，例如自动推送当前分支等。

## 脚本使用

项目内提供了一个 PowerShell 脚本 `push-all.ps1` 来简化推送操作。

**默认推送当前分支：**

```powershell
./push-all.ps1
```

**推送到指定分支：**

```powershell
./push-all.ps1 your-branch-name
```