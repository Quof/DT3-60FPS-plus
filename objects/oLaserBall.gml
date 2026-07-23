#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Laser Ball"
eLevel=20
maxLife=390
life=maxLife
pointWorth=26
atkPower=5
resType[2]=4
resType[3]=2
resType[5]=2
stunResist=2
baseItemChance=65
baseDropIndex=95
moneyWorth=5
initDir=0

runAcc=1
turnTime=0
shotTime=80
shotDelay=100

jeremyText="Well look who's back to cause you more trouble. They're pretty resilient like before and crippling isn't an option anymore. Try out your ice attack, that should wipe it out pretty quick."
chaoText="I'm kinda nervous about something, but this place has me thinking everything is going to be okay. It's so inviting and not at all what I thought this place would look like considering it's so close to the Vault."
devText="Originally the Farreaches was going to be a dark and bleak area, due to it being so close to the Vault in the game world. Since that type of level would come soon after the Farreaches, and I didn't want to have that type of area back to back, I went with a very different approach instead. This, and the characters here are more upbeat; it felt wrong to have them living in a wasteland."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if initDir=0
    {
      if x>oPlayer1.x
        image_xscale=-1
      initDir=1
    }

    if x>oPlayer1.x and image_xscale=1
      turnTime+=1
    else if x<oPlayer1.x and image_xscale=-1
      turnTime+=1
    if turnTime>=30
    {
      image_xscale*=-1
      turnTime=0
    }
    x+=runAcc*image_xscale

    shotTime+=1
    if shotTime=shotDelay
    {
      image_speed=0.5
    }
    if shotTime>=shotDelay+20
    {
      image_speed=0; image_index=0
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=player_sprite_center()
      tNewAttack.image_angle=player_sprite_center()

      shotTime=0
    }
  }
  enemyStepEvent()
}
