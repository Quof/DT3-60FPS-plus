#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-38,15,-1)
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Bowser"
atkPower=3
stunResist=50
affiliation=1
bIsBoss=true
bNoBonus=true
dieEffect=0
atkProg=0
atkTime=0
jumpDelay=90
hopTime=0
fireTime=-10
fireDelay=45
jumpNum=1

bottomBlocks=-1

bossProgress=0
activateBoss=0

xCenter=720
topFire=0

jeremyText="Normally I'd tell you how to beat him, but is it really necessary? I mean you played Mario 3... right? Anyway, there are a few subtle differences. His fireballs will aim straight for where you are at the moment they are fired, you can use that to your advantage. I've picked up another attack, it's a fireball rain. Note that you're bigger than Mario is. The arena is bigger too so keep that in mind."
chaoText="Bowser isn't really evil, I can tell. I think at this point, he just kidnaps Peach due to his rivalry with Mario and takes some enjoyment out of the whole process. Maybe he loves the nostalgic feel of it all."
devText="I thought it would be pretty cool to see this as the first boss fight in the game as it sets a precedent that bosses aren't all going to follow the formula that I used for the other games. Plus as a kid, this encounter was very memorable to me."
extraInfo="Immune to the Mario stomp ability."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false //&& gDeltaDoTicks != 0
{
  if activateBoss=1
  {
    bActive=true
    activateBoss=2
  }

  if bActive=true and stunnedTime=0
  {
    if atkProg=0 //---------- Stand ----------
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      atkTime+=1*gDeltaTime
      if atkTime>=jumpDelay
      {
        if isCollisionBottom(1)
        {
          if fireTime>=fireDelay-1
          {
            var tNewAttack,tXOffset,tDir;
            if image_xscale=1
            {
              tXOffset=8
              tDir=0
            }
            else
            {
              tXOffset=-8
              tDir=180
            }
            playSound(global.snd_Fireball,0,0.99,1)
            tNewAttack=instance_create(x+tXOffset,y-28,oBowserFire)
            tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=atkPower
            tNewAttack.bulletSpeed=3; tNewAttack.baseDir=tDir
          }
          xDropSpot=oPlayer1.x
          xSpd=point_distance(x,0,xDropSpot,0)
          xSpd/=12
          if xSpd<2 {xSpd=2}
          else if xSpd>8 {xSpd=8}
          sprite_index=sBowserStand; image_index=1
          atkTime=0; atkProg+=1
        }
      }
      else //Hop
      {
        hopTime-=1*gDeltaTime
        if hopTime<=0 and yVel=0
        {
          y-=2
          yVel-=1.5
          hopTime=30
        }

        //Fireball
        fireTime+=1*gDeltaTime
        if fireTime>=fireDelay and y<328
        {
          if fireTime=fireDelay
          {
            sprite_index=sBowserStand
            image_index=2
          }
          else if fireTime=fireDelay+4
          {
            sprite_index=sBowserStand
            image_index=3
          }
          else if fireTime>=fireDelay+8
          {
            var tNewAttack,tXOffset,tDir;
            if image_xscale=1
            {
              tXOffset=8
              tDir=0
            }
            else
            {
              tXOffset=-8
              tDir=180
            }
            playSound(global.snd_Fireball,0,0.99,1)
            tNewAttack=instance_create(x+tXOffset,y-28,oBowserFire)
            tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=atkPower
            tNewAttack.bulletSpeed=3; tNewAttack.baseDir=tDir

            sprite_index=sBowserStand; image_index=0
            fireTime=0
          }
        }
        else
        {
          if isCollisionBottom(1) //Animation
          {
            sprite_index=sBowserStand
            image_index=0
          }
          else
          {
            sprite_index=sBowserStand
            image_index=1
          }
        }
      }
    }
    else if atkProg=1 //---------- Jump ----------
    {
      if y>144 {y-=12*gDeltaTime}
      if x<xDropSpot
      {
        image_xscale=1
        x+=xSpd*gDeltaTime
      }
      else
      {
        image_xscale=-1
        x-=xSpd*gDeltaTime
      }
      if point_distance(x,0,xDropSpot,0)<12 //found spot
      {
        move_snap(16,1)
        sprite_index=sBowserStomp; image_index=0
        atkProg+=1
      }
    }
    else if atkProg=2 //---------- Slight air time ----------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=12
      {
        atkTime=0
        atkProg+=1
      }
      else {y-=0.5*gDeltaTime}
    }
    else if atkProg=3 //---------- Butt stomp ----------
      yVel=10
    else if atkProg=4 //---------- Break block check ----------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=8
      {
        jumpNum+=1
        if jumpNum>=2 //Double stomp
        {
          jumpNum=-1
          atkTime=jumpDelay-6
          atkProg=0
        }
        else
        {
          atkTime=0
          atkProg=0
        }
      }
    }

    if atkProg=0 or atkProg=4 //Gravity
      yVel+=0.2*gDeltaTime

    if isCollisionSolid()
      y-=2
    if isCollisionBottom(1)
    {
      yVel=0
      if atkProg=3
      {
        playSound(global.snd_ThwompHit,0,1,1)
        var tEffect;
        tEffect=instance_create(x+12,bbox_bottom,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=1; tEffect.ySpd=0
        tEffect=instance_create(x-12,bbox_bottom,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_xscale=-1; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-1; tEffect.ySpd=0
        sprite_index=sBowserStomp; image_index=1
        atkProg+=1
        y+=1
      }
    }

    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    if y>room_height+48 //---------- End fight ----------
    {
      with oEProjectileBase {instance_destroy()}
      if global.bBossGallery=1
      {
        bossRoomTally(0)
        global.newMapX=264; global.newMapY=1376; room_goto(rBossGallery)
      }
      else {oEvCh2MainA.sceneProgress=1}
      instance_destroy()
    }

    //----- Last block phase -----
    if bottomBlocks>=0 and bottomBlocks<=99
    {
      bottomBlocks+=1*gDeltaTime
      if bottomBlocks>=1 and bottomBlocks<=16 //Move bottom blocks down
      {
        var tInsCheck;
        tInsCheck=455498
        for(i=0;i<8;i+=1) //455498 - 455505
        {
          (GID(455498+i)).y+=1*gDeltaTime
        }
      }
      if bottomBlocks=20
      {
        (GID(122344)).bTellMeToExplode=1
        (GID(122345)).bTellMeToExplode=1
        (GID(122358)).bTellMeToExplode=1
        (GID(122359)).bTellMeToExplode=1
        instance_create(608,288,oBowSwitch)
        instance_create(832,288,oBowSwitch)
        bottomBlocks=100
      }
    }
    else if bottomBlocks=100 //Check for one switch destroyed
    {
      if instance_number(oBowSwitch)=1
      {
        topFire=1
        bottomBlocks=150
      }
    }
    else if bottomBlocks=150 //Check for both switches destroyed
    {
      if instance_number(oBowSwitch)=0
      {
        bottomBlocks=200
      }
    }
    else if bottomBlocks>=200 and bottomBlocks<=400
    {
      bottomBlocks+=1*gDeltaTime
      if bottomBlocks>=281 and bottomBlocks<=296 //Move bottom blocks up
      {
        var tInsCheck;
        tInsCheck=455498
        for(i=0;i<8;i+=1) //455498 - 455505
        {
          (GID(455498+i)).y-=1*gDeltaTime
        }
      }
      else if bottomBlocks=300
      {
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(664+(i*16),328,oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.2+random(0.2); tEffect.xSpd=0; tEffect.ySpd=-1-random(2)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        }
        with oBowBottomBlock {instance_destroy()}
      }
    }

    if topFire>=1 //Fire from the top
    {
      topFire+=1*gDeltaTime
      if topFire mod 65=0
      {
        var tNewAttack;
        tNewAttack=instance_create(oPlayer1.x,0,oPassBullet)
        tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=2
        tNewAttack._direction=270; tNewAttack.decayTime=-100
      }
    }

    //---------- Boss Difficulty Curve ----------
    if bossProgress=0 and y>=280
    {
      jumpDelay+=3
      fireDelay-=3
      bossProgress+=1
    }
    else if bossProgress=1 and y>=296
    {
      jumpDelay+=5
      fireDelay-=5
      playSound(global.snd_Fireball,0,0.99,1)
      for(i=0;i<5;i+=1)
      {
        var tNewAttack;
        tNewAttack=instance_create(592+(i*64),0,oPassBullet)
        tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=3
        tNewAttack._direction=270; tNewAttack.decayTime=-100
      }
      bossProgress+=1
    }
    else if bossProgress=2 and y>=312
    {
      bottomBlocks=0
      instance_create(656,320,oBowBottomBlock)
      var tEffect;
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(664+(i*16),328,oEffect)
        tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_speed=0.2+random(0.2); tEffect.xSpd=0; tEffect.ySpd=-1-random(2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
      }

      jumpDelay+=4
      fireDelay-=4
      playSound(global.snd_Fireball,0,0.99,1)
      for(i=0;i<5;i+=1)
      {
        var tNewAttack;
        tNewAttack=instance_create(592+(i*64),0,oPassBullet)
        tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=3
        tNewAttack.bulletSpeed=3; tNewAttack._direction=270; tNewAttack.decayTime=-100
      }
      bossProgress+=1
    }
  }
  enemyStepEvent()
}
#define Collision_oMarioBreakBlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=4
{
  with other
  {
    for(i=0;i<4;i+=1)
    {
      newEffect=instance_create(x+8,y+8,oEfMarioBlock)
      newEffect.type=i
    }
    instance_destroy()
  }
}
#define Collision_oBowSwitch
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.myProg=1 {other.myProg=2}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/

event_inherited()
