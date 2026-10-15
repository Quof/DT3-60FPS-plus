@echo off
rem DT3+ Randomizer: opens the Check Tracker and the Item Tracker, each in a window of its own (tracker\open.ps1)
start "" /min powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0tracker\open.ps1"
