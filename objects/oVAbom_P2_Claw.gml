#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0; image_yscale=0
bActive=true

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=20
maxLife=1000000
life=maxLife
atkPower=9
affiliation=9
bIsBoss=true
bNoBonus=true

fireTime=0
if room=rVault_5 {fireDelay=100}
else if room=rVault_6 {fireDelay=180}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life<100000 {life=1000000}
  if room=rVault_5
  {
    if image_xscale<1.5 {image_xscale+=0.04; image_yscale+=0.04}
    image_angle=point_direction(x+lengthdir_x(138,22),y+lengthdir_y(138,22),oPlayer1.x,oPlayer1.y-26)

    if oVAbom_P2_Main.sequence=5
    {
      if oVAbom_P2_Main.seqTime>=60
      {
        if oPlayer1.x>=2056
        {
          if oGame.time mod 5=0
          {
            var tNewAttack,tDir;
            tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
            tNewAtk=instance_create(x,y,oPassBullet)
            tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=4; tNewAtk.image_speed=0.33
            tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.25; tNewAtk.image_yscale=1.25; tNewAtk.direction=tDir
          }
        }
      }
    }
  }
  else if room=rVault_6
  {
    if image_xscale<1.2 {image_xscale+=0.02; image_yscale+=0.02}
    image_angle=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
  }

  fireTime+=1
  if fireTime>=fireDelay
  {
    if room=rVault_5
    {
      var tNewAttack,tDir;
      tDir=image_angle-20
      for(i=0;i<3;i+=1)
      {
        tNewAtk=instance_create(x+lengthdir_x(138,22+image_angle),y+lengthdir_y(138,22+image_angle),oPassBullet)
        tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=3; tNewAtk.image_speed=0.33
        tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.5; tNewAtk.image_yscale=1.5; tNewAtk.direction=tDir
        tDir+=20
      }
    }
    else if room=rVault_6
    {
      var tNewAttack;
      tNewAtk=instance_create(x+lengthdir_x(110,22+image_angle),y+lengthdir_y(110,22+image_angle),oPassBullet)
      tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=3; tNewAtk.image_speed=0.33
      tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.2; tNewAtk.image_yscale=1.2; tNewAtk.direction=image_angle
    }
    fireTime=0
  }

  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tDmgA,tDmgB;
tDmgA=life
event_inherited()
tDmgB=life
if room=rVault_5 {oVAbom_P2_Main.damageTaken+=tDmgA-tDmgB}
else if room=rVault_6 {oVAbom_P3_Main.damageTaken+=tDmgA-tDmgB}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fireTime>=9 {fireTime-=9}
