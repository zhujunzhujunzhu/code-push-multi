# 获取当前分支名称
$currentBranch = git rev-parse --abbrev-ref HEAD

# 如果用户提供了分支名称参数，则使用用户提供的分支
if ($args.Count -gt 0) {
    $branchToPush = $args[0]
} else {
    $branchToPush = $currentBranch
}

# 执行推送命令
Write-Host "准备推送到 all remote, 分支: $branchToPush"
git push all $branchToPush