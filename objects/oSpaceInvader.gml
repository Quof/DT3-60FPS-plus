#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bActive=true

//Enemy base statistics
eName="Space Invader"
eLevel=35
maxLife=80
life=maxLife
pointWorth=15
atkPower=16
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[2]=3
resType[3]=3
dieEffect=0

moveTime=0
moveProg=12
moveNum=0
rowCheck=0
shotDelay=210

jeremyText="Oh hey, Space Invaders! I wasn't really expecting this one. These guys behave incredibly similar to their original counterpart. The thing you need to watch out for is if they get to the bottom. If that happens, they'll increase their fire speed significantly and target you. I'd recommend taking them out before that happens."
chaoText="I don't think these were put here by Hex. They just seem to trigger here, is all."
devText="The first build of this level sent to the testers had this room mistakenly cut. I found an issue a bit before its release and had the game skip the room. The bug was fixed before the build was sent out, but I had forgotten to reset the exit events."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    //Movement
    if rowCheck<10 {moveTime+=1}
    else {moveTime+=5}
    if moveTime>=moveProg
    {
      image_index+=1
      moveNum+=1
      if moveNum<11
      {
        if rowCheck mod 2=0 {x+=8}
        else {x-=8}
      }
      else
      {
        moveNum=0
        rowCheck+=1
        y+=8
      }
      moveTime=0

      if y>=284 {instance_destroy()}
    }

    //Weapon
    shotTime+=1
    if shotTime>=shotDelay
    {
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBulletRed)
      tNewAttack.sprite_index=sSpaceInvaderLaser
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6; tNewAttack.decayTime=-100
      if rowCheck<10 {tNewAttack.direction=270}
      else {tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}
      shotTime=0
    }
  }
  else if life<=0
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=2; tEffect.sprite_index=sSpaceInvaderEnd; tEffect.newBlend=-1; tEffect.decay=10
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    instance_destroy()
  }
  enemyStepEvent()
}
