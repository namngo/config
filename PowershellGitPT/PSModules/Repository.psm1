
function Enter-Repository([string] $repositoryAlias) {
    $repositoryAlias = $repositoryAlias.ToLowerInvariant()

    if ($projectFolders -eq $null) {
        [string[]] $projectFolders =  @()
    }
    if ($repositoriesAliasMapping -eq $null) {
        $repositoriesAliasMapping = @{}
    }

    [string] $currentFolder = Get-Location
    $foldersToTest = $projectFolders + ($currentFolder.TrimEnd('\') + '\') | select -Unique
    foreach($folderToTest in $foldersToTest) {
        $repositories = @([System.IO.Path]::Combine($folderToTest, $repositoryAlias))
        if ($repositoriesAliasMapping.ContainsKey($repositoryAlias)) {
            $repositories = $repositories + [System.IO.Path]::Combine($folderToTest, $repositoriesAliasMapping[$repositoryAlias])
        }
        foreach($repository in $repositories) {
            if (Test-Path $repository) {
                Set-Location $repository
                return
            }
        }
    }
    Write-Error "Cannot find repository '$repositoryAlias'. Look in: '$foldersToTest'"
}

function Get-RepositoryUrl {
    [string] $url = git config --get remote.origin.url
    return $url
}

function Get-RepositoryBranch {
    [string] $branch = git rev-parse --abbrev-ref HEAD
    return $branch
}

function Open-RepositoryHomePage {
    $url = Get-RepositoryUrl
    if ($url -ne $null) {
        [System.Diagnostics.Process]::Start($url) | Out-Null
    }
}

function Open-NewPullRequest([string]$targetBranch = "develop") {
    $url = Get-RepositoryUrl
    if ($url -ne $null) {
        $topicBranch = Get-RepositoryBranch
        $url = $url.TrimEnd('/')
        $url = "$url/pullrequestcreate?targetRef=$targetBranch&sourceRef=$topicBranch"
        [System.Diagnostics.Process]::Start($url) | Out-Null
    }
}

function Open-PullRequestHome {
    $url = Get-RepositoryUrl
    if ($url -ne $null) {
        $url = $url.TrimEnd('/')
        $url = "$url/pullrequests"
        [System.Diagnostics.Process]::Start($url) | Out-Null
    }
}