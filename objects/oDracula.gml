#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Dracula"
eLevel=11
maxLife=3700
life=maxLife
atkPower=5
resType[1]=4
resType[2]=2
resType[4]=2
resType[5]=2
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
xCenter=360
yGround=288
//--------------------
idleTime=0
idleDelay=45

teleTime=0
teleOut=0
teleMod=1
teleCur=0
teleNext=0
teleSpots[0]=240
teleSpots[1]=480
teleSpots[2]=360
teleSpots[3]=128
teleSpots[4]=592

atkProg=0
atkTime=0
atkSeq=0
atkAnim=0
bigFireY=0
bFirePillar=0

lifeRefill=0
superFireAmt=4
superDir=0
fpTime=150
//--------------------
moveSpd=0

deathAnim=0

bBody=instance_create(x,y,oDraculaBody)
y+=6
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
    jeremyText="Here's a familiar fight. You shouldn't have much trouble with this. I'm not even seeing anything all that different about it. He teleports to specific spots on the map and shoots fireballs, and uh... fireballs, and then... well more fireballs."
    chaoText="Don't be scared of this guy, he's got nothing on you. Dracula has never been all that hard in the Castlevania games."
    devText="DT1 didn't have a lot of direction or focus when it first started. There was really no rhyme or reason to the boss encounters that were chosen for roughly half of the game. Since the Gates have very obvious themes, it was only right that Dracula would be here. The initial release to the testers didn't have the big flame pillars, and I never said I added them in later. That was quite a surprise to them I'm sure."
    bBody.jeremyText=jeremyText; bBody.chaoText=chaoText; bBody.devText=devText
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if atkProg=0 //-------------------- Slight wait time --------------------
    {
      idleTime+=1
      if idleTime>=5
      {
        idleTime=0
        atkProg+=1
      }
    }
    else if atkProg=1 //-------------------- Teleport --------------------
    {
      teleTime+=1*teleMod
      if teleTime<=20 //Wave out
      {
        teleOut+=1*teleMod
        if teleTime=4
        {
          playSound(global.snd_Beam,0,0.94,16000)
          bCanTakeDamage=0; bCanDealDamage=0
          bBody.bCanDealDamage=0
          //Choose next spot
          teleNext=teleSpots[teleCur]
          teleCur+=1
          if teleCur>=5 {teleCur=0}
          var tEffect,tFFScl;
          for(i=0;i<24;i+=1)
          {
            tFFScl=random(0.1)
            tEffect=instance_create(teleNext+random_range(-12,12),yGround-random(64),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
            tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
            tEffect.direction=random_range(85,95); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
            tEffect.fadeSpd=0.01; tEffect.image_blend=c_blue
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }
      }
      else if teleTime=44 //Go to next spot
      {
        if bossProgress<=3
        {
          x=teleNext
        }
        else
        {
          if bossProgress=4 {x=672}
          else if bossProgress=5 {x=48}
          else {x=360}
        }
      }
      else if teleTime>=52 and teleTime<=72 //Wave in
      {
        teleOut-=1*teleMod
        if teleTime=52 {playSound(global.snd_Beam,0,0.94,16000)}
        else if teleTime=60
        {
          if x>oPlayer1.x {image_xscale=-1}
          else {image_xscale=1}
        }
        else if teleTime=68
        {
          bCanTakeDamage=1; bCanDealDamage=1
          bBody.bCanDealDamage=1
        }
      }
      else if teleTime>=80 //End
      {
        if x>oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}

        teleOut=0
        teleTime=0
        if bossProgress<=3 {atkProg+=1}
        else if bossProgress=4 or bossProgress=5 {atkProg=10}
        else {atkProg=20}
      }
    }
    else if atkProg=2 //-------------------- Wait time --------------------
    {
      idleTime+=1
      if idleTime>=idleDelay
      {
        idleTime=0
        atkProg+=1
      }
    }
    else if atkProg=3 //-------------------- Attack --------------------
    {
      atkTime+=1
      if atkTime=1 //Choose Anim
      {
        if atkAnim=0 {bBody.sprite_index=sDraculaRightArm}
        else if atkAnim=1 {bBody.sprite_index=sDraculaLeftArm}
        else if atkAnim=2 {bBody.sprite_index=sDraculaBothArms}
      }
      else if atkTime>=2 and atkTime<=99 //End Anim
      {
        bBody.image_index+=0.15
        if bBody.image_index>=bBody.image_number-0.5
        {
          bBody.image_index=bBody.image_number-0.5
          atkTime=100
        }
      }
      else if atkTime=120 //Attack
      {
        if atkAnim=0 //----- Attack: Fireball - Triple after down on HP a bit -----
        {
          playSound(global.snd_Flame1,0,1,1)
          var tFire,tDir,tAmt;
          if image_xscale=1 {tDir=0}
          else {tDir=180}
          tAmt=1
          if bossProgress>=1
          {
            if image_xscale=1 {tDir=-10}
            else {tDir=170}
            tAmt=3
          }
          for(i=0;i<tAmt;i+=1)
          {
            tFire=instance_create(x+(6*(image_xscale*-1)),y+32,oPassBullet)
            tFire.sprite_index=sDraculaFireball; tFire.atkPower=atkPower; tFire.bulletSpeed=7
            tFire.image_speed=0.75; tFire.direction=tDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
            tDir+=10
          }
        }
        else if atkAnim=1 //----- Attack: Large fireballs - Fire pillars after HP down a bit more -----
        {
          if bossProgress=3 and bFirePillar=0
          {
            var tFirePillar;
            tFirePillar=instance_create(oPlayer1.x,yGround,oDracFireWave)
            tFirePillar.atkPower=atkPower
            for(i=1;i<4;i+=1)
            {
              tFirePillar=instance_create(oPlayer1.x-(i*96),yGround,oDracFireWave)
              tFirePillar.atkPower=atkPower
              tFirePillar=instance_create(oPlayer1.x+(i*96),yGround,oDracFireWave)
              tFirePillar.atkPower=atkPower
            }
            bFirePillar=1
          }

          var tFire,tDir;
          if image_xscale=1
            tDir=0
          else
            tDir=180

          playSound(global.snd_Flame1,0,0.95,9600)
          tFire=instance_create(x+(6*(image_xscale*-1)),y+26+bigFireY,oDracBigFire)
          tFire.atkPower=atkPower; tFire.bulletSpeed=0.5; tFire.bulletAcc=0.25
          tFire.bulletMax=6; tFire.direction=tDir; tFire.rotSpd=10

          if bigFireY=0 {bigFireY=32}
          else {bigFireY=0}

          atkSeq+=1
          if atkSeq<3 {atkTime=100}
          else {atkSeq=0}
        }
        else if atkAnim=2 //----- Attack: Fire Rain -----
        {
          if atkSeq=0
          {
            playSound(global.snd_Flame1,0,1,5512)
            var tFire,tDir;
            tDir=60
            for(i=0;i<7;i+=1)
            {
              tFire=instance_create(x+(6*(image_xscale*-1)),y+32,oPassBullet)
              tFire.sprite_index=sDraculaFireball; tFire.atkPower=atkPower; tFire.bulletSpeed=11
              tFire.image_speed=0.75; tFire.direction=tDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
              tDir+=10
            }
            atkSeq+=1
            atkTime=100
          }
        }
      }
      else if atkTime=130 and atkAnim=2 //Atk 3 End (Fire Rain)
      {
        var tFire,tPosX;
        tPosX=32+random(32)
        for(i=0;i<10;i+=1)
        {
          tFire=instance_create(tPosX,-8,oPassBullet)
          tFire.sprite_index=sDraculaFireball; tFire.atkPower=atkPower; tFire.bulletSpeed=8.75
          tFire.image_speed=0.75; tFire.direction=270; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"

          if bossProgress>=2
          {
            tFire=instance_create(tPosX,-8,oPassBullet)
            tFire.sprite_index=sDraculaFireball; tFire.atkPower=atkPower; tFire.bulletSpeed=1.25
            tFire.image_speed=0.75; tFire.direction=270; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
          }
          tPosX+=71
        }
        atkSeq=0
      }
      else if atkTime=140 //Atk 2 Extra (Huge Fireball)
      {
        if bossProgress>=2 and atkAnim=1
        {
          var tFire,tDir;
          if image_xscale=1 {tDir=0}
          else {tDir=180}
          tFire=instance_create(x+(6*(image_xscale*-1)),y+40,oDracBigFire)
          tFire.atkPower=atkPower+1; tFire.bulletSpeed=0.2; tFire.bulletAcc=0.2; tFire.bulletMax=4
          tFire.image_xscale=2; tFire.image_yscale=2; tFire.direction=tDir; tFire.rotSpd=5
        }
      }
      else if atkTime>=150 and atkTime<=209 //Reverse Anim
      {
        bBody.image_index-=0.15
        if bBody.image_index<=0.4
        {
          bBody.sprite_index=sDraculaIdle
          bBody.image_index=0
          atkTime=220
        }
      }
      else if atkTime=230 //End
      {
        bFirePillar=0
        atkTime=0
        atkProg=0
        atkAnim+=1
        if atkAnim=3 {atkAnim=0}
      }
    }
    else if atkProg=10 //-------------------- Super Attack: Wine Glass Throw --------------------
    {
      atkTime+=1
      if atkTime=1 //Change Anim
      {
        bBody.sprite_index=sDraculaLeftArm
        if bossProgress=4 {image_xscale=-1}
        else {image_xscale=1}
      }
      else if atkTime>=2 and atkTime<=99 //End Anim
      {
        bBody.image_index+=0.15
        if bBody.image_index>=1.5
        {
          bBody.image_index=1.5
          wineGlass=instance_create(x+(28*image_xscale),y,oMisc)
          wineGlass.sprite_index=sDraculaWineGlass
          wineGlass.type=2
          atkTime=100
        }
      }
      else if atkTime=130 //Throw glass
      {
        with wineGlass {instance_destroy()}

        var tWine;
        for(i=0;i<15;i+=1)
        {
          tWine=instance_create(x+(28*image_xscale),y,oDracWineGlass)
          tWine.type=0; tWine.atkPower=atkPower
          tWine.xVel=(1.5-(i/1.55))*(image_xscale*-1)
          tWine.yVel=-6-(i/10)
        }
      }
      else if atkTime=160 //End
      {
        atkProg=0
        bossProgress+=1
        atkTime=0
      }
    }
    else if atkProg=20 //-------------------- Super Attack: Fireball Swirl (Indefinite) --------------------
    {
      atkTime+=1
      if atkTime=1 //Change Anim
      {
        bBody.sprite_index=sDraculaBothArms
      }
      else if atkTime>=2 and atkTime<=99 //End Anim
      {
        bBody.image_index+=0.15
        if bBody.image_index>=3.5
        {
          bBody.image_index=3.5
          atkTime=100
        }
      }
      if atkTime>=120
      {
        if x>oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}

        fpTime+=1
        if fpTime>=270
        {
          playSound(global.snd_Flame1,0,1,9600)
          var tFirePillar;
          tFirePillar=instance_create(oPlayer1.x,yGround,oDracFireWave)
          tFirePillar.atkPower=atkPower
          fpTime=0
        }

        if atkTime mod 60=0
        {
          var tFire,tArc,tRanDir;
          tArc=0
          tRanDir=random(90)
          for(i=0;i<superFireAmt;i+=1)
          {
            tFire=instance_create(x+(6*(image_xscale*-1)),y+40,oPassArcBullet)
            tFire.sprite_index=sDraculaMeteor; tFire.direction=tArc+tRanDir
            tFire.atkPower=atkPower; tFire.bulletSpeed=3; tFire.damageType="EXPLOSION"
            if superDir=0 {tFire.arcAmt=4}
            else {tFire.arcAmt=-4}
            tFire.falloff=0.04; tFire.decayTime=-100

            tArc+=360/superFireAmt
          }
          if superDir=0 {superDir=1}
          else {superDir=0}
        }
      }
    }

    if lifeRefill>=100 and lifeRefill<=999 //Recharge life one time
    {
      life+=10
      lifeRefill+=1
      if lifeRefill>=180 {lifeRefill=1000}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.87 and lifePercent>=0.76 and bossProgress=0
    {
      idleDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.55 and bossProgress=1
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      resType[1]=3
      oDraculaBody.resType[1]=3
      idleDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.54 and lifePercent>=0.21 and bossProgress=2
    {
      idleDelay-=10
      teleMod=2
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=3
    {
      bBody.sprite_index=sDraculaIdle
      bBody.image_index=0
      atkTime=0
      atkProg=0
      teleOut=0
      teleTime=0
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      resType[1]=2
      oDraculaBody.resType[1]=2
      lifeRefill=100
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=6
    {
      superFireAmt+=1
      bossProgress+=1
    }
    oDraculaBody.x=x
    oDraculaBody.y=y+74
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      oDraculaBody.bCanDealDamage=0
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width)+random(sprite_width*2),(y-sprite_height/2)+random(sprite_height*8),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(11)
        global.newMapX=2424; global.newMapY=1312; room_goto(rBossGallery)
      }
      else
      {
        with oDraculaBody {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(bBody.sprite_index,bBody.image_index,x,y+74,image_xscale,image_yscale,0,image_blend,image_alpha)

if teleOut>=1
{
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_rectangle(x-teleOut,0,x+teleOut,y+74,0)
  draw_set_color(make_color_rgb(255,255,67))
  draw_line(x-teleOut+1,0,x-teleOut+1,y+74)
  draw_line(x+teleOut-1,0,x+teleOut-1,y+74)
  draw_set_color(make_color_rgb(255,178,32))
  draw_line(x-teleOut,0,x-teleOut,y+74)
  draw_line(x+teleOut,0,x+teleOut,y+74)
}

/*draw_set_alpha(1)
draw_set_color(c_white)
draw_set_font(fnt_PauseMenuMain)
draw_set_halign(fa_left)
draw_text(140,64,string("teleTime: ") +string(teleTime))
draw_text(140,80,string("teleOut: ") +string(teleOut))
draw_text(140,96,string("atkProg: ") +string(atkProg))
draw_text(140,112,string("Frame: ") +string(bBody.image_index) +string(" / ") +string(bBody.image_number))*/
