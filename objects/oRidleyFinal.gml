#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Ridley"
eLevel=25
maxLife=10000
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
bWave=1
moveWaveX=pi/2
moveWaveY=pi/2
moveSpdX=0
moveSpdY=0
moveSpd=4

atkProg=0
atkTime=0
fireballRate=0

freezeHit=0
frozenTime=0
bossTime=0

//Body Data
ridParts[0]=instance_create(x,y,oRidleyParts); ridParts[0].depth=4; ridParts[0].type=0
ridParts[1]=instance_create(x,y,oRidleyParts); ridParts[1].sprite_index=sRidleyWings; ridParts[1].depth=5; ridParts[1].type=1
ridParts[2]=instance_create(x,y,oRidleyParts); ridParts[2].sprite_index=sRidleyArms; ridParts[2].depth=6; ridParts[2].type=2
for(i=0;i<3;i+=1)
{
  ridParts[i].myOwner=id
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
}
ridTail[6].sprite_index=sRidleyTailEnd; ridTail[6].depth=9
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
    jeremyText="This is it, Ridley is going down this time. No more messing around, we're going to find a way through that invincibility, even if it means breaking the rules."
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="I knew right away when I was going to do a Metroid level, that Ridley would be the end boss. Since Gate 5 is the last of Gates that give permanent Ability Sets, and the last of its kind, I wanted it to end on a high note. I'll let you see how that goes."
    with oRidleyParts
    {
      jeremyText=oRidleyFinal.jeremyText
      chaoText=oRidleyFinal.chaoText
      devText=oRidleyFinal.devText
    }
    activateBoss=2
  }

  if life>0
  {
    if bWave=1 //Idle wave motion
    {
      moveWaveY+=0.2
      y+=sin(moveWaveY)
      if x+16<oPlayer1.x {image_xscale=1}
      else if x-16>oPlayer1.x {image_xscale=-1}
    }

    if fireballRate>0 //-- Spit fireballs --
    {
      if atkTime mod fireballRate=0
      {
        playSound(global.snd_RidleyFire,0,0.98,1)
        var tNewAttack;
        tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
        tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
        tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
      }
    }

    atkTime+=1
    if atkProg=0 //-------------------- Fly up over player --------------------
    {
      if atkTime=1 {bWave=0; oRidleyParts.tailType=2}
      else if atkTime>=2 and atkTime<=999
      {
        y-=6
        if y<=180
        {
          bWave=1
          atkTime=0; atkProg=1
        }
      }
    }
    else if atkProg=1 //-------------------- Hover over player, use tail, use fireball --------------------
    {
      //Movement
      if atkTime<=110 or atkTime>=149
      {
        if x>oPlayer1.x
        {
          if moveSpdX>-4 {moveSpdX-=0.5}
        }
        else
        {
          if moveSpdX<4 {moveSpdX+=0.5}
        }
        x+=moveSpdX
      }
      else if atkTime>=111 and atkTime<=140 //Track player, tail spins
      {
        var tChkMove;
        tChkMove=point_distance(x,0,oPlayer1.x,0)
        distMax=96
        if tChkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {x-=moveSpd}
          else {x+=moveSpd}
        }
        else if tChkMove>distMax
        {
          if image_xscale=1 {x+=moveSpd}
          else {x-=moveSpd}
        }
      }

      if atkTime=40 {ridParts[0].image_index=1}
      else if atkTime=44 {ridParts[0].image_index=2}
      else if atkTime=49 {fireballRate=7}
      else if atkTime=89 {fireballRate=0}
      else if atkTime=94 {ridParts[0].image_index=1}
      else if atkTime=98 {ridParts[0].image_index=0}
      else if atkTime=110 {oRidleyParts.tailType=3}
      else if atkTime=111 {playSound(global.snd_PlayerJump[0],0,1,12000)}
      else if atkTime=131 {playSound(global.snd_PlayerJump[0],0,1,12000)}
      else if atkTime=150 //Find player for tail stab
      {
        var tChkDir;
        tChkDir=point_direction(ridTail[0].x,ridTail[0].y,oPlayer1.x,oPlayer1.y-26)
        oRidleyParts.tailType=4; oRidleyParts.tailAngle=tChkDir
        playSound(global.snd_PlayerJump[0],0,1,8000)
      }
      else if atkTime>=151 and atkTime<=160 {oRidleyParts.tailSep+=3} //Extend tail
      else if atkTime>=161 and atkTime<=170 {oRidleyParts.tailSep-=3} //Detract tail
      else if atkTime=171 {oRidleyParts.tailType=2}
      else if atkTime>=175
      {
        if bossProgress=20 {atkTime=35}
        else {atkTime=0}
      }
    }
    else if atkProg=2 //-------------------- Frozen state --------------------
    {
      frozenTime+=1
      if frozenTime>=315 and frozenTime mod 2=0
      {
        if image_blend=baseColor {image_blend=c_red}
        else {image_blend=baseColor}
      }
      if frozenTime>=360
      {
        ridParts[1].myAnim=0; ridParts[2].myAnim=0
        baseColor=c_white
        image_blend=baseColor
        with oRidleyParts
        {
          baseColor=c_white
          image_blend=baseColor
        }
        with oEnemyBase {bCanDealDamage=1}
        frozenTime=0
        bWave=1
        atkTime=0
        atkProg=1
      }
    }

    //-------------------------------------------------- Dialogue sequence --------------------------------------------------
    bossTime+=1
    if bossProgress=0
    {
      if bossTime=75
      {
        msgCreate(0,0,"Hex","Let's hide the health bar, it's unnecessary anyway.",0,1,oMessagePerson,0)
        newMessage.fadingTime=95; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=1
    {
      if bossTime=25 {bShowHealthBar=false; with showBossHP {instance_destroy()}}
      else if bossTime=95
      {
        msgCreate(0,0,"Jerry","Why is it called a 'health' bar and not a 'life' bar? No really, 'Oh he shot me and that caused me to get sick.'",0,2,oMessagePerson,0)
        newMessage.fadingTime=170; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=2
    {
      if bossTime=170
      {
        msgCreate(0,0,"Claire","What are you even talking about?",0,1,oMessagePerson,0)
        newMessage.fadingTime=75; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=3
    {
      if bossTime=75
      {
        msgCreate(0,0,"Jerry","Improper usage of words! It's annoying!",0,1,oMessagePerson,0)
        newMessage.fadingTime=85; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=4
    {
      if bossTime=85
      {
        msgCreate(0,0,"Jeremy","I really don't think this is a good time for arguing about such things.",0,1,oMessagePerson,0)
        newMessage.fadingTime=130; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=5
    {
      if bossTime=130
      {
        msgCreate(0,0,"Hex","Oh, I have another idea! Let's raise those defenses!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=6
    {
      if bossTime=25
      {
        with oEnemyBase
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=1
          }
          resType[2]=4
        }
        life=maxLife
      }
      if bossTime=100
      {
        msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0)
        newMessage.fadingTime=40; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=7
    {
      if life<maxLife {bossProgress=14}
      if bossTime=120
      {
        msgCreate(0,0,"Claire","None of my attacks work...",0,1,oMessagePerson,0)
        newMessage.fadingTime=65; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=8
    {
      if life<maxLife {bossProgress=14}
      if bossTime=65
      {
        msgCreate(0,0,"Jeremy","Uh... I'm trying.",0,1,oMessagePerson,0)
        newMessage.fadingTime=65; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=9
    {
      if life<maxLife {bossProgress=14}
      if bossTime=65
      {
        msgCreate(0,0,"Claire","Can't you make like... I don't know, my beam freeze him or something?",0,1,oMessagePerson,0)
        newMessage.fadingTime=130; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=10
    {
      if life<maxLife {bossProgress=14}
      if bossTime=130
      {
        msgCreate(0,0,"Jeremy","No, he's locked down your attacks on that front.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=11
    {
      if life<maxLife {bossProgress=14}
      if bossTime=100
      {
        msgCreate(0,0,"Hex","You won't win this. I can guarantee that.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=12
    {
      if life<maxLife {bossProgress=14}
      if bossTime=90
      {
        msgCreate(0,0,"Chao","Don't give up! I'm sure there's SOMETHING you haven't tried. Maybe you can't freeze him, but...",0,2,oMessagePerson,0)
        newMessage.fadingTime=160; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=13
    {
      if life<maxLife {bossProgress=14}
      if bossTime=160
      {
        msgCreate(0,0,"Hex","You're all so hilarious to watch.",0,1,oMessagePerson,0)
        newMessage.fadingTime=65; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=14 //Damage Ridley a bit to continue
    {
      if life<=9000
      {
        msgCreate(0,0,"Hex","Well that's annoying. I didn't realize the Chip broke the Gate restrictions.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110; bossTime=0; bossProgress+=1
      }

      if life=maxLife and bossTime=600 //If player has not dealt damage to Ridley after 20 seconds pass
      {
        msgCreate(0,0,"Chao","None of your weapons that you've tried can hurt him, Claire.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
    }
    else if bossProgress=15
    {
      if bossTime=110
      {
        msgCreate(0,0,"Jeremy","That's the way, you guys!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=16
    {
      if bossTime=60
      {
        msgCreate(0,0,"Hex","Except you forgot that Ridley can't be defeated.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=17
    {
      if bossTime=100
      {
        msgCreate(0,0,"Jeremy","Hex is right, however, just as he can change the rules, so can I!",0,1,oMessagePerson,0)
        newMessage.fadingTime=120; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=18
    {
      if bossTime=120
      {
        msgCreate(0,0,"Hex","There's nothing you can do, Jeremy. You're inferior to me now!",0,1,oMessagePerson,0)
        newMessage.fadingTime=110; bossTime=0; bossProgress+=1
      }
    }
    else if bossProgress=19
    {
      if bossTime=110
      {
        msgCreate(0,0,"Jeremy","I've adjusted things so you can freeze him. Trust me on this, you can. And then I bet with the modifications I made, you can shatter him with a big impact!",0,3,oMessagePerson,0)
        newMessage.fadingTime=210
        with oEnemyBase
        {
          jeremyText="After you've frozen him, have Claire finish him off with a large impact. I know she has something that hits really hard."
        }
        life=maxLife; bossTime=0; bossProgress+=1
      }
    }

    if lifePercent<=0.2 //------------------------------ Keep life from going to 0 ------------------------------
    {
      life=maxLife/5
    }
  }
  oRidleyParts.image_blend=image_blend
  oRidleyParts.image_xscale=image_xscale
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if bossProgress=20
{
  if atkProg=1 //Hit with Shotgun Ice to freeze Ridley
  {
    if other.weaponTag=11 //Shotgun Ice
    {
      freezeHit+=1
      if freezeHit>=6
      {
        baseColor=c_blue
        image_blend=baseColor
        with oRidleyParts
        {
          baseColor=c_blue
          image_blend=baseColor
        }
        with oEnemyBase {bCanDealDamage=0}
        ridParts[1].myAnim=50; ridParts[2].myAnim=50
        oRidleyParts.tailType=2; oRidleyParts.tailSep=8
        freezeHit=0
        bWave=0
        fireballRate=0
        atkProg=2
      }
    }
  }
  else if atkProg=2 //Hit with Super Missile to shatter Ridley
  {
    if other.weaponTag=41 and other.sprite_index=sSamusSuperMissile
    {
      oEvCh13MainA.sceneProgress=1
      global.gamePaused=true
      atkProg=3
    }
  }
}
