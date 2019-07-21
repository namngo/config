
# Alias

# Various
New-Alias  Out-Clipboard $env:SystemRoot\system32\clip.exe

# Goto
Set-Alias goto -Value Enter-Repository

# Open
Set-Alias open-home -Value Open-RepositoryHomePage
Set-Alias open-pr -Value Open-RespositoryPullRequestPage
Set-Alias open-newpr -Value Open-NewPullRequest

# Launch
Set-Alias Invoke-VS -Value Invoke-VisualStudio