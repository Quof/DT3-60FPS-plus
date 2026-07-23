#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bBlue
event_inherited()
bActive=true
for(i=0;i<6;i+=1)
{
  resType[i]=1
}

//Enemy base statistics
eName="Skyfall Meteor - Red"
eLevel=40
maxLife=60
life=maxLife
pointWorth=25
atkPower=12

jeremyText="... ... ..."
chaoText="You can shoot the blue versions of these, Claire. So, I think that Jeremy was able to do his undo thing he mentioned in that cave... maybe? I can't tell yet, but things are not normal right now."
devText="If you're seeing this, then you triggered the not-so-secret true final chapter that I've been working on for some time. Welp, I don't want to spoil what's ahead, so strap in and enjoy. As some have said, this game's mission statement has been to surprise the player at every turn. More of my thoughts come later."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bBlue=1
{
  eName="Skyfall Meteor - Blue"
  sprite_index=sSkyfall_Meteor_Blue
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=2
  if oGame.time mod 2=0
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfSkyfall_MetFalloff; tEffect.newBlend=-1; tEffect.depth=26; tEffect.image_alpha=0.5
    tEffect.fadeSpd=0.025; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_angle=image_angle
    tEffect.direction=image_angle-180
  }

  speed=moveSpd
  if y<=-48 {instance_destroy()}
  enemyStepEvent()
}
else {speed=0}
