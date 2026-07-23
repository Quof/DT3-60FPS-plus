/*
Call once when the game is closing, if practical.
*/

if global.comparisonInputEnabled = 1
{
    external_free("GlobalKeyboard.dll");
}

global.comparisonInputEnabled = 0;
global.globalKeyIsDown = -1;
