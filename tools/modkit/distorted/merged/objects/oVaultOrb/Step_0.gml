//color zone change (added): follows the option right away (it can be changed from the pause menu)
if myColor>=1 and myColor<=4 and baseColor!=global.czColor[myColor]
{
  if image_blend=baseColor {image_blend=global.czColor[myColor]}
  baseColor=global.czColor[myColor]
}
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if init=0
      {
        visible=1
        image_index+=0.2*gDeltaTime
        if image_index>=7
        {
          image_index=7
          bCanTakeDamage=true
          bCanDealDamage=true
          init=1
        }
      }
      else if init=1
      {
        revertTime-=1*gDeltaTime
        if revertTime=0
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=2
          }
          stunResist=50
        }

        teleTime+=1*gDeltaTime
        if teleProg=0 //Normal behavior
        {
          _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())

          findTargetX=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
          if findTargetX<160 {_speed=runAcc}
          else {_speed=runAcc*1.2}

          if teleTime>=teleWait //spsp ns, used to be hard 50
          {
            _speed=0
            teleTime=0; teleProg+=1
          }
        }
        else if teleProg=1 //Wait - Teleport
        {
          if teleTime mod 2=0 and teleTime<=20 //Flash
          {
            if image_blend=baseColor {image_blend=c_purple}
            else {image_blend=baseColor}
          }
          if teleTime=17 //Warn
          {
            tEffect=instance_create(x,y,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=1
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          else if teleTime=21 {image_blend=baseColor} //Reset color
          else if teleTime>=25 //Teleport
          {
            _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
            for(i=0;i<10;i+=1)
            {
              tEffect=instance_create(x+lengthdir_x(i*8,_direction),y+lengthdir_y(i*8,_direction),oEffect)
              tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=1-(i*0.09)
              tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
              tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
            }
            x+=lengthdir_x(80,_direction)
            y+=lengthdir_y(80,_direction)
            teleTime=0; teleProg+=1
          }
        }
        else if teleProg=2 //Teleport
        {
          if teleTime>=20 //{teleTime=irandom(10); teleProg=0} //spsp ns
          {
            if teleWait>25 {teleWait-=10}
            teleProg=0
            teleTime=0
          }
        }
      }
    }
    else {_speed=0}
  }
  else if life<=0
  {
    for(i=0;i<10;i+=1)
    {
      tEffect=instance_create(x+random_range(-22,22),y-1-random(21),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
  enemyStepEvent()
}
else {_speed=0}
correctSpeedDirection(self)
if room=rYellowRide and x>5264 {life=0}     //spsp
