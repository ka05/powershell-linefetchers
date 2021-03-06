<# 
    ABOUT:
    
    This file takes in a csv of values to be searched for 
    then loops through all of the values calling Get-Value-LineNums 
    
    It then creates a csv file "outputLineNums.csv" with the corresponding line numbers for each value
#>

$AllObjects = @()
$csvFile = Import-CSV "C:\Users\cherendeen\Documents\work_info\Lightnin\Proposals\LineNumFetchers\valueLineNums.csv"


$csvFormat =
            @{ Label = "values";           Expression = { $_.values } },
            @{ Label = "linenums";           Expression = {  Get-Value-LineNums $_.values } }

$csvFile | Select-Object $csvFormat | Export-Csv "C:\Users\cherendeen\Documents\work_info\Lightnin\Proposals\LineNumFetchers\outputLineNums.csv" -Delimiter "," -NoTypeInformation -Encoding UTF8

<#
    Get-Value-LineNums : returns the line numbers for a given search value
#>
function Get-Value-LineNums{
    param (
        [Parameter(Mandatory = $true)]
        [string] $match
    )
    $linNums = ""
    
    # for id searches
    $strMatch = "'" + $match + "'"
    #$newmatch = [regex]::Escape('<xsl:with-param name="attr_name" select="' + $($strMatch)+ '"/>')
    $newmatch = [regex]::Escape($strMatch)

    $arr = @()
    Write-Host "Search Val: $($match)"
    $arr = get-content C:\Users\cherendeen\Documents\work_info\xml_util\powershell_tests\tds_sheets.xsl | select-string $newmatch | select Line,LineNumber 
    Write-Host $arr
    
    $arrNew = $arr | Select -ExpandProperty "LineNumber"
    $lineNums = [String]::Join( ", ", $arrNew )
    Write-Host $lineNums
    return $lineNums
}
