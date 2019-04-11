function EmailTextBox {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)][ScriptBlock] $TextBlock,
        [RGBColors[]] $Color = @(),
        [RGBColors[]] $BackGroundColor = @(),
        [alias('Size')][int[]] $FontSize = @(),
        [ValidateSet('normal', 'bold', 'bolder', 'lighter', '100', '200', '300', '400', '500', '600', '700', '800', '900')][string[]] $FontWeight = @(),
        [ValidateSet('normal', 'italic', 'oblique')][string[]] $FontStyle = @(),
        [ValidateSet('none', 'line-through', 'overline', 'underline')][string[]] $TextDecoration = @(),
        [ValidateSet('normal', 'small-caps')][string[]] $FontVariant = @(),
        [string[]] $FontFamily = @(),
        [ValidateSet('left', 'center', 'right', 'justify')][string[]] $Alignment = @(),
        [ValidateSet('uppercase', 'lowercase', 'capitalize')][string[]] $TextTransform = @(),
        [ValidateSet('rtl')][string[]] $Direction = @(),
        [switch] $LineBreak
    )
    if ($TextBlock) {
        $Text = (Invoke-Command -ScriptBlock $TextBlock)
        if ($Text.Count) {
            $LineBreak = $true
        }
    }
    foreach ($T in $Text) {
        $newHTMLTextSplat = @{
            Alignment       = $Alignment
            FontSize        = $FontSize
            TextTransform   = $TextTransform
            Text            = $T
            Color           = $Color
            FontFamily      = $FontFamily
            Direction       = $Direction
            FontStyle       = $FontStyle
            TextDecoration  = $TextDecoration
            BackGroundColor = $BackGroundColor
            FontVariant     = $FontVariant
            FontWeight      = $FontWeight
            LineBreak       = $LineBreak
        }
        New-HTMLText @newHTMLTextSplat -SkipParagraph
    }
}