#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

sprite_index=sInvisibleSolidMask
image_alpha=0.5
if room=rSamus5_Lv4_FinalBoss {image_alpha=1}

//Enemy base statistics
atkPower=1
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false
bCauseKnockback=false

xx=0
yDraw=-1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("scaling")
{
  yDraw=scaling
}
if image_blend=c_purple {image_alpha=0.75}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress<=2850 {redDmgHit(0)}
else
{
  if image_blend=c_purple
  {
    if global.currentMusic=503 //Achievement (Norfair only)
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,33)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Lavaception"; tAchievement.checkNum=33
      }
    }
    redDmgHit(0)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xx+=1
if xx=16 {xx=0}
for(i=0;i<image_xscale;i+=1)
{
  draw_sprite_part_ext(sMetLava,0,xx,0,16,35,x+(i*16),y,1,1,image_blend,image_alpha)
}
if yDraw>0
{
  draw_sprite_part_ext(sMetLava,0,0,34,1,1,x,y+35,image_xscale*16,yDraw,image_blend,image_alpha)
}
