# DT3+ Randomizer: opens the Check Tracker and the Item Tracker each in a window of its own (Microsoft Edge's app
# windows: no address bar or tabs; without Edge, the default browser), sized to the page, and with -OnTop always on top
# of other windows (the game's too). Run by "Open Trackers.bat" and "Open Trackers (Always on Top).bat" in the mod folder
param([switch]$OnTop)

# each window: its page, the page's title (how the window is found once it's open) and its size, inside the frame, in
# the page's own pixels (Windows' display scaling is added). Change the sizes here
$windows = @(
  @{ Page = 'checks.html'; Title = 'DT3+ Check Tracker'; Width = 620; Height = 560 },
  @{ Page = 'items.html';  Title = 'DT3+ Item Tracker';  Width = 470; Height = 645 }
)

Add-Type @"
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
public static class DT3TrackerWin {
  public delegate bool EnumProc(IntPtr h, IntPtr l);
  [StructLayout(LayoutKind.Sequential)] public struct RECT { public int L, T, R, B; }
  [DllImport("user32.dll")] static extern bool EnumWindows(EnumProc f, IntPtr l);
  [DllImport("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
  [DllImport("user32.dll")] static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr h, IntPtr after, int x, int y, int w, int hh, uint f);
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
  [DllImport("user32.dll")] public static extern bool GetClientRect(IntPtr h, out RECT r);
  [DllImport("user32.dll")] public static extern uint GetDpiForWindow(IntPtr h);
  [DllImport("user32.dll")] public static extern IntPtr SetThreadDpiAwarenessContext(IntPtr c);
  public static List<IntPtr> Find(string title) {
    var found = new List<IntPtr>();
    EnumWindows((h, l) => {
      if (IsWindowVisible(h)) {
        var s = new StringBuilder(512);
        GetWindowText(h, s, 512);
        if (s.ToString() == title) found.Add(h);
      }
      return true;
    }, IntPtr.Zero);
    return found;
  }
}
"@

# (the window sizes in the screen's own pixels: this script per-monitor DPI aware)
[void][DT3TrackerWin]::SetThreadDpiAwarenessContext([IntPtr](-4))
$dir = Join-Path $PSScriptRoot ''
$edge = $true
foreach ($w in $windows) {
  $w.Before = @([DT3TrackerWin]::Find($w.Title))
  $url = ([uri](Join-Path $dir $w.Page)).AbsoluteUri
  try { Start-Process msedge -ArgumentList ('--app=' + $url), ('--window-size=' + $w.Width + ',' + $w.Height) -ErrorAction Stop }
  catch { $edge = $false; Start-Process (Join-Path $dir $w.Page) }
}
if (-not $edge) { exit }

# each new window, once its page has loaded (its title is the page's): its size, and on top or not
$flags = 0x0002 -bor 0x0010          # SWP_NOMOVE, SWP_NOACTIVATE
if ($OnTop) { $after = [IntPtr](-1) } else { $after = [IntPtr](-2) }   # HWND_TOPMOST, HWND_NOTOPMOST
$deadline = (Get-Date).AddSeconds(20)
$todo = [System.Collections.ArrayList]@($windows)
while ($todo.Count -gt 0 -and (Get-Date) -lt $deadline) {
  foreach ($w in @($todo)) {
    $new = @([DT3TrackerWin]::Find($w.Title) | Where-Object { $w.Before -notcontains $_ })
    if ($new.Count -eq 0) { continue }
    $h = $new[0]
    $s = [DT3TrackerWin]::GetDpiForWindow($h) / 96.0
    if ($s -le 0) { $s = 1 }
    $wr = New-Object DT3TrackerWin+RECT
    $cr = New-Object DT3TrackerWin+RECT
    [void][DT3TrackerWin]::GetWindowRect($h, [ref]$wr)
    [void][DT3TrackerWin]::GetClientRect($h, [ref]$cr)
    $fw = ($wr.R - $wr.L) - ($cr.R - $cr.L)
    $fh = ($wr.B - $wr.T) - ($cr.B - $cr.T)
    [void][DT3TrackerWin]::SetWindowPos($h, $after, 0, 0, [int]($w.Width * $s) + $fw, [int]($w.Height * $s) + $fh, $flags)
    $todo.Remove($w)
  }
  Start-Sleep -Milliseconds 250
}
