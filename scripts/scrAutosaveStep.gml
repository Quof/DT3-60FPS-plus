/*
autosave change (added): steps Autosave (global.autosaveFreq, minutes between autosaves: see remasterSwitchList)
through off, 5, 15 and 30 minutes, and around. Used by oPauseMenu's dipswitch list.
argument0: 1 = up a step, -1 = down a step
*/
if argument0>0
{
  if global.autosaveFreq<5 {global.autosaveFreq=5}
  else if global.autosaveFreq<15 {global.autosaveFreq=15}
  else if global.autosaveFreq<30 {global.autosaveFreq=30}
  else {global.autosaveFreq=0}
}
else
{
  if global.autosaveFreq>15 {global.autosaveFreq=15}
  else if global.autosaveFreq>5 {global.autosaveFreq=5}
  else if global.autosaveFreq>0 {global.autosaveFreq=0}
  else {global.autosaveFreq=30}
}
