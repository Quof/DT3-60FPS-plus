/*
This script is used when the player takes damage.
argument0: id of the object dealing damage to the player.
*/
var tObjHit;
tObjHit=argument0

if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0
{
  if oPlayer1.starmanTime<=0
  {
    if global.debugInvincible=false
    {
      //inflict status effect
      if (global.location=58 or global.location=76 or global.location=107) and room!=rAbomF //in Gate 6
      {
        if global.activeCharacter=0 //------------------------------ JERRY ------------------------------
        {
          if other.parent="projectile"
          {
            if oPlayer1.attackState=oPlayer1.ACT_BLOCK //player has guard on
            {
              if other.bCanBeBlocked=1 //object can be blocked
              {
                var tParryTiming;
                tParryTiming=4
                for(i=0;i<3;i+=1) //Equipment: Golden Shield
                {
                  if global.equipJerry[i]=31
                  {
                    tParryTiming=5
                    break;
                  }
                }

                if other.bParryOpp=1 and oPlayer1.lastGuardTime<tParryTiming //parry
                {
                  /*playSound(global.snd_MMBulletDeflect,0,1,10000)
                  global.hudGame_WeaponEn[0]+=3
                  if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
                  awardAwesome(50)
                  oPlayer1.extraBulletCheck=3
                  global.recParried+=1
                  blockForceTime=0
                  instance_create(other.x,other.y,oJCBulletKill)
                  with other
                  {
                    if size=1
                    {
                      tEffect=instance_create(x,y,oEffect)
                      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
                      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                      instance_destroy()
                    }
                  }
                  global.stJGame_C[0]=5000
                  var tEffect;
                  tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect); tEffect.image_blend=c_blue; tEffect.image_speed=0.5
                  tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale*/
                }
                else //did not parry
                {
                  playSound(global.snd_MMBulletDeflect,0,1,40000)
                  global.stJGame_C[0]-=other.blockCost
                  with other
                  {
                    if size=1
                    {
                      tEffect=instance_create(x,y,oEffect)
                      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
                      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                      instance_destroy()
                    }
                  }
                  with oPlayer1
                  {
                    if platformCharacterIs(ON_GROUND)
                    {
                      extForceX=2.5*-image_xscale
                      extForceY=-2.5
                      if isCollisionTop(0)=0 {y-=2}
                    }
                    else
                    {
                      extForceX=0.8*-image_xscale
                      if extForceY>-0.8 {extForceY=-0.8}
                    }
                  }
                  var tEffect;
                  tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect)
                  tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale*0.75
                  tEffect.image_yscale=0.75
                }
              }
              else
              {
                if oPlayer1.extraBulletCheck=0 {takeDamage(tObjHit)}
              }
            }
            else {takeDamage(tObjHit)}
          }
          else {takeDamage(tObjHit)}
        }
        else if global.activeCharacter=1 //------------------------------ CLAIRE ------------------------------
        {
          if other.parent!="projectile"
          {
            if global.stJGame_C[0]<=4000
            {
              if oPlayer1.attackState=oPlayer1.ACT_BLOCK //player has guard on
              {
                if other.bCanBeBlocked=1 //object can be blocked
                {
                  var tParryTiming;
                  tParryTiming=4
                  for(i=0;i<3;i+=1) //Equipment: Golden Shield
                  {
                    if global.equipClaire[i]=31
                    {
                      tParryTiming=5
                      break;
                    }
                  }

                  if other.bParryOpp=1 and oPlayer1.lastGuardTime<tParryTiming //parry
                  {
                    /*playSound(global.snd_MMBulletDeflect,0,1,10000)
                    global.hudGame_WeaponEn[0]+=3
                    if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
                    awardAwesome(50)
                    global.recParried+=1
                    blockForceTime=0
                    global.stJGame_C[0]=5000
                    oPlayer1.attackState=0
                    var tEffect;
                    tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect); tEffect.image_blend=c_blue; tEffect.image_speed=0.5
                    tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
                    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale*/
                  }
                  else //did not parry
                  {
                    playSound(global.snd_MMBulletDeflect,0,1,40000)
                    global.stJGame_C[0]-=other.blockCost
                    with oPlayer1
                    {
                      if platformCharacterIs(ON_GROUND)
                      {
                        extForceX=2.5*-image_xscale
                        extForceY=-2.5
                        if isCollisionTop(0)=0 {y-=2}
                      }
                      else
                      {
                        extForceX=0.8*-image_xscale
                        if extForceY>-0.8 {extForceY=-0.8}
                      }
                    }
                    var tEffect;
                    tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect)
                    tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
                    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale*0.75
                    tEffect.image_yscale=0.75
                  }
                }
                else {takeDamage(tObjHit)}
              }
              else {takeDamage(tObjHit)}
            }
          }
          else {takeDamage(tObjHit)}
        }
      }
      else //Standard game hit to player
      {
        if global.bShooter=1
        {
          //Remove weapon
          if global.activeCharacter=0
          {
            oDragoonShip.shotHP_Jerry-=1
            if oDragoonShip.shotHP_Jerry=0
            {
              oDragoonShip.charJerryShot=0
              oDragoonShip.shotType=0
            }
          }
          else if global.activeCharacter=1
          {
            oDragoonShip.shotHP_Claire-=1
            if oDragoonShip.shotHP_Claire=0
            {
              oDragoonShip.charClaireShot=0
              oDragoonShip.shotType=0
            }
          }
          //Remove assist
          if oDragoonShip.multiple>0
          {
            oDragoonShip.multiple-=1
            with oDragoonShip.shipAssist[oDragoonShip.multiple] {instance_destroy()} //Remove instance
            oDragoonShip.shipAssist[oDragoonShip.multiple]=0 //Set assist type to 0 (null value)
          }
        }
        takeDamage(tObjHit)
      }
    }
  }
  else //Starman
  {
    if other.parent="enemy" and other.bCanTakeDamage=true
    {
      oPlayer1.canAirDash=1
      with tObjHit
        enemyDefeat(1,-1)
    }
  }
}
