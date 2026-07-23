#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-30,-47,30,-1)
bCanTakeDamage=false
bCanDealDamage=false
image_speed=0
animSpd=0.2

//Enemy base statistics
eName="CHAOS Spider Drone"
eLevel=34
maxLife=1700
life=maxLife
pointWorth=106
atkPower=9
stunResist=15
baseItemChance=75
moneyWorth=10
affiliation=7
dieSound=0
dieEffect=0

runAcc=2.5
minDistToPlayer=112
flipTransition=0
flipTime=120
gravAmt=0.3
shotTime=85
shotDelay=115
shotType=0
appearIn=0
heightDraw=0

if room=rDCS_O
{
  bShowHealthBar=false
  maxLife=10000
  life=maxLife
}

deathAnim=0

jeremyText="Oh, this is interesting. Remember the 'Wall Cancer' robot in Gate 4? It was the crab on the wall that shot two bouncing energy balls. This thing fires 12 of those, which can make things pretty spammy. It also has the ability to reverse its gravity and cling to the ceiling. Another thing to note is it will speed up the time it takes to fire its next shot when it is continually taking damage."
chaoText="Spider Drones are love! Spider Drones are life! ...#What? I thought it was funny."
devText="I had nearly all of the enemy AI for the end game prepped well in advance, which I typically didn't do for most of the different areas in the game. Most of the AI was made just before drawing out the levels. In some cases, the levels were made first, and the enemies were tailored for those environments afterwards."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if appearIn=0
    {
      heightDraw+=1
      if heightDraw>=sprite_height
      {
        bCanTakeDamage=true
        bCanDealDamage=true
        appearIn=1000
      }
    }
    else
    {
      //---------- Movement ----------
      if yVel=0 and flipTransition=0
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)>minDistToPlayer+(minDistToPlayer/5) //Toward player
        {
          image_index+=animSpd
          if x<oPlayer1.x {xVel=runAcc}
          else {xVel=-runAcc}
        }
        else if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer //Away from player
        {
          image_index-=animSpd
          if x<oPlayer1.x {xVel=-runAcc}
          else {xVel=runAcc}
        }
        else {xVel=0}
      }
      else {xVel=0}

      //Flipping transition
      if flipTransition>=1 and flipTransition<=50 //To ceiling
      {
        flipTransition+=1
        if flipTransition=20
        {
          setCollisionBounds(-30,0,30,47)
          image_yscale=-1
          flipTransition=0
        }
      }
      else if flipTransition>=1001 and flipTransition<=1050 //To floor
      {
        flipTransition+=1
        if flipTransition=1020
        {
          setCollisionBounds(-30,-47,30,-1)
          image_yscale=1
          flipTransition=0
        }
      }

      /*if yVel=0 and flipTransition=0
      {
        //---------- Check if wall and flip ----------
        if aiCheckHoriz(0,3,16,16,-8*image_yscale)=1
        {
          if image_yscale=1
          {
            flipTransition=1; gravAmt=-0.3
            flipTime-=120
            if flipTime<0 {flipTime=0}
          }
          else
          {
            flipTransition=1001; gravAmt=0.3
            flipTime-=120
            if flipTime<0 {flipTime=0}
          }
        }

        //---------- Check if cliff edge and flip ----------
        var tDrop;
        tDrop=0
        if aiCheckHoriz(1,1,0,16,4*image_yscale)
        {
          if aiCheckVert(0,3,24*image_yscale,16,4*image_yscale)=1 {tDrop=1}
        }

        if tDrop=0
        {
          if image_yscale=1
          {
            flipTransition=1; gravAmt=-0.3
            flipTime-=120
            if flipTime<0 {flipTime=0}
          }
          else
          {
            flipTransition=1001; gravAmt=0.3
            flipTime-=120
            if flipTime<0 {flipTime=0}
          }
        }
      }*/

      //---------- Flip if too much time has passed ----------
      if flipTransition=0
      {
        flipTime+=1
        if flipTime>=300
        {
          if image_yscale=1 {flipTransition=1; gravAmt=-0.3}
          else {flipTransition=1001; gravAmt=0.3}
          flipTime=0
        }
      }

      //---------- ATTACK: BOUNCE BULLETS ----------
      shotTime+=1
      if shotTime>=shotDelay
      {
        var tNewAttack,tShotSpd;
        tShotSpd=1.5
        for(i=1;i<=2;i+=1)
        {
          tNewAttack=instance_create(x+24,y-(52*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=tShotSpd*i; tNewAttack.yVel=-tShotSpd*i
          tNewAttack=instance_create(x+28,y-(42*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=tShotSpd*i; tNewAttack.yVel=0.25*image_yscale
          tNewAttack=instance_create(x+26,y-(31*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=tShotSpd*i; tNewAttack.yVel=tShotSpd*i
          tNewAttack=instance_create(x-24,y-(52*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=-tShotSpd*i; tNewAttack.yVel=-tShotSpd*i
          tNewAttack=instance_create(x-28,y-(42*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=-tShotSpd*i; tNewAttack.yVel=-0.25*image_yscale
          tNewAttack=instance_create(x-26,y-(31*image_yscale),oMMWC_Shot)
          tNewAttack.atkPower=atkPower; tNewAttack.xVel=-tShotSpd*i; tNewAttack.yVel=tShotSpd*i
        }
        shotTime=0
      }

      yVel+=gravAmt
      if isCollisionBottom(1)
      {
        if gravAmt>0 {yVel=0}
        else {yVel=-1}
      }
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionTop(1)
      {
        if gravAmt>0 {yVel=1}
        else {yVel=0}
      }

      moveTo(xVel,yVel)
      if isCollisionSolid() {y-=2}
      if y>room_height+24
      {
        if questType>0 {enemyQuest(questType)}
        instance_destroy()
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-36,36),y-1-random(40),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.075
    if image_alpha<0
    {
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL" {shotTime+=15}
else if other.damageType="SPECIAL" {shotTime+=10}
else {shotTime+=5}
flipTime+=10
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if appearIn=0
{
  draw_sprite_part(sprite_index,0,0,0,sprite_width,heightDraw,x-55,y-58)
  draw_set_alpha(1)
  draw_set_color(c_green)
  draw_line(x-55,y-sprite_height+heightDraw,x+55,y-sprite_height+heightDraw)
}
else {event_inherited()}
