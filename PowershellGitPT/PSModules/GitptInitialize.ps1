if ($repoRootFolder -eq $null) {
    $repoRootFolder = "F:\repo\"
}

$projectFolders = @($repoRootFolder, "$repoRootFolder`Side\", $repoRootFolder+"config\", $repoRootFolder +"electronic\")
$repositoriesAliasMapping = @{
    "psgitpt" = "PowershellGitPT";
    "df" = "DragonFly";
    "car" = "CarLightEsp32";
}

Import-Module $PSScriptRoot\Esp.psm1 -DisableNameChecking
Import-Module $PSScriptRoot\Git.psm1 -DisableNameChecking
Import-Module $PSScriptRoot\Alias.psm1 -DisableNameChecking
Import-Module $PSScriptRoot\Repository.psm1 -DisableNameChecking


# Set powershell environment
$myprofile = "$PSScriptRoot\GitPTInitialize.ps1"

Set-Location $projectFolders[0]

function prompt
{
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "  $('>' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base" -NoNewline

    $isGitFolder = Test-GitFolder $path

    if ($isGitFolder) {
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-Host " (" -NoNewline
        Write-CurrentBranch
        Write-Host ")"
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green"
    }

    return $userPrompt
}
