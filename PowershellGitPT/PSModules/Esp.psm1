function Invoke-Idf([string] $parameters) {
    & python "F:\repo\library\esp-idf\tools\idf.py" $parameters
}