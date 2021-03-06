param (
    [Parameter(Mandatory = $true)]
    [string] $match
)

$linNums = ""

# for id searches
$strMatch = "'" + $match + "'"
$newmatch = [regex]::Escape('<xsl:with-param name="attr_name" select="' + $($strMatch)+ '"/>')

# For regular searches
#$newmatch = [regex]::Escape($match)

$arr = @()
Write-Host
Write-Host "Search Val: $($match)"
Write-Host
$arr = get-content C:\Users\cherendeen\Documents\work_info\xml_util\powershell_tests\tds_sheets.xsl | select-string $newmatch | select Line,LineNumber 
Write-Host $arrSG

$arrNew = $arr | Select -ExpandProperty "LineNumber"
$lineNums = [String]::Join( ", ", $arrNew )
Write-Host $lineNums