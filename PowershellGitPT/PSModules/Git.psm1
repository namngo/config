function Set-GitConfig {
    git config --global alias.br branch
    git config --global alias.cp cherry-pick
    git config --global alias.co checkout
    git config --global alias.ci commit
    git config --global alias.st status
}

function Commit-Changes([string] $message) {
    git add *
    git commit -m "$message"
}

function Push-Changes([string] $message) {
    Commit-Changes $message
    git pull
    git push
}

function New-Branch ([string] $branch) {
    git pull
    git checkout -b $branch
    git push -u origin $branch
}

function New-DevBranch([string] $branch) {
    $branch = "dev/$branch"
    New-Branch $branch
}

function Remove-Branch([string[]] $branches) {
    $branches | foreach {
        git branch -D "$_"
        git push --delete origin "$_"
    }

    git pull --prune
}

function Merge-Remote([string] $remoteBranch) {
    git fetch
    git merge "origin/$remoteBranch"
}

function Clear-Repository()
{
    git reset --hard
    git gc --aggressive
    git prune
    git clean -df
}

function Write-CurrentBranch()
{
    $branch = git symbolic-ref --short HEAD
    if (![string]::IsNullOrEmpty($branch))
    {
        if ($branch -ne "HEAD")
        {
            Write-Host $branch -NoNewline -ForegroundColor Yellow
        }
        else {
            $branch = git rev-parse --short HEAD
            Write-Host $branch -NoNewline -ForegroundColor Red
        }
    }
}

function Test-GitFolder([string] $path)
{
    if (Test-Path "$path\.git") {
        return $true;
    }

    while (-not [string]::IsNullOrEmpty($path)) {
        $parent = (Get-Item $path).Parent
        if ($parent -eq $null)
        {
            return $false;
        }

        $path = $parent.FullName
        if (Test-Path "$path\.git") {
            return $true;
        }
    }
}
