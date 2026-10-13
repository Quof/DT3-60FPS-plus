/*
This script swaps out Jerry and Claire.
argument0: Who to swap in
-- 0: Jerry
    -- Top Speed (Land):  6.55
    -- Top Speed (Water): 4.55

-- 1: Claire
    -- Top Speed (Land):  7.45
    -- Top Speed (Water): 5.18
*/

var tCharSwap;
tCharSwap=argument0
tEffect=0
if global.alterEquip=1
{
     if global.activeCharacter=0
     {
       for(i=0;i<3;i+=1)
       {
         if global.equipJerry[i]=14
         {
            tEffect=1
         }
       }    
     }
     else
     {
       for(i=0;i<3;i+=1)
       {
         if global.equipClaire[i]=14
         {
            tEffect=1
         }
       }  
     }
 }

 
 if tEffect=1
 {
    charSwapRecover=5 //reduce delay
    if oPlayer1.lastElementHit="NORMAL"
    {
          //regain air options
          if oPlayer1.canAirDash=0 {oHUD.airDashScl=3}
          oPlayer1.canAirDash=1
          
          //Re-enable double jump
          if oPlayer1.doubleJumpCheck=0 {oHUD.doubleJumpScl=2}
          oPlayer1.doubleJumpCheck=1
    }
    if oPlayer1.lastElementHit="PIERCE"
    {
        //recover dash
        oPlayer1.dashEnergy+=2000
            
        if (oPlayer1.dashEnergy > oPlayer1.dashMeterMax)
        {
            oPlayer1.dashEnergy = oPlayer1.dashMeterMax
        }
    }
    if oPlayer1.lastElementHit="ELEMENTAL"
    {
      //recover 1 life
      playSound(global.snd_HealthPickup,0,1,1)

      oPlayer1.life+=1
    

        tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
        tEffect.sprite_index=sHeal; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if oPlayer1.lastElementHit="SHOT"
    {
        //recover ammo for the next character
            playSound(global.snd_AmmoGrab,0,1,1)
            tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
            tEffect.sprite_index=sHeal
            tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
           if tCharSwap=0
           {
               global.hudLink_Arrows[0]+=5
               if global.hudLink_Arrows[0]>global.hudLink_Arrows[1]
                    global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
               
               global.hudLink_BombEn[0]+=50
               if global.hudLink_BombEn[0]>150-(global.skillTree[1]*15)-15
                    global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-15
                   
               global.hudMega_BusterEn[0]+=10 
               if global.hudMega_BusterEn[0]>32
                    global.hudMega_BusterEn[0]=32
               global.hudMega_ShotIceEn[0]+=10 
               if global.hudMega_ShotIceEn[0]>32
                    global.hudMega_ShotIceEn[0]=32
               global.hudMega_GravityEn[0]+=10 
               if global.hudMega_GravityEn[0]>32
                    global.hudMega_GravityEn[0]=32
            }
           if tCharSwap=1
           {
              global.hudBelmont_WeaponEn[0]+=20
              if global.hudBelmont_WeaponEn[0]>global.hudBelmont_WeaponEn[1]
              global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
        
        
              global.hudSamus_Missiles[0]+=5
              if global.hudSamus_Missiles[0]>global.hudSamus_Missiles[1]
              global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
              
              global.hudSamus_CannonEn[0]-=150
              if global.hudSamus_CannonEn[0]<0
                global.hudSamus_CannonEn[0]=0
            }
    }
    
    if oPlayer1.lastElementHit="EXPLOSION"
    {
        //PBAOE
          playSound(global.snd_BombExplode,0,0.92,20000)
          var tExpLight;
          tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=3.5; tExpLight.image_yscale=3.5
          instance_create(x,y-26,oSwitchExplosion)
          
    }
    if oPlayer1.lastElementHit="SPECIAL"
    {
        //shield
        shield = instance_create(x,y-26,oPlayerShieldBubble)
        shield.time = 15
        shield.image_xscale = 2.2
        shield.image_yscale = 2.2
    }
    

 }

oPlayer1.lastElementHit="NONE"
global.activeCharacter=tCharSwap

oPlayer1.dashRecovery=20+(global.skillTree[22]*4)

if global.alterEquip=1
{

      for(i=0;i<3;i+=1)
        if global.equipJerry[i]=12
          oPlayer1.dashRecovery=0

      for(i=0;i<3;i+=1)
        if global.equipClaire[i]=12
          oPlayer1.dashRecovery=0
    
}
frictionWaterXDuck=0.62
if room=rWarshipZ_E3
{
  if global.bBossGallery=0 {oPlayer1.dashRecovery+=35}
  else {oPlayer1.dashRecovery+=11}
}

if tCharSwap=0 //Switch to Jerry
{
  oPlayer1.runAcc=6.6
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
    oPlayer1.jumpBodge60=1.07; oPlayer1.jumpGravComp60=0.5; oPlayer1.doubleJumpBodge60=0.98 //60fps jump corrections for the standard jump
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.87
}
else if tCharSwap=1 //Switch to Claire
{
  oPlayer1.runAcc=7.3
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
    oPlayer1.jumpBodge60=1.07; oPlayer1.jumpGravComp60=0.5; oPlayer1.doubleJumpBodge60=0.98 //60fps jump corrections for the standard jump
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.9
}
else if tCharSwap=2 //Switch to Jeremy
{
  oPlayer1.runAcc=4.5
  oPlayer1.initialJumpAcc=-7
  oPlayer1.jumpTimeTotal=60
  oPlayer1.jumpBodge60=0.99; oPlayer1.jumpGravComp60=0; oPlayer1.doubleJumpBodge60=0.98 //mech jump (-7 / 60): tuned so it matches 30fps at 60 and 120fps
  oPlayer1.frictionDuckingX=0.5
}

       
if global.alterEquip=1
{
    if tCharSwap=0
    {
      for(i=0;i<3;i+=1)
        if global.equipJerry[i]=26
        {
            frictionDuckingX=0.99
            frictionWaterXDuck=0.99
        }
          
    }
    else if tCharSwap=1
    {
      for(i=0;i<3;i+=1)
        if global.equipClaire[i]=26
        {
          frictionWaterXDuck=0.99
          frictionDuckingX=0.99
        }
    }
}
