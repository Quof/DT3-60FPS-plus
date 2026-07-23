#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
bFollow=false

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=15 or global.location=49
  sprite_index=sMarbleSpike
else if global.location=40 or global.location=105
  sprite_index=sVaultSpike
else if global.location=59
  sprite_index=sFacSpike
else if global.location=103
{
  sprite_index=sMarbleSpike
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}

if room=rBT_ZeroA or room=rBT_ZeroB or room=rBT_ZeroC or room=rBT_ZeroD
{
  sprite_index=sMarbleSpike
}

if variable_local_exists("idFollow")
  bFollow=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
followInstance()
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if image_blend=make_color_rgb(250,250,250)
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,36)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="Because... Why Not"; tAchievement.checkNum=36
  }
}
