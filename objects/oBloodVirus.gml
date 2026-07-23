#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.05+random(0.05)
visible=0

//Enemy base statistics
eName="Blood Virus"
eLevel=32
maxLife=520
life=maxLife
pointWorth=60
atkPower=9
resType[0]=2
resType[1]=4
resType[2]=2
resType[3]=2
resType[4]=2
stunResist=7
baseItemChance=60
baseDropIndex=90
pickupDropMod=5
moneyWorth=5
detectDistX=196
detectDistY=164
dieEffect=0
startUpTime=0

currHspd=0; currVspd=0
shotTime=45
shotDelay=80

pulsate=0
wobble=0
for(i=0;i<8;i+=1)
{
  handDir[i]=random(360)
  handFrm[i]=0
}
wormDrop=0
abilDrain=0
drainRad=70
bDraining=0

deathAnim=0

jeremyText="Oh wow, these are super bad news. Do you see that red circle around them? Do not touch that! If you do, it'll start syphoning the energy from the currently active ability as well as disable charging up attacks while in its range. It uses that syphoned energy to recover HP. It may be unavoidable at times, so manage your abilities accordingly."
chaoText="Oh gross, it's those weird things from the Chaser Virus back on that island. It looks like it uses the movement behavior of the Injector Virus and it can periodically shoot bullets at you."
devText="Before changing Arrow & Missile ammo, I was hesitant to have enemies that could drain ammo/energy. When all ammo types were changed to what it is now, that hesitation went away and here we are. I wanted to bring DT1's Spirit Drain back, but I didn't want debuffs as they were in DT1."

alarm[0]=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  pulsate+=0.5
  wobble+=sin(pulsate)/100

  if bActive=0 {makeEnemyActive(1)}
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      image_xscale=0.5+(lifePercent/2)
      image_yscale=0.5+(lifePercent/2)

      startUpTime+=1
      if startUpTime=1 //Appear
      {
        visible=1
        if !instance_exists(oQuickStatic)
        {
          var tStatic;
          tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=4; tStatic.image_alpha=0.5
        }
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sAtkTypeShield; tEffect.followID=-1; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75; tEffect.image_speed=0.75
      }
      if startUpTime>=15
      {
        //Track player
        var myDist,targetSpd;
        targetSpd=5
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        myDist=round(myDist)

        if myDist<=40 {targetSpd=4}
        else if myDist>=41 and myDist<=88 {targetSpd=5}
        else if myDist>=89 and myDist<=144 {targetSpd=6}
        else if myDist>=145 and myDist<=216 {targetSpd=7}
        else if myDist>=217 {targetSpd=8}

        maxSpeed=targetSpd
        if x>oPlayer1.x
        {
          if currHspd>-maxSpeed {currHspd-=0.25}
          else {currHspd+=0.25}
        }
        else if x<oPlayer1.x
        {
          if currHspd<maxSpeed {currHspd+=0.25}
          else {currHspd-=0.25}
        }
        if y>oPlayer1.y-26
        {
          if currVspd>-maxSpeed {currVspd-=0.25}
          else {currVspd+=0.25}
        }
        else if y<oPlayer1.y-26
        {
          if currVspd<maxSpeed {currVspd+=0.25}
          else {currVspd-=0.25}
        }
        hspeed=currHspd; vspeed=currVspd
      }

      shotTime+=1
      if shotTime=shotDelay
      {
        for(i=0;i<16;i+=1)
        {
          var tEffect;
          tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sBV_WormDrop; tEffect.newBlend=-1; tEffect.image_speed=0.15+random(0.15)
          tEffect.fadeSpd=0.06; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_xscale=1+random(1); tEffect.image_yscale=1+random(1)
          tEffect.xSpd=random_range(-5,5); tEffect.ySpd=-5; tEffect.grav=0.3
        }
      }
      if shotTime>=shotDelay+20
      {
        var tShotA,tShotB;
        tShotA=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
        tShotB=intercept_course_player(x,y,7)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5.5
        tNewAttack.decayTime=-100; tNewAttack.direction=tShotA; tNewAttack.image_xscale=0.5
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7
        tNewAttack.decayTime=-100; tNewAttack.direction=tShotB; tNewAttack.image_xscale=0.5
        shotTime=0
      }

      //Worm drop effect
      wormDrop+=1
      if wormDrop mod 30=0
      {
        var tEffect;
        tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sBV_WormDrop; tEffect.newBlend=-1; tEffect.image_speed=0.15+random(0.15)
        tEffect.speed=2; tEffect.direction=270
        tEffect.fadeSpd=0.07; tEffect.AccelX=random_range(-0.5,0.5); tEffect.AccelY=0.1; tEffect.followID=-1; tEffect.rotation=0
      }

      //Syphon energy
      drainRad=70+((maxLife-life)/12)
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<=drainRad
      {
        if oGame.time mod 9=0 {playSound(global.snd_Infect,0,0.9,30000)}
        abilDrain+=1
        bDraining=1
        oPlayer1.attackCharge=0
        oPlayer1.specAttackChargeA=0
        oPlayer1.specAttackChargeB=0
        if abilDrain mod 3=0
        {
          if life<maxLife-10 {life+=10}
          if global.activeCharacter=0
          {
            if global.activeAbility[0]=1
            {
              if global.hudLink_Arrows[0]>0 {global.hudLink_Arrows[0]-=1}
              if global.hudLink_BombEn[0]>5 {global.hudLink_BombEn[0]-=6}
              if oPlayer1.arrowRecharge>0 {oPlayer1.arrowRecharge=0}
              oPlayer1.arrowDelay+=1
            }
            else if global.activeAbility[0]=2
            {
              if global.hudMega_BusterEn[0]>0 {global.hudMega_BusterEn[0]-=1}
              if global.hudMega_ShotIceEn[0]>0 {global.hudMega_ShotIceEn[0]-=1}
              if global.hudMega_GravityEn[0]>0 {global.hudMega_GravityEn[0]-=1}
            }
          }
          else if global.activeCharacter=1
          {
            if global.activeAbility[1]=1
            {
              if global.hudBelmont_WeaponEn[0]>2 {global.hudBelmont_WeaponEn[0]-=3}
            }
            else if global.activeAbility[1]=2
            {
              if global.hudSamus_CannonEn[0]<global.hudSamus_CannonEn[1]-25 {global.hudSamus_CannonEn[0]+=25}
              if global.hudSamus_Missiles[0]>0 {global.hudSamus_Missiles[0]-=1}
              if oPlayer1.missileRecharge>0 {oPlayer1.missileRecharge=0}
              oPlayer1.missileDelay+=1
            }
          }
        }
      }
      else {bDraining=0}
    }
    else {hspeed=0; vspeed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      hspeed=0; vspeed=0
      baseColor=c_red; image_blend=c_red
    }

    if deathAnim mod 4=0
    {
      tEffect=instance_create(x+random_range(-14,14),y+random_range(-14,14),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.15)
draw_set_color(c_red)
draw_circle(x,y,drainRad,0)

if bDraining=1
{
  var tPDir,tPDist;
  tPDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
  tPDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
  for(i=0;i<4;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index+(i*0.5),x+lengthdir_x(tPDist*(0.2*(i+1)),tPDir),y+lengthdir_y(tPDist*(0.2*(i+1)),tPDir),0.4,0.4,0,c_red,0.6)
  }
}

draw_sprite_ext(sprite_index,image_index,x,y,(image_yscale+wobble),(image_yscale+wobble),image_angle,image_blend,0.25)
for(i=0;i<8;i+=1)
{
  handFrm[i]+=0.1+random(0.1)
  draw_sprite_ext(sBV_ExtendHands,handFrm[i],x+lengthdir_x(12,handDir[i]),y+lengthdir_y(12,handDir[i]),(image_yscale+wobble),(image_yscale+wobble),handDir[i],image_blend,image_alpha)
}
draw_sprite_ext(sprite_index,image_index,x,y,(image_yscale+wobble),(image_yscale+wobble),image_angle,image_blend,image_alpha)
