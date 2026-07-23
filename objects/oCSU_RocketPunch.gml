#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
atkTime=0
currHspd=0
slamNum=0
maxSpeedX=5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkProg=0 //Fist charge up
  {
    if atkTime mod 2=0
    {
      var tEffect;
      for(i=0;i<2;i+=1)
      {
        tEffect=instance_create(x,y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sSamusMissileEffect; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=random(1.5)+1; tEffect.image_speed=0.33
        tEffect.fadeSpd=0.075; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        if i=0 {tEffect.direction=random_range(140,150)}
        else {tEffect.direction=random_range(220,230)}
      }
    }
    if atkTime>=30
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=1 //First fist strike
  {
    x+=10*image_xscale
    if atkTime mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sSamusMissileEffect; tEffect.newBlend=-1; tEffect.depth=26
      tEffect.speed=random(0.5)+0.5; tEffect.image_speed=0.33
      tEffect.fadeSpd=0.075; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      if image_xscale=1 {direction=180}
      else {direction=0}
    }
    if atkTime>=24
    {
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2 //Rise
  {
    y-=4
    if atkTime>=32
    {
      image_xscale=1
      image_angle=270
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=3 //Find player x
  {
    if x>oPlayer1.x
    {
      if currHspd>-maxSpeedX {currHspd-=0.3}
      else {currHspd+=0.3}
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeedX {currHspd+=0.3}
      else {currHspd-=0.3}
    }
    hspeed=currHspd

    if point_distance(x,0,oPlayer1.x,0)<maxSpeedX and y<oPlayer1.y
    {
      hspeed=0; currHspd=0
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=4 //Slam down
  {
    if atkTime=1
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      currY=y
    }
    else if atkTime>=11 and atkTime<=30
    {
      y+=8
      if atkTime mod 2=0
      {
        newAttack=instance_create(x,y,oDamageExplosion)
        newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion; newAttack.decayTime=-100
        newAttack.image_xscale=0.75; newAttack.image_yscale=0.75
      }
      if y>oPlayer1.y-12 {atkTime=30}
    }
    else if atkTime>=40
    {
      y-=4
      if y<=currY
      {
        atkTime=0
        slamNum+=1
        if slamNum=3 {atkProg=5}
        else {atkProg=3}
      }
    }
  }
  else if atkProg=5 //Return to owner
  {
    speed=4
    if instance_exists(ownerID)
    {
      direction=point_direction(x,y,ownerID.x,ownerID.y-18)
      image_angle=direction
      if point_distance(x,y,ownerID.x,ownerID.y-18)<6
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        ownerID.dropShield=1
        instance_destroy()
      }
    }
  }

  if !instance_exists(ownerID) {instance_destroy()}
}
else {speed=0; hspeed=0}
