/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Records submenu.
*/

//Display page
draw_set_color(textColorShadow)
draw_rectangle(contentMenuX+289,contentMenuY+28,contentMenuX+301,contentMenuY+40,1)
draw_rectangle(contentMenuX+289,contentMenuY+43,contentMenuX+301,contentMenuY+55,1)
draw_rectangle(contentMenuX+289,contentMenuY+58,contentMenuX+301,contentMenuY+70,1)
draw_rectangle(contentMenuX+289,contentMenuY+73,contentMenuX+301,contentMenuY+85,1)
draw_rectangle(contentMenuX+289,contentMenuY+88,contentMenuX+301,contentMenuY+100,1)
draw_rectangle(contentMenuX+289,contentMenuY+103,contentMenuX+301,contentMenuY+115,1)
draw_rectangle(contentMenuX+289,contentMenuY+118,contentMenuX+301,contentMenuY+130,1)
//Recognition tab boxes
draw_set_color(colorRecognitionBox)
draw_rectangle(contentMenuX+304,contentMenuY+28,contentMenuX+316,contentMenuY+36,1)
draw_rectangle(contentMenuX+304,contentMenuY+39,contentMenuX+316,contentMenuY+47,1)
draw_rectangle(contentMenuX+304,contentMenuY+50,contentMenuX+316,contentMenuY+58,1)
draw_rectangle(contentMenuX+304,contentMenuY+61,contentMenuX+316,contentMenuY+69,1)
draw_rectangle(contentMenuX+304,contentMenuY+72,contentMenuX+316,contentMenuY+80,1)
draw_rectangle(contentMenuX+304,contentMenuY+83,contentMenuX+316,contentMenuY+91,1)
draw_rectangle(contentMenuX+304,contentMenuY+94,contentMenuX+316,contentMenuY+102,1)
draw_rectangle(contentMenuX+304,contentMenuY+105,contentMenuX+316,contentMenuY+113,1)
draw_rectangle(contentMenuX+304,contentMenuY+116,contentMenuX+316,contentMenuY+124,1)
draw_rectangle(contentMenuX+304,contentMenuY+127,contentMenuX+316,contentMenuY+135,1)
draw_rectangle(contentMenuX+304,contentMenuY+138,contentMenuX+316,contentMenuY+146,1)

if mR_Tab=1
{
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+mR_CurX,contentMenuY+mR_CurY,contentMenuX+mR_CurX+8,contentMenuY+mR_CurY+8,0) //cursor
}
else
{
  draw_set_color(colorRecognitionBox)
  draw_rectangle(contentMenuX+mR_CurX,contentMenuY+mR_CurY,contentMenuX+mR_CurX+8,contentMenuY+mR_CurY+4,0) //cursor
}
draw_set_color(textColorShadow)

//Display records
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_left)
draw_set_alpha(1)
var tRecSeperator,tEndSep,tTotalSep;
tRecSeperator=0; tEndSep=191
if mR_Page>=1 and mR_Page<=6 {tTotalSep=13}
else if mR_Page=7 {tTotalSep=8}

if mR_Tab=1
{
  for(i=0;i<tTotalSep;i+=1)
  {
    textDropShadow("...",contentMenuX+178,contentMenuY+15+tRecSeperator,textColorMain,textColorShadow,1)
    tRecSeperator+=12
  }

  if mR_Page=1 //---------- Page 1 (Record) ----------
  {
    var tRecHitPercent;
    if global.recAtkNum=0
      tRecHitPercent=0
    else
      tRecHitPercent=(global.recAtkHit/global.recAtkNum)*100

    if global.recKillCount=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Kills",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recDeathCount=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Deaths",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recTotalAP=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Total AP Gained",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recDistFoot=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Distance On Foot",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recDistAir=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("Distance In Air",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recJumped=0
       textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("Jumped",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recDashForward=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Dashed Forward",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recDashBack=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Dashed Backward",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recAirDash=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Air Dashed",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recAtkNum=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Attacks Used",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recAtkHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("Attacks Connected",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recAtkHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Accuracy",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recDmgDealt=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    textDropShadow(global.recKillCount,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recDeathCount,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recTotalAP,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(round(global.recDistFoot),contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(round(global.recDistAir),contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recJumped,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(global.recDashForward,contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recDashBack,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recAirDash,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recAtkNum,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recAtkHit,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(string(round(tRecHitPercent)) +string("%"),contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(global.recDmgDealt,contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=2 //---------- Page 2 (Record) ----------
  {
    if global.recDmgTaken=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Taken",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recTimesHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Times Hit",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recMostPowerfulHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Most Powerful Hit",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recFallenOffLevel=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Fallen Off Level",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recObjectsBroken=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("Objects Broken",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recSaveNum=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("Saved Game",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recMenuOpenNum=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Opened Menu",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recAreaTrans=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Used Area Transition",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recLongestIdle=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Longest Idle Time",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recScanNum=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Enemies Scanned",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recPeopleTalkNum=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("People Talked To",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recInterEarnEnemy=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Internetz Earned From Enemies",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recInterLostDeath=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Internetz Lost From Death",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    //var tHeartDmg; tHeartDmg=global.recDmgTaken/4
    textDropShadow(string(global.recDmgTaken),contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recTimesHit,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recMostPowerfulHit,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(global.recFallenOffLevel,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(global.recObjectsBroken,contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recSaveNum,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(global.recMenuOpenNum,contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recAreaTrans,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recLongestIdle,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recScanNum,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recPeopleTalkNum,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(global.recInterEarnEnemy,contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(global.recInterLostDeath,contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=3 //---------- Page 3 (Record) ----------
  {
    if global.recInterEarnChest=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Internetz Earned From Chests",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recInterSpent=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Internetz Spent",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recInterEarnTotal=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Total Internetz Earned",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recItemBought=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Items Bought",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recItemUsed=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("Potions Used",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recQuestionBlockHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("[?] Blocks Hit",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recEnemyJumpedOn=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Enemies Jumped On",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recMaxEnemyJumpCombo=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Max Enemy Jump Combo",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recSignsRead=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Signs Read",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recBestCombo=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Best Hit Combo",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recBestChain=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("Best Kill Chain",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recBestStreak=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Best Kill Streak",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recMaxBubbles=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Max Bubbles on Screen",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    textDropShadow(global.recInterEarnChest,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recInterSpent,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recInterEarnTotal,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(global.recItemBought,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(global.recItemUsed,contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recQuestionBlockHit,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(global.recEnemyJumpedOn,contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recMaxEnemyJumpCombo,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recSignsRead,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recBestCombo,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recBestChain,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(global.recBestStreak,contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(global.recMaxBubbles,contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=4 //---------- Page 4 (Record) ----------
  {
    if global.recZeldaEnc=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Zelda Map Encounters",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recDrowned=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Drowned",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recMostTeamHits=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Most Team Hits",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recDashInterruptedRed=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Dashes Interrupted",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recOneShotted=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("One-Hit Killed",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recBikeCrashes=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("Unfortunate Bike Crashes",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recTimeReadingScanData=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Time Reading Scan Data",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recComboDamage=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Highest Combo Damage",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recDamageFromBirds=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage From Birds",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recPlantsBurned=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Plants Burned",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recHeardWilhelm=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("Heard Wilhelm",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recTimeInMenu=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Time Spent In Menu",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recCloudsBusted=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Clouds Busted",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    textDropShadow(global.recZeldaEnc,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recDrowned,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recMostTeamHits,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(global.recDashInterruptedRed,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(global.recOneShotted,contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recBikeCrashes,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(round(global.recTimeReadingScanData/30),contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recComboDamage,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recDamageFromBirds,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recPlantsBurned,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recHeardWilhelm,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(round(global.recTimeInMenu/30),contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(global.recCloudsBusted,contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=5 //---------- Page 5 (Record) ----------
  {
    if global.recParried=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Parried",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recShieldBroken=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Shield Broken",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recG6TotalExp=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Total Exp (Gate 6)",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recG6MostPowerfulHit=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Most Powerful Hit (Gate 6)",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recStdMarioCoins=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("Standard Mario Coins Found",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recSpottedSeeker=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("Times Spotted by Seeker",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recCopierBroken=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Copy Machines Destroyed",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recRetryBossRoom=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Used Boss Gallery Retry",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recTimeUnderWater=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Time Spent Under Water",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recBirdsScared=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Birds Scared Off",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recBirdsSeen=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("Birds Seen",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recHeadBonks=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Head Bonks",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recTimeSpentDucking=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Time Spent Ducking",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    textDropShadow(global.recParried,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recShieldBroken,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recG6TotalExp,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(global.recG6MostPowerfulHit,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(global.recStdMarioCoins,contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recSpottedSeeker,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(global.recCopierBroken,contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recRetryBossRoom,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recTimeUnderWater,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recBirdsScared,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recBirdsSeen,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(global.recHeadBonks,contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(round(global.recTimeSpentDucking/30),contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=6 //---------- Page 6 (Record) ----------
  {
    if global.recStrikeChainMisses=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    else
      textDropShadow("Strike Chain Misses",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    if global.recBumpKills=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    else
      textDropShadow("Mario Bump Kills",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    if global.recTypeNormal=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Normal",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    if global.recTypePierce=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Pierce",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    if global.recTypeElemental=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Elemental",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    if global.recTypeShot=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Shot",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    if global.recTypeExplosion=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Explosion",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    if global.recTypeSpecial=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt: Special",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    if global.recForcedGameOver=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    else
      textDropShadow("Used Force Game Over",contentMenuX+5,contentMenuY+111,textColorMain,textColorShadow,1)
    if global.recJerryDamage=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt with Jerry",contentMenuX+5,contentMenuY+123,textColorMain,textColorShadow,1)
    if global.recClaireDamage=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt with Claire",contentMenuX+5,contentMenuY+135,textColorMain,textColorShadow,1)
    if global.recJeremyDamage=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    else
      textDropShadow("Damage Dealt with Jeremy",contentMenuX+5,contentMenuY+147,textColorMain,textColorShadow,1)
    if global.recWarmasterLoses=0 and global.recWarmasterResets=0
      textDropShadow("??????",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    else
      textDropShadow("Warmaster Loses/Resets",contentMenuX+5,contentMenuY+159,textColorMain,textColorShadow,1)
    //----------
    textDropShadow(global.recStrikeChainMisses,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(global.recBumpKills,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypeNormal,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypePierce,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypeElemental,contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypeShot,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypeExplosion,contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(global.recTypeSpecial,contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
    textDropShadow(global.recForcedGameOver,contentMenuX+tEndSep,contentMenuY+111,textColorMain,textColorShadow,1)
    textDropShadow(global.recJerryDamage,contentMenuX+tEndSep,contentMenuY+123,textColorMain,textColorShadow,1)
    textDropShadow(global.recClaireDamage,contentMenuX+tEndSep,contentMenuY+135,textColorMain,textColorShadow,1)
    textDropShadow(global.recJeremyDamage,contentMenuX+tEndSep,contentMenuY+147,textColorMain,textColorShadow,1)
    textDropShadow(string(global.recWarmasterLoses) +string("/") +string(global.recWarmasterResets),contentMenuX+tEndSep,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else if mR_Page=7 //---------- Page 7 (Record) ----------
  {
    textDropShadow("Time Played This Session",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow("Map ID",contentMenuX+5,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow("Player X",contentMenuX+5,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow("Player Y",contentMenuX+5,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow("Current Time",contentMenuX+5,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow("Week Day",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow("Today's Date",contentMenuX+5,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow("A Random Number",contentMenuX+5,contentMenuY+99,textColorMain,textColorShadow,1)
    //----------
    var tWeekDay,tCHour,tDT,tMonth,tDaysSinceStart;
    if current_weekday=1 {tWeekDay="Sunday"}
    else if current_weekday=2 {tWeekDay="Monday"}
    else if current_weekday=3 {tWeekDay="Tuesday"}
    else if current_weekday=4 {tWeekDay="Wednesday"}
    else if current_weekday=5 {tWeekDay="Thursday"}
    else if current_weekday=6 {tWeekDay="Friday"}
    else if current_weekday=7 {tWeekDay="Saturday"}

    if current_hour>12 {tCHour=current_hour-12; tDT="PM"}
    else {tCHour=current_hour; tDT="AM"}

    if current_month=1 {tMonth="January"}
    else if current_month=2 {tMonth="February"}
    else if current_month=3 {tMonth="March"}
    else if current_month=4 {tMonth="April"}
    else if current_month=5 {tMonth="May"}
    else if current_month=6 {tMonth="June"}
    else if current_month=7 {tMonth="July"}
    else if current_month=8 {tMonth="August"}
    else if current_month=9 {tMonth="September"}
    else if current_month=10 {tMonth="October"}
    else if current_month=11 {tMonth="November"}
    else if current_month=12 {tMonth="December"}

    textDropShadow(global.sessionPlayTime,contentMenuX+tEndSep,contentMenuY+15,textColorMain,textColorShadow,1)
    textDropShadow(room,contentMenuX+tEndSep,contentMenuY+27,textColorMain,textColorShadow,1)
    textDropShadow(oPlayer1.x,contentMenuX+tEndSep,contentMenuY+39,textColorMain,textColorShadow,1)
    textDropShadow(oPlayer1.y,contentMenuX+tEndSep,contentMenuY+51,textColorMain,textColorShadow,1)
    textDropShadow(string(tCHour) +string(":") +string(current_minute) +string(":") +string(current_second) +string(" ") +string(tDT),contentMenuX+tEndSep,contentMenuY+63,textColorMain,textColorShadow,1)
    textDropShadow(tWeekDay,contentMenuX+tEndSep,contentMenuY+75,textColorMain,textColorShadow,1)
    textDropShadow(string(tMonth) +string("/") +string(current_day) +string("/") +string(current_year),contentMenuX+tEndSep,contentMenuY+87,textColorMain,textColorShadow,1)
    textDropShadow(irandom_range(100000000,999999999),contentMenuX+tEndSep,contentMenuY+99,textColorMain,textColorShadow,1)
  }
}
else
{
  draw_set_font(fnt_RecogList)
  menuRecognitions(mR_Page)
}
