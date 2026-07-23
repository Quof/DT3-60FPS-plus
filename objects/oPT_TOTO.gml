#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
image_xscale=2; image_yscale=2
image_speed=0
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="The Chosen One"
eLevel=30
maxLife=24000
life=maxLife
atkPower=8
affiliation=6
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bodyFrm=0; bodyAnim=0
tailFrm=0; tailAnim=0

waitTime=10
waitDelay=60
attackCycle=1
attackTime=60
atkA_Freq=7
atkB_Freq=12
atkC_Freq=12
atkCircleAmt=8
sideStart=0 //1-Left, 2-Right

specialAttack=0
specProg=0
specTime=0
specX=0
//--------------------

//Misc Data
xCenter=240
yGround=1344
roomSpan=192

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Body part animation
bodyAnim+=1
if bodyAnim=10 {bodyFrm=1}
else if bodyAnim=20 {bodyFrm=2}
else if bodyAnim=30 {bodyFrm=1}
else if bodyAnim=40 {bodyFrm=0; bodyAnim=0}
tailAnim+=1
if tailAnim=10 {tailFrm=1}
else if tailAnim=20 {tailFrm=2}
else if tailAnim=30 {tailFrm=1}
else if tailAnim=40 {tailFrm=0; tailAnim=0}

if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="Unfortunately Claire, I don't see any attacks that you can parry, but I think you'll be more effective at times. His NORMAL type resist drops when his mouth is open during an attack. He has a predictable pattern which you'll figure out soon enough. Do beware that his desperation attack is beastly. The behavior of it is borked, but terrifying."
    chaoText="This dragon is from 'Dark Awake: The King Has No Name' on the PS3."
    devText="It seemed the standard fantasy RPG always had a dragon of some kind. Originally the image for this dragon was 2x larger. While space isn't an issue, I didn't want a sprite that large if I didn't need it to be that big. Instead I shrunk it by 50% and used scaling. It pixelated the sprite of course, but it turned out to fit in better."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack=0
    {
      //Check player position
      playerDist=point_distance(x,0,oPlayer1.x,0)
      if playerDist>24
      {
        if x<oPlayer1.x {image_xscale=2}
        else {image_xscale=-2}
      }

      if image_index=2 {resType[0]=4}
      else {resType[0]=3}

      waitTime+=1
      if waitTime>=waitDelay
      {
        attackTime+=1
        event_user(attackCycle-1)
      }
    }
    else if specialAttack=1 //specProg [Never needed one, but this stayed here]
    {
      specTime+=1
      if specTime=1 //Init
      {

      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.74 and bossProgress=0
    {
      waitDelay-=10
      atkB_Freq-=1
      atkC_Freq-=1
      atkCircleAmt+=2
      bossProgress+=1
    }
    else if lifePercent<=0.73 and lifePercent>=0.55 and bossProgress=1
    {
      waitDelay-=10
      atkA_Freq-=1
      atkC_Freq-=1
      atkCircleAmt+=2
      bossProgress+=1
    }
    else if lifePercent<=0.54 and lifePercent>=0.36 and bossProgress=2
    {
      waitDelay-=10
      atkB_Freq-=1
      atkCircleAmt+=2
      bossProgress+=1
    }
    else if lifePercent<=0.35 and lifePercent>=0.11 and bossProgress=3
    {
      waitDelay-=10
      atkA_Freq-=1
      atkC_Freq-=1
      atkCircleAmt+=2
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=4
    {
      waitDelay-=10
      bossProgress+=1
    }
  }
  if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      if global.bBossGallery=1
      {
        bossRoomTally(45)
        global.newMapX=2008; global.newMapY=528; room_goto(rBossGallery)
      }
      else
      {
        image_index=0
        with oEProjectileBase {instance_destroy()}
        with oAttackBase {instance_destroy()}
        chargeFrame=0
      }
    }
    else if deathAnim>=2 and deathAnim<=99
    {
      if x<(room_width/2) {x+=16}
      else {x-=16}
      if y<224 {y+=16}
      else {y-=16}
      if point_distance(x,y,room_width/2,224)<18 {deathAnim=100}
    }
    else if deathAnim=145
    {
      createScreenText(240,96,80,fnt_Chapter,fa_middle,"'The Chosen One'#is charging for a super attack!",3,c_white,1,0)
    }
    else if deathAnim=250 {image_index=1}
    else if deathAnim=300
    {
      image_index=2
      createScreenText(240,96,80,fnt_Chapter,fa_middle,"But the attack failed because#it wasn't fully coded.",3,c_white,1,0)
    }
    else if deathAnim>=311 and deathAnim<=400
    {
      if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=401
    {
      oEvCh15MainA.sceneProgress=1
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime>=1 and attackTime<=60 //Track player if player is too far
{
  if playerDist>=40
  {
    if x<oPlayer1.x {x+=2}
    else {x-=2}
  }
}

if attackTime=61 {image_index=1} //Open mouth
else if attackTime=70 //Find player direction
{
  image_index=2
  myFireDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
}
else if attackTime>=71 and attackTime<=120 //Use fireballs
{
  var myAtk;
  if attackTime mod atkA_Freq=0
  {
    playSound(global.snd_Fireball,0,0.9,28000)
    myAtk=instance_create(x,y,oTOTO_FireA)
    myAtk.atkType=0; myAtk.atkPower=atkPower
    myAtk.mySpd=8; myAtk.direction=myFireDir+random_range(-6,6)
  }
}
else if attackTime>=121 //End
{
  image_index=0
  waitTime=0
  attackTime=0
  attackCycle+=1
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime=1 //Check side
{
  if x>room_width/2 {sideStart=1}
  else {sideStart=2}
}
else if attackTime>=2 and attackTime<=21 //Move up and to the side
{
  y-=3
  if sideStart=1 {x-=3}
  else {x+=3}
}
else if attackTime=25 {image_index=1} //Open mouth 1
else if attackTime=34 {image_index=2} //Open mouth 2
else if attackTime>=35 and attackTime<=90 //Use fireballs
{
  var myAtk;
  myFireDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
  if attackTime mod atkB_Freq=0
  {
    playSound(global.snd_Fireball,0,0.9,32000)
    myAtk=instance_create(x,y,oTOTO_FireB)
    myAtk.atkType=0; myAtk.atkPower=atkPower
    myAtk.mySpd=8; myAtk.direction=myFireDir+random_range(-6,6)
  }
}
else if attackTime>=91 //End
{
  image_index=0
  waitTime=0
  attackTime=0
  attackCycle+=1
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime=1 //Check side
{
  if x<(room_width/2) {sideStart=1}
  else {sideStart=2}
}
else if attackTime>=2 and attackTime<=99 //Move off map
{
  if y<224 {y+=3}
  if sideStart=1
  {
    x-=12
    if x<=0 {image_index=2; attackTime=100}
  }
  else if sideStart=2
  {
    x+=12
    if x>=room_width {image_index=2; attackTime=100}
  }
}
else if attackTime>=101 and attackTime<=399 //Fly across map, use fireballs down
{
  var myAtk;
  if attackTime mod atkC_Freq=0
  {
    if x<496 or x>656
    {
      playSound(global.snd_Flame1,0,0.9,47000)
      myAtk=instance_create(x,y,oTOTO_FireB)
      myAtk.atkType=0; myAtk.atkPower=atkPower
      myAtk.mySpd=8; myAtk.direction=270
    }
  }

  if sideStart=1
  {
    x+=8
    if x>=room_width-96 {attackTime=400}
  }
  else if sideStart=2
  {
    x-=8
    if x<=96 {attackTime=400}
  }
}
else if attackTime>=401 //End
{
  image_index=0
  waitTime=round(waitDelay/2)
  attackTime=0
  attackCycle+=1
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime=1 //Check side
{
  if x<room_width/2 {sideStart=1}
  else {sideStart=2}
}
else if attackTime>=2 and attackTime<=99 //Go to side position
{
  if y<272 {y+=3}
  if sideStart=1
  {
    x+=8
    if x>=448 {attackTime=100; image_index=1}
  }
  else if sideStart=2
  {
    x-=8
    if x<=1664 {attackTime=100; image_index=1}
  }
}
else if attackTime=105 {image_index=2} //Open mouth
else if attackTime=110 //Use fireballs
{
  playSound(global.snd_Earthquake,0,0.9,44100)
  var myAtk,tDir;
  tDir=0
  for(i=0;i<atkCircleAmt;i+=1)
  {
    myAtk=instance_create(x,y,oTOTO_FireC)
    myAtk.atkPower=atkPower
    if sideStart=1 {myAtk.moveSpd=3}
    else {myAtk.moveSpd=-3}
    myAtk.myDir=tDir
    tDir+=360/atkCircleAmt
  }
}
else if attackTime>=111 //End
{
  image_index=0
  waitTime=0
  attackTime=0
  attackCycle+=1
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime>=1 and attackTime<=99 //Fly up
{
  y-=16
  if y<=-480 {y=-480; attackTime=100}
}
if attackTime=101
{
  if oPlayer1.x<768 {x=576}
  else if oPlayer1.x>1344 {x=1536}
  else {x=1056}
}
else if attackTime>=111 and attackTime<=199 //Crash down
{
  y+=16
  if y>=224
  {
    playSound(global.snd_HardHit1,0,0.9,16000)
    var tEffect;
    for(i=0;i<48;i+=1)
    {
      if x=1056 {tEffect=instance_create(x+random_range(-208,208),352,oEffect)}
      else {tEffect=instance_create(x+random_range(-112,112),368,oEffect)}
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.2
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-4,4); tEffect.ySpd=random(-2)
    }
    y=224
    var tDamageZone;
    if x=576
    {
      tDamageZone=instance_create(464,356,oTOTO_Crash)
      tDamageZone.atkPower=8; tDamageZone.image_xscale=224; tDamageZone.image_yscale=12
    }
    else if x=1056
    {
      tDamageZone=instance_create(848,340,oTOTO_Crash)
      tDamageZone.atkPower=8; tDamageZone.image_xscale=416; tDamageZone.image_yscale=12
    }
    else if x=1536
    {
      tDamageZone=instance_create(1424,356,oTOTO_Crash)
      tDamageZone.atkPower=8; tDamageZone.image_xscale=224; tDamageZone.image_yscale=12
    }
    attackTime=200
  }
}
else if attackTime=202 {with oTOTO_Crash {instance_destroy()}} //Remove damage zone
else if attackTime>=203 //End
{
  image_index=0
  waitTime=0
  attackTime=0
  attackCycle=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=2 {draw_sprite_ext(sTOTO_Tail,tailFrm,x-101,y+343,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
else if image_xscale=-2 {draw_sprite_ext(sTOTO_Tail,tailFrm,x+101,y+343,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
draw_sprite_ext(sTOTO_Body,bodyFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
event_inherited() //Head
if deathAnim>=136 and deathAnim<=290
{
  chargeFrame+=0.33
  for(i=0;i<3;i+=1)
  {
    draw_sprite_ext(sMMcharging,chargeFrame+1,x,y+96,5,5,0,c_white,0.75)
  }
}
