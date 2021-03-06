<#
    This script fetches the line numbers for a given search value
#>


param (
    [Parameter(Mandatory = $true)]
    [string] $match
)
$newmatch = [regex]::Escape($match)

$arr = @()
$arr = get-content C:\Users\cherendeen\Documents\work_info\xml_util\powershell_tests\tds_sheets.xsl | select-string $newmatch | select Line,LineNumber
#Write-Host "----------------------------------------------------"
#$arr = get-content C:\Users\cherendeen\Documents\work_info\xml_util\powershell_tests\tds_sheets.xsl | select-string $newmatch | select LineNumber
Write-Host $arr

$arrNew = $arr | Select -ExpandProperty "LineNumber"
$lineNums = [String]::Join( ", ", $arrNew )
Write-Host $lineNums