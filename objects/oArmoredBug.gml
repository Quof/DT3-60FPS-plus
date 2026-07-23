#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Armored Bug"
eLevel=25
maxLife=500
life=maxLife
pointWorth=38
atkPower=8
resType[0]=2
resType[1]=1
resType[4]=2
stunResist=9
baseItemChance=70
baseDropIndex=90
moneyWorth=10
runAcc=2
inactiveDist*=1.5

eProg=0
chargeProg=0
chargeTime=0
chargeDelay=100
bArmorBreak=0

jeremyText="These work sorta like the Stealth Bug, but they don't cloak and their movement behavior is different. They can also charge at you, but they do it twice. So... I guess they're not quite that similar. The biggest difference though, is their armor. It blocks most things and their HP is fairly high for a flyer."
chaoText="This is from Super Valis 4 like that Tentacle Spider thing that's gross. It looks like Jeremy didn't find their crippling weakness. If you can hit them with EXPLOSIVE type damage, you'll make their armor almost useless. It knocks their resistances down a level as well as halve the Stun Resist."
devText="There's plans, at the time of this writing (typing?) to have more enemies like this guy with armor plating or any kind of armor that can be blown off in some fashion."
extraInfo="Is kind of annoying."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      chargeTime+=1
      if chargeProg=0 //Normal
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<96
        {
          direction=player_sprite_center()-180
          speed=runAcc/1.2
        }
        else
        {
          direction=player_sprite_center()
          speed=runAcc
        }

        if chargeTime>=chargeDelay
        {
          speed=0
          image_speed=0.5
          chargeTime=0
          chargeProg+=1
        }
      }
      else if chargeProg=1 //Wait time
      {
        if chargeTime=15
        {
          chargeTime=0
          chargeProg+=1
        }
      }
      else if chargeProg=2 //Charge 2x
      {
        if chargeTime>=1 and chargeTime<=25 //Charge 1
        {
          speed=runAcc*6
          if chargeTime=1 {direction=player_sprite_center()}
          else if chargeTime=25 {speed=0}
        }
        else if chargeTime>=26 and chargeTime<=40 //Look toward player
        {
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}
        }
        else if chargeTime>=41 and chargeTime<=65 //Charge 1
        {
          speed=runAcc*6
          if chargeTime=41 {direction=player_sprite_center()}
        }
        else if chargeTime>=66 //End
        {
          image_speed=0.2
          chargeTime=0
          chargeProg=0
        }
      }
    }
    else {speed=0}
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bArmorBreak=0 and other.damageType="EXPLOSION"
{
  for(i=0;i<6;i+=1)
  {
    resType[i]+=1
  }
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor

  var tEffect;
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
    tEffect.sprite_index=sMMGlassBreak; tEffect.followID=-1; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
    tEffect.newBlend=1; tEffect.decay=9+irandom(6); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_angle=random(360); tEffect.image_blend=make_color_rgb(200,40,0)
  }
  bArmorBreak=1
}
