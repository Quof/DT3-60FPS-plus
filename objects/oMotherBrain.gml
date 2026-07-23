#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanTakeDamage=false

//Enemy base statistics
eName="MotherBrain"
eLevel=24
maxLife=2600
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
brainFrm=0
eyeFrm=0
eyeAnim=0
eyeOpen=100
openTime=75
jeremyTalks=0

//Misc Data
deathAnim=0
myGun=instance_create(x+19,y+44,oSolid); myGun.sprite_index=sMotherBrainGun; myGun.depth=12
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0

    jeremyText="For some reason, the Brain doesn't have the glass casing. I don't know why, but I feel like it's a sign that someone knew we would be here. That glass didn't do anything anyway... Oh right, all it does is flash before firing its 'Brain Wave' attack. It will open its eye right after so you'll be able to damage it then. The guns and rings in the chamber should be your bigger concern."
    chaoText="Mother Brain was created by the Chozo, and is speculated that the Federation had a part in its creation as well. When the Space Pirates invaded Zebes, it betrayed the Chozo in pursuit of its own agenda."
    devText="This was the one encounter I didn't want to change up too much from the original as I felt it was at an appropriate difficulty. Of course, I still did my own thing with the placement and spawning time of turrets and Rinkas."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Brain animation
    brainFrm+=1
    if brainFrm=10 {image_index=1}
    else if brainFrm=20 {image_index=2}
    else if brainFrm=30 {image_index=1}
    else if brainFrm=40 {image_index=0; brainFrm=0}

    //Eye animation
    eyeAnim+=1
    if eyeAnim<eyeOpen
    {
      if eyeAnim mod 8=0
      {
        if eyeFrm=0 {eyeFrm=1}
        else if eyeFrm=1 {eyeFrm=0}
      }
    }
    else if eyeAnim>=eyeOpen and eyeAnim<1000 {eyeAnim=1000}
    else if eyeAnim>=1001 and eyeAnim<=1045 //Charge flash
    {
      var tChargeCol;
      tChargeCol=make_color_rgb(random(255),random(255),random(255))
      image_blend=tChargeCol; myGun.image_blend=tChargeCol
      if eyeAnim>=1031 {eyeAnim=1045}
    }
    else if eyeAnim=1046 //Fire beam
    {
      image_blend=c_white; myGun.image_blend=c_white
      var tAtk;
      tAtk=instance_create(x+86,y+57,oPassBullet)
      tAtk.sprite_index=sMB_BrainWave; tAtk.direction=0; tAtk.depth=9
      tAtk.atkPower=atkPower; tAtk.bulletSpeed=6; tAtk.decayTime=-100
      eyeFrm=2
    }
    else if eyeAnim=1049 {eyeFrm=3}
    else if eyeAnim=1052 {eyeFrm=4}
    else if eyeAnim=1055 {eyeFrm=5; bCanTakeDamage=true; eyeAnim=2000}
    else if eyeAnim>=2000+openTime and eyeAnim<3000 {eyeFrm=4; bCanTakeDamage=false; eyeAnim=3000}
    else if eyeAnim=3003 {eyeFrm=3}
    else if eyeAnim=3006 {eyeFrm=2}
    else if eyeAnim>=3009
    {
      eyeFrm=1
      eyeAnim=0
    }

    if jeremyTalks>=1 //Hit Mother Brain from behind
    {
      jeremyTalks+=1
      if jeremyTalks=3
      {
        msgCreate(0,0,"Jeremy","Wow, cheating much?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if jeremyTalks=70
      {
        msgCreate(0,0,"Claire","Whatever, nothing is stopping me.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if jeremyTalks=150
      {
        msgCreate(0,0,"Jeremy","This is a breach of gamer code.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if jeremyTalks=230
      {
        msgCreate(0,0,"Claire","You could fool non-gamers, but I don't fall for that, Jeremy.",0,1,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if jeremyTalks=370
      {
        msgCreate(0,0,"Jerry","This is totally something I would do!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if jeremyTalks=430
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,44)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Smarter than the Brain"; tAchievement.checkNum=44
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      eyeOpen-=5
      openTime-=10
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      eyeOpen-=5
      openTime-=10
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      eyeOpen-=5
      openTime-=10
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x+random(80),y+random(63),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(33)
        global.newMapX=1304; global.newMapY=784; room_goto(rBossGallery)
      }
      else
      {
        oEvCh13MainA.sceneProgress=2
        with myGun {instance_destroy()}
        with oMB_RinkaGen {instance_destroy()}
        with oMB_Turret {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {redDmgHit(0)}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.x<x and jeremyTalks=0 {jeremyTalks=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sMotherBrainEye,eyeFrm,x+61,y+29,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
