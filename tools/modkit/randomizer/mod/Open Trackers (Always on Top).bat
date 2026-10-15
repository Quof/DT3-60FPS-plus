@echo off
rem DT3+ Randomizer: opens the Check Tracker and the Item Tracker, each in a window of its own, always on top of other
rem windows (the game's too: tracker\open.ps1)
start "" /min powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0tracker\open.ps1" -OnTop
