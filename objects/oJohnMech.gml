#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
progress=0
progTime=0
direction=-12
keyPadAlpha=0.4
shotTime=0
shotMod=30
rapidFire=0
gunBlend=c_white
ySpd=-7
bShowJohnHP=0
johnHP=10
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if progress=0 //Fall and land
  {
    y+=8
    if y>=320
    {
      y=320
      playSound(global.snd_HardHit1,0,1,15000)
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x+random_range(-sprite_width/2,sprite_width/2),y+random_range(-2,2),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.66
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-random(1)
      }
      if prefight=1 //If checkpoint had been reached
      {
        progTime=379
      }
      progress+=1
    }
  }
  else if progress=1 //Chat for a moment
  {
    progTime+=1
    if progTime=1
    {
      msgCreate(0,0,"John","Hey there!!",6,1,oMessagePerson,0)
      newMessage.fadingTime=40
    }
    else if progTime=40
    {
      msgCreate(0,0,"Jerry","Oh hi! Uh... what?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if progTime=110
    {
      msgCreate(0,0,"John","Looks like you could use some help.",6,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if progTime=200
    {
      msgCreate(0,0,"Jerry","For sure!",0,1,oMessagePerson,0)
      newMessage.fadingTime=40
    }
    else if progTime=240
    {
      msgCreate(0,0,"John","Keep your assault going, its regen won't overpower my additional firepower!",6,2,oMessagePerson,0)
      newMessage.fadingTime=140
    }
    else if progTime>=380
    {
      if prefight=0
      {
        instance_create(0,0,oCheckpointNotice)
        msgCreate(0,0,"Jerry","All right! Time for an ass kicking then!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        global.bossTrack=3
      }
      oDecimatorV2.bLaserCannon=1; oDecimatorV2.bCanUseCannon=1 oDecimatorV2.bMissiles=1 oDecimatorV2.bossProgress+=1
      progTime=0; progress+=1;
    }
  }
  else if progress=2 //Shoot at Decimator with Mech
  {
    turn_toward_direction(point_direction(x-9,y-54,oDecimatorV2.x,oDecimatorV2.y),2)
    shotTime+=1
    if shotTime mod shotMod=0
    {
      playSound(global.snd_Fireball,0,0.95,30000)
      tNewAtk=instance_create(x-9,y-54,oJohnMechFire)
      tNewAtk.moveSpd=6; tNewAtk.direction=direction
    }

    rapidFire+=1
    if rapidFire>=190 and rapidFire<=220
    {
      if gunBlend=c_white {gunBlend=c_red}
      else {gunBlend=c_white}
    }
    if rapidFire=221 {gunBlend=c_white; shotMod=6}
    else if rapidFire=250 {shotMod=30; rapidFire=0}
  }
  else if progress=3 //Blown out of Mech
  {
    if ySpd<8 {ySpd+=0.3}
    y+=ySpd
    if y>=320
    {
      y=320
      sprite_index=sNPC_John_Land
      image_speed=0; image_index=0
      oDecimatorV2.regenRate=4
      progress=4
    }
  }
  else if progress=4 //Landing animation
  {
    progTime+=1
    if progTime=4 {image_index=1}
    else if progTime=8 {image_index=2}
    else if progTime=12 {sprite_index=sNPC_John_Idle}
    else if progTime=40
    {
      msgCreate(0,0,"Jerry","Well... what now?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if progTime=100
    {
      msgCreate(0,0,"John","I brought something else just in case.",6,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if progTime=190
    {
      msgCreate(0,0,"Jerry","Do tell!",0,1,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if progTime=240
    {
      msgCreate(0,0,"John","What?! No no Jerry. I'll SHOW you!",6,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if progTime=320 {sprite_index=sNPC_John_Ready}
    else if progTime=350
    {
      var tEffect;
      tEffect=instance_create(x-3,y-39,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if progTime=400
    {
      sprite_index=sNPC_JohnBattle_Bottom
      direction=0
      progTime=0; progress=5
    }
  }
  else if progress=5 //Gun is ready
  {
    progTime+=1
    if progTime=50
    {
      msgCreate(0,0,"John","It's on to me now, you guys. Keep that energy projectile away from me.",6,1,oMessagePerson,0)
      newMessage.fadingTime=150
    }
    else if progTime=170 {bShowJohnHP=1}
    else if progTime=240
    {
      msgCreate(0,0,"John","Really Jeremy? Comic Sans?",6,1,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if progTime=320
    {
      msgCreate(0,0,"Jeremy","It's better that way.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if progTime>=370
    {
      oDecimatorV2.bossProgress=6; oDecimatorV2.bCanUseCannon=1
      shotMod=70; progTime=0; progress=6
    }
  }
  else if progress=6 //Shoot at Decimator with Bazooka
  {
    turn_toward_direction(point_direction(x+12,y-32,oDecimatorV2.x,oDecimatorV2.y),2)
    shotTime+=1
    if shotTime mod shotMod=0
    {
      playSound(global.snd_MetMissile,0,1,14000)
      tNewAtk=instance_create(x+12,y-32,oJohnMissile)
      tNewAtk.moveSpd=3; tNewAtk.direction=direction
    }

    rapidFire+=1
    if rapidFire=240 {gunBlend=c_white; shotMod=20}
    else if rapidFire=280 {shotMod=70; rapidFire=0}
  }

  if keyPadAlpha=0.4 {keyPadAlpha=0.5}
  else {keyPadAlpha=0.4}
}
#define Collision_oPassBullet
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oDecimatorV2.bossProgress=4 and oDecimatorV2.progTime>=70 and progress=2
{
  playSound(global.snd_BombExplode,0,1,15000)
  var tEffect;
  tEffect=instance_create(x,y-32,oEffect)
  tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  oDecimatorV2.bAimAtJohn=0; oDecimatorV2.progTime=0; oDecimatorV2.missileDelay=360; oDecimatorV2.bossProgress+=1
  sprite_index=sNPC_John_Jump; image_speed=0.33
  y-=28
  progress=3
}
#define Collision_oDeci_EnergyBall
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_HolyWater,0,0.95,13000)
var tFlash,tEffect;
tFlash=instance_create(0,0,oScreenFlash)
tFlash.image_alpha=0.8; tFlash.image_blend=c_red; tFlash.fadeSpeed=0.2
johnHP-=1
if johnHP<=0 {oPlayer1.life-=oPlayer1.maxLife}
with other {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if progress<=2
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sNPC_John_Control,image_index,x-11,y-52,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sJohnMechKeypad,image_index,x+14,y-95,image_xscale,image_yscale,image_angle,image_blend,keyPadAlpha)
  draw_sprite_ext(sJohnMechGun,image_index,x-9,y-54,image_xscale,image_yscale,direction+12,gunBlend,image_alpha)
}
else if progress>=3 and progress<=4
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
else if progress>=5
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sNPC_JohnBattle_Top,image_index,x,y-25,image_xscale,image_yscale,direction,image_blend,image_alpha)
}

if bShowJohnHP=1
{
  draw_set_alpha(1)
  draw_set_font(fnt_Achievement)
  draw_set_halign(fa_center)
  textDropShadow("John HP: " +string(johnHP),x,y+12,c_white,c_black,1)
}
