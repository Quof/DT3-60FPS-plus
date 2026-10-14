# drawat.ps1 <room> <x> <y> [w] [h] [out]: RoomLogic's picture of a room around a point (for checking the logic)
param([string]$room, [int]$x, [int]$y, [int]$w = 900, [int]$h = 500, [string]$out = "")
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$proj = Resolve-Path (Join-Path $here "..\..\..\..")
if ($out -eq "") { $out = Join-Path $env:TEMP ("rl_" + $room + ".png") }
& (Join-Path $here "work\RoomLogic.exe") --draw $proj (Join-Path $here "work\rooms.txt") $room $out (Join-Path $here "work\roomlogic_regions.txt") ([Math]::Max(0, $x - [int]($w / 2))) ([Math]::Max(0, $y - [int]($h / 2))) $w $h | Out-Null
$out
