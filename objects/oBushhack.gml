#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-18,12,-1)
bCanTakeDamage=false
image_speed=0

//Enemy base statistics
eName="Bushhack"
eLevel=34
maxLife=550
life=maxLife
pointWorth=79
atkPower=9
resType[0]=4
resType[1]=2
stunResist=5
baseItemChance=65
moneyWorth=5

enemyProg=0
throwTime=0
throwNum=0

jeremyText="As you probably already saw, these guys like to hide in a bush. While hiding, they're completely invulnerable. If you get close enough, it'll jump out to try to surprise you and fire 8 sword waves. When it lands, it'll fire off 3 sword waves in a row before hiding in the bush again."
chaoText="These guys are kinda cute. I wonder what they do in the bushes all day while they wait."
devText="There was a type of CHAOS enemy that I was going to introduce in Ch18, but during its development, I felt it would be better to push it back to Ch19. A bit for plot, but mostly gameplay related. I felt Ch.18 introduced enough during the facility and this new CHAOS enemy completely changes the dynamics of how the player is able to approach CHAOS enemies as a whole."

if global.gameProgress=4940 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if enemyProg=0 //Wait till player is close enough
    {
      if point_distance(x,y-10,oPlayer1.x,returnPlayerYCenter())<=148 and !collision_line(x,y-10,oPlayer1.x,returnPlayerYCenter(),oSolid,1,1)
      {
        sprite_index=sBushhack_Jump
        bCanTakeDamage=true
        y-=2
        yVel=-6
        var tEffect,tXspd,tNewAttack;
        for(i=0;i<18;i+=1)
        {
          tXspd=random_range(-2.25,2.25)
          tEffect=instance_create(x+random_range(-12,12),y-2-random(16),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sBushLeafParticle; tEffect.newBlend=-1
          tEffect.fadeSpd=0.05; tEffect.followID=-1; tEffect.grav=0.4; tEffect.xSpd=tXspd
          tEffect.ySpd=-1-random(4); tEffect.rotation=tXspd*2
        }
        for(i=0;i<8;i+=1)
        {
          tNewAttack=instance_create(x,y-11,oPassBullet)
          tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower
          tNewAttack.bulletSpeed=4.25; tNewAttack.decayTime=90; tNewAttack.image_yscale=0.75
          tNewAttack.direction=i*45
        }
        enemyProg=1
      }
    }
    else if enemyProg=1 //In air
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
    else if enemyProg=2 //Standard behavior
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      //Fire at player
      throwTime+=1
      if throwTime=20
      {
        image_index=1
        var tNewAttack;
        tNewAttack=instance_create(x+(12*image_xscale),y-11,oPassBullet)
        tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=8.25; tNewAttack.decayTime=-100; tNewAttack.image_yscale=0.75
        tNewAttack.direction=point_direction(x,y-10,oPlayer1.x,returnPlayerYCenter())
      }
      else if throwTime=25 {image_index=2}
      else if throwTime>=30
      {
        image_index=0
        throwTime=0
        throwNum+=1
        if throwNum>=3
        {
          throwNum=0
          var tEffect,tXspd;
          for(i=0;i<6;i+=1)
          {
            tXspd=random_range(-2.25,2.25)
            tEffect=instance_create(x+random_range(-12,12),y-2-random(16),oEffectGrav)
            tEffect.type=2; tEffect.sprite_index=sBushLeafParticle; tEffect.newBlend=-1
            tEffect.fadeSpd=0.05; tEffect.followID=-1; tEffect.grav=0.4; tEffect.xSpd=tXspd
            tEffect.ySpd=-1-random(4); tEffect.rotation=tXspd*2
          }
          sprite_index=sBushhack_Bush
          bCanTakeDamage=false
          enemyProg=3
        }
      }
    }
    else if enemyProg=3 //Slight wait
    {
      throwTime+=1
      if throwTime>=30 {throwTime=0; enemyProg=0}
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if enemyProg=1 {sprite_index=sBushhack_Hack; enemyProg=2}
      yVel=0
    }
    moveTo(xVel,yVel)
  }
  enemyStepEvent()
}
