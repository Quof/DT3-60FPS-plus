#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
fadeColor=c_white

textColorA=make_color_rgb(0,64,61)
displayAlpha=1
displayTime=210
bDisplayResults=global.bBossResultShow
bDisplayNewRecord=global.bossResultNewRecord
global.bBossResultShow=0
global.bossResultNewRecord=0

playerCheatedProg=0
playerCheatedTime=0

if global.bossResultTime=2222222
{
  playerCheatedProg=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0 {fadeAlpha-=0.02}
if global.gamePaused=false
{
  if bDisplayResults=1
  {
    displayTime-=1
    if displayTime<=20 {displayAlpha-=0.05}
    if displayTime<=0 {displayAlpha=0; bDisplayResults=0}
  }

  if playerCheatedProg=1
  {
    playerCheatedTime+=1
    if playerCheatedTime=30
    {
      msgCreate(0,0,"Jeremy","Guys, stop abusing game flags to cheat at this.",0,2,oMessagePerson,0)
      newMessage.fadingTime=80
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bDisplayResults=1
{
  bossResultsX=view_xview[0]+326
  bossResultsY=view_yview[0]+4
  draw_sprite_ext(sBossResultsCheck,0,bossResultsX,bossResultsY,1,1,0,c_white,displayAlpha)
  draw_set_alpha(displayAlpha)
  draw_set_color(textColorA)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_right)
  if global.bossResultTime=2222222
  {
    draw_text(bossResultsX+134,bossResultsY+23,"Cheater")
    draw_text(bossResultsX+134,bossResultsY+42,"9001")
    draw_text(bossResultsX+134,bossResultsY+61,"?????")
  }
  else
  {
    draw_text(bossResultsX+134,bossResultsY+23,global.bossResultTime-(global.bossResultHit*5))
    draw_text(bossResultsX+134,bossResultsY+42,global.bossResultHit)
    draw_text(bossResultsX+134,bossResultsY+61,global.bossResultTime)
  }
  if bDisplayNewRecord=1
  {
    draw_set_halign(fa_middle)
    textDropShadow("NEW RECORD!!",bossResultsX+75,bossResultsY+79,make_color_rgb(random(255),random(255),random(255)),textColorA,4)
  }

  if global.difficulty=1 and global.bNightmareMode=0
  {
    draw_set_halign(fa_middle)
    textDropShadow("ASSIST MODE ON",bossResultsX+75,bossResultsY+79,make_color_rgb(230,0,0),textColorA,4)
  }
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
