//This script swaps the characters

idleTime=0
if global.stJGame_C[0]>1500 {global.stJGame_C[0]=1000} //Remove super mode in Gate 6
if attackState=ACT_BLOCK {attackState=0}
if global.partySplit=1 //party split
{
  var tPrevFace;
  tPrevFace=image_xscale
  if oPlayerIdle.image_xscale=1 {facing=RIGHT}
  else {facing=LEFT}
  oPlayerIdle.sprite_index=sprite_index
  if oPlayerIdle.sprite_index!=sJerryJump and global.activeCharacter=0 {oPlayerIdle.sprite_index=sJerryIdle}
  if oPlayerIdle.sprite_index!=sClaireJump and global.activeCharacter=1 {oPlayerIdle.sprite_index=sClaireIdle}
  oPlayerIdle.image_xscale=tPrevFace
  oSmallJumper.bouncePlayerTime=0; oLargeJumper.bouncePlayerTime=0
  stopPlayer()
  swapCheck=1
  mobilityDisable=10
  if global.bossTrack=0
  {
    oPlayerIdle.pauseTime=round(point_distance(x,y,oPlayerIdle.x,oPlayerIdle.y)/33)+1
    global.gamePaused=true
  }
}
else
{
  var tEffect;
  tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
  tEffect.sprite_index=sDustCloud; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
charSwapRecover=20

if bShowCharSwitchText=1 and global.charScan[1]=1
{
  var tNewSwap,tRanMes;
  tNewSwap=instance_create(0,0,oSwapIcon)
}

if global.activeCharacter=0 //Switch to Claire
{
  charSwitcher(1)
  if bShowCharSwitchText=1 and global.charScan[1]=1
  {
    tRanMes=irandom_range(0,7)
    if tRanMes=0 {tNewSwap.stringToShow="CLAIRE'S TURN TO KICK ASS!!"}
    else if tRanMes=1 {tNewSwap.stringToShow="ANGEL ON A WARPATH!!"}
    else if tRanMes=2 {tNewSwap.stringToShow="WINGIN' IT!!"}
    else if tRanMes=3 {tNewSwap.stringToShow="ALL'S CLAIRE IN LOVE AND WAR!!"}
    else if tRanMes=4 {tNewSwap.stringToShow="EVE??"}
    else if tRanMes=5 {tNewSwap.stringToShow="CLAIRELY THE BETTER CHOICE!!"}
    else if tRanMes=6 {tNewSwap.stringToShow="CLAIRE A PATH, EVERYONE!!"}
    else if tRanMes=7 {tNewSwap.stringToShow="DESCENT OF THE TWO-WINGED ANGEL!!"}
  }
}
else //Switch to Jerry
{
  charSwitcher(0)
  if bShowCharSwitchText=1 and global.charScan[1]=1
  {
    tRanMes=irandom_range(0,6)
    if tRanMes=0 {tNewSwap.stringToShow="TIME FOR SOME JERRY ACTION!!"}
    else if tRanMes=1 {tNewSwap.stringToShow="PUT YA GUNS ON!!"}
    else if tRanMes=2 {tNewSwap.stringToShow="JERRY'S ALL OUTTA BUBBLE GUM!!"}
    else if tRanMes=3 {tNewSwap.stringToShow="JERRY, LET'S GET HAIRY!!"}
    else if tRanMes=4 {tNewSwap.stringToShow="ALLEN??"}
    else if tRanMes=5 {tNewSwap.stringToShow="MEGA MACHISMO!!"}
    else if tRanMes=6 {tNewSwap.stringToShow="JERRY, JERRY, QUITE CONTRARY!!"}
  }
}
if global.optAtkTShow=1
{
  with oAbilSwapNotice {instance_destroy()}
  instance_create(0,0,oAbilSwapNotice)
}
bShowCharSwitchText=0
