#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.gamePaused=true
playSound(global.snd_InfoOn,0,1,1)
global.recScanNum+=1
oPlayer1.image_speed=0
windowClosed=false
bShowInfo=true

textColor1=make_color_rgb(240,240,240)
textColor2=make_color_rgb(32,48,40)

statsWindowX=view_xview[0]+32
statsWindowY=view_yview[0]+32

circleRad[0]=36
circleRad[1]=24
circleRad[2]=12
for(i=0;i<3;i+=1)
  circleAlpha[i]=0

scanProgress=0
scanStep=0
for(i=0;i<4;i+=1)
  scanData[i]=round(random(899999)+100000)

scanLineTime=25
scanLineX=0
staticFrm=0

messageLines=instance_create(0,0,oScanMMessage)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(enemyID)
{
  if bShowInfo=true
  {
    global.recTimeReadingScanData+=1
    scanLineTime-=1
    if scanLineTime=0
    {
      newLine=instance_create(statsWindowX+11,statsWindowY+104,oScanMLine)
      newLine.bMaster=1
      scanLineTime=360
    }

    if (oKeyCodes.kCodePressed[5]=1 or keyboard_check_pressed(vk_enter)) and windowClosed=false
    {
      io_clear()
      playSound(global.snd_InfoOff,0,1,1)
      windowClosed=true
    }

    if oKeyCodes.kCodePressed[6]=1 and windowClosed=false
    {
      io_clear()
      playSound(global.snd_InfoOff,0,1,1)
      if global.charScan[0]=1 {scanText=enemyID.jeremyText}
      else
      {
        var tNoScan;
        tNoScan="01010101 01001110 01000001 01010110 01000001 01001001 01001100 01000001 01000010 01001100 01000101"
        scanText=tNoScan
      }
    }
    else if oKeyCodes.kCodePressed[7]=1 and windowClosed=false
    {
      io_clear()
      playSound(global.snd_InfoOff,0,1,1)
      scanText=enemyID.chaoText
    }
    else if oKeyCodes.kCodePressed[8]=1 and windowClosed=false
    {
      io_clear()
      if enemyID.devText!="N/A"
      {
        playSound(global.snd_InfoOff,0,1,1)
        scanText=enemyID.devText
      }
      else {playSound(global.snd_Error,0,1,1)}
    }
  }
}
else {windowClosed=true}

if windowClosed=true
{
  global.gamePaused=false
  with oScanMMessage {instance_destroy()}
  with oScanMLine {instance_destroy()}
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(enemyID)
{
  statsWindowX=view_xview[0]+32
  statsWindowY=view_yview[0]+32
  //---------- Draw Back Color ----------
  var backColor;
  backColor=make_color_rgb(0,255,0)
  draw_set_color(backColor)
  draw_set_alpha(0.2)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)

  //---------- Display Target Effect ----------
  for(i=0;i<3;i+=1)
  {
    circleAlpha[i]+=0.04
    draw_set_alpha(circleAlpha[i])
    draw_circle(effectX,effectY,circleRad[i],true)
    circleRad[i]-=1
    if circleRad[i]<=0
    {
      circleRad[i]=36
      circleAlpha[i]=0
    }
  }

  //---------- Display Scan Menu ----------
  draw_sprite(sScanMenuBase,0,statsWindowX,statsWindowY)
  if enemyID.devText="N/A"
  {
    draw_set_color(c_black)
    draw_set_alpha(0.25)
    draw_rectangle(statsWindowX+206,statsWindowY+84,statsWindowX+330,statsWindowY+96,0)
  }

  //---------- Display Statistical Data ----------
  draw_set_font(fnt_Scan)
  draw_set_halign(fa_right)
  if scanProgress<6
  {
    if scanStep>=10
    {
      scanProgress+=1
      scanStep=0
    }
    else
      scanStep+=1

    for(i=0;i<6;i+=1)
      scanData[i]=round(random(899999)+100000)
  }
  draw_set_alpha(1)
  textDropShadow(enemyID.eName,statsWindowX+252,statsWindowY+18,textColor1,textColor2,4)
  if scanProgress>=1 //Level
  {
    if enemyID.bIsBoss=1
      textDropShadow("?????",statsWindowX+196,statsWindowY+35,textColor1,textColor2,4)
    else
      textDropShadow(enemyID.eLevel,statsWindowX+196,statsWindowY+35,textColor1,textColor2,4)
  }
  else
    textDropShadow(scanData[0],statsWindowX+196,statsWindowY+35,textColor1,textColor2,4)

  if scanProgress>=2 //Life
  {
    if enemyID.bIsBoss=1
      textDropShadow("?????",statsWindowX+196,statsWindowY+49,textColor1,textColor2,4)
    else
      textDropShadow(string(enemyID.life) +string(" / ") +string(enemyID.maxLife),statsWindowX+196,statsWindowY+49,textColor1,textColor2,4)
  }
  else
  {
    if enemyID.bIsBoss=1
      textDropShadow("?????",statsWindowX+196,statsWindowY+49,textColor1,textColor2,4)
    else
      textDropShadow(scanData[1],statsWindowX+196,statsWindowY+49,textColor1,textColor2,4)
  }

  if scanProgress>=3 //Power
  {
    if enemyID.bIsBoss=1
      textDropShadow("?????",statsWindowX+196,statsWindowY+63,textColor1,textColor2,4)
    else
    {
      if global.difficulty=1 {textDropShadow(ceil(enemyID.atkPower/2),statsWindowX+196,statsWindowY+63,textColor1,textColor2,4)}
      else if global.difficulty=2 {textDropShadow(enemyID.atkPower,statsWindowX+196,statsWindowY+63,textColor1,textColor2,4)}
    }
  }
  else
  {
    textDropShadow(scanData[2],statsWindowX+196,statsWindowY+63,textColor1,textColor2,4)
  }

  if scanProgress>=4 //AP
  {
    if enemyID.bIsBoss=1
      textDropShadow("?????",statsWindowX+196,statsWindowY+77,textColor1,textColor2,4)
    else
      textDropShadow(enemyID.pointWorth,statsWindowX+196,statsWindowY+77,textColor1,textColor2,4)
  }
  else
  {
    textDropShadow(scanData[3],statsWindowX+196,statsWindowY+77,textColor1,textColor2,4)
  }

  //---------- Display Key Commands ----------
  draw_set_halign(fa_center)
  textDropShadow(global.ctrlJump,statsWindowX+218,statsWindowY+39,textColor1,textColor2,4)
  textDropShadow(global.ctrlActA,statsWindowX+218,statsWindowY+53,textColor1,textColor2,4)
  textDropShadow(global.ctrlActB,statsWindowX+218,statsWindowY+67,textColor1,textColor2,4)
  textDropShadow(global.ctrlActC,statsWindowX+218,statsWindowY+81,textColor1,textColor2,4)

  draw_set_color(c_green)
  draw_set_alpha(0.25)
  if scanText=enemyID.jeremyText
    draw_rectangle(statsWindowX+206,statsWindowY+56,statsWindowX+330,statsWindowY+68,0)
  else if scanText=enemyID.chaoText
    draw_rectangle(statsWindowX+206,statsWindowY+70,statsWindowX+330,statsWindowY+82,0)
  else if scanText=enemyID.devText
    draw_rectangle(statsWindowX+206,statsWindowY+84,statsWindowX+330,statsWindowY+96,0)

  //---------- Display Weaknesses ----------
  draw_set_alpha(1)
  for(i=0;i<6;i+=1)
  {
    draw_sprite(sScanMenuDmgTypes,enemyID.resType[i]-1,statsWindowX+116+(i*22),statsWindowY+262)
  }
  textDropShadow(enemyID.stunResist,statsWindowX+22,statsWindowY+245,textColor1,textColor2,4)

  //---------- Display Extra Info ----------
  draw_set_halign(fa_left)
  textDropShadowExt(enemyID.extraInfo,statsWindowX+13,statsWindowY+259,textColor1,textColor2,4,14,218)

  //---------- Display Internetz Drop ----------
  if moneyType>0 {draw_sprite(moneyType,0,statsWindowX+266,statsWindowY+19)}

  //---------- Display Collision damage ----------
  if enemyID.bCanDealDamage=1 {draw_sprite(sScanMenuHitDetect,0,statsWindowX+297,statsWindowY+27)}

  //---------- Display Affiliation ----------
  if enemyID.affiliation=8
  {
    if global.gameProgress>=2170 {draw_sprite(sAffiliationIcons,enemyID.affiliation,statsWindowX+300,statsWindowY+260)}
    else //Do not display the H icon until Chapter 10
    {
      staticFrm+=1
      draw_sprite(sAffIconStatic,staticFrm,statsWindowX+300,statsWindowY+260)
    }
  }
  else if enemyID.affiliation=10
  {
    draw_sprite_ext(sLittleBirdA_Idle,image_index,statsWindowX+308,statsWindowY+280,5.1,5.1,0,c_white,1)
  }
  else {draw_sprite(sAffiliationIcons,enemyID.affiliation,statsWindowX+300,statsWindowY+260)}

  //---------- Display Other Info ----------
  draw_set_font(fnt_CompText)
  draw_set_halign(fa_left)
  draw_set_color(c_teal)
  draw_set_alpha(0.4)
  draw_rectangle(statsWindowX+344,statsWindowY+32,statsWindowX+418,statsWindowY+140,0)
  draw_set_alpha(0.2)
  draw_rectangle(statsWindowX+344,statsWindowY+32,statsWindowX+418,statsWindowY+140,1)
  draw_set_color(c_lime)
  draw_set_alpha(0.5)
  var tThreadLvl;
  tThreadLvl=round((oPlayer1.life/oPlayer1.maxLife)*100)
  draw_text(statsWindowX+346,statsWindowY+34,string("> THREAT LEVEL#")
  +string("  > ") +string(100-tThreadLvl) +string("%#")
  +string("> BASE DROP#")
  +string("  > ")   +string(enemyID.baseItemChance) +string("%#")
  +string("> DROP BIAS#")
  +string("  > ")   +string(enemyID.baseDropIndex) +string("% - ") +string(enemyID.pickupDropMod) +string("%#")
  +string("> POSITION#")
  +string("  > ")   +string(room) +string(" . ") +string(enemyID.x) +string(" . ") +string(enemyID.y) +string("##")
  +string("> PROGRESSION#")
  +string("  > ")   +string(global.gameProgress) +string("#")
  +string("> CURRENT OUTPUT#")
  +string("  > ")   +string(fps) +string("#")
  +string("> AUDIO INDEX#")
  +string("  > ")   +string(global.currentMusic))
}
