#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=1

redOverlay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0
{
  sceneDelay+=1
  if sceneDelay=1 {oIdentifier.bChaoActive=0}
  else if sceneDelay>=60
  {
    redOverlay+=0.005
    fadeAlpha-=0.02
    if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
  }
}
else if sceneProgress=1
{
  sceneDelay+=1
  if sceneDelay=40
  {
    createScreenText(240,32,-1,fnt_EnemyName,fa_middle,"After the creature merged with the Warship,#it turned its sights on the world.",3,c_red,1,0)
  }
  else if sceneDelay=160
  {
    createScreenText(240,80,-1,fnt_EnemyName,fa_middle,"Already invincible and driven to destroy,#it threw the world into chaos.",3,c_red,1,0)
  }
  else if sceneDelay=280
  {
    createScreenText(240,128,-1,fnt_EnemyName,fa_middle,"With it backed by Hex's power and rage,#it devastated the lives of those in the program.",3,c_red,1,0)
  }
  else if sceneDelay=400
  {
    createScreenText(240,176,-1,fnt_EnemyName,fa_middle,"With stability quickly collapsing,#the world functions decayed and became corrupt.",3,c_red,1,0)
  }
  else if sceneDelay=520
  {
    createScreenText(240,260,-1,fnt_EnemyName,fa_middle,"The world had ended...",3,c_red,1,0)
  }
  else if sceneDelay=640
  {
    createScreenText(240,304,-1,fnt_EnemyName,fa_middle,"But it could have been prevented.",3,c_red,1,0)
  }
  else if sceneDelay>=761 and sceneDelay<=810
  {
    fadeAlpha+=0.02
  }
  else if sceneDelay=860 //Show credits
  {
    instance_create(0,0,oEvCredits)
  }

  if sceneDelay>=861 and sceneDelay<=880
  {
    with oScreenText
    {
      image_alpha-=0.05
    }
  }
}
else if sceneProgress=2
{
  sceneDelay+=1
  if sceneDelay=40
  {
    createScreenText(240,176,-1,fnt_EnemyName,fa_middle,"Jeremy was all that was left in the darkness...",3,c_red,1,0)
  }
  else if sceneDelay>=131 and sceneDelay<=230
  {
    with oScreenText
    {
      image_alpha-=0.01
    }
  }
  else if sceneDelay=270
  {
    musVolC=global.optMusic*100
    musFileP=findMusic(1003)
  }
  else if sceneDelay>=271
  {
    if musVolC>=7500 {musVolC-=50}
    else {musVolC-=400}
    SS_SetSoundVol(musFileP,musVolC)
    if musVolC<=0
    {
      SS_SetSoundFreq(global.msc_IFC,22050)
      stopAllMusic()
      room_goto(rTitle)
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if redOverlay>0
{
  draw_set_alpha(redOverlay)
  draw_set_color(c_red)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
