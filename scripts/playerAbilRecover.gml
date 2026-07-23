/*
This script is called in the player step event.
It is used to recover energy in all the Ability Sets that are inactive.
*/
var tAbilCRecover;
tAbilCRecover=argument0

if global.bNightmareMode=0 //Normal mode
{
  if global.hasAbilToken[1]>=1 and tAbilCRecover=1 //-- 1: Link
  {
    if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
    {
      arrowRecharge+=1
      if arrowRecharge>=100
      {
        arrowRecharge=0
        if arrowDelay>0
        {
          arrowDelay-=2
          if arrowDelay<0 {arrowDelay=0}
        }
        global.hudLink_Arrows[0]+=1
      }
    }
    if global.hudLink_BombEn[0]<120-(global.skillTree[1]*7.5) and oGame.time mod 2=0
      global.hudLink_BombEn[0]+=1
  }
  if global.hasAbilToken[2]>=1 and tAbilCRecover=2 //-- 2: Belmont (Castlevania)
  {
    if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
    {
      if oGame.time mod (42-(global.skillTree[2]*3))=0
        global.hudBelmont_WeaponEn[0]+=1
    }
  }
  if global.hasAbilToken[3]>=1 and tAbilCRecover=3 //-- 3: Mega Man (X Series)
  {
    if global.hudMega_BusterEn[0]<32
    {
      if oGame.time mod 30-global.skillTree[28]=0
        global.hudMega_BusterEn[0]+=1
    }
    if global.hudMega_ShotIceEn[0]<32
    {
      if oGame.time mod 72-round(global.skillTree[28]*1.67)=0
        global.hudMega_ShotIceEn[0]+=1
    }
    if global.hudMega_GravityEn[0]<32
    {
      if oGame.time mod 80-(global.skillTree[28]*2)=0
        global.hudMega_GravityEn[0]+=1
    }
  }
  if global.hasAbilToken[4]>=1 and tAbilCRecover=4 //-- 4: Samus
  {
    if global.hudSamus_CannonEn[0]>0
    {
      if oGame.time mod 2=0
        global.hudSamus_CannonEn[0]-=1
    }
    if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
    {
      missileRecharge+=1
      if missileRecharge>=100
      {
        missileRecharge=0
        if missileDelay>0
        {
          missileDelay-=2
          if missileDelay<0 {missileDelay=0}
        }
        global.hudSamus_Missiles[0]+=1
      }
    }
  }
}
else //Nightmare mode
{
  if global.hasAbilToken[1]>=1 and tAbilCRecover=1 //-- 1: Link
  {
    if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
    {
      arrowRecharge+=1
      if arrowRecharge>=36
      {
        arrowRecharge=0
        if arrowDelay>0
        {
          arrowDelay-=2
          if arrowDelay<0 {arrowDelay=0}
        }
        global.hudLink_Arrows[0]+=1
      }
    }
    if global.hudLink_BombEn[0]<135
      global.hudLink_BombEn[0]+=1
  }
  if global.hasAbilToken[2]>=1 and tAbilCRecover=2 //-- 2: Belmont (Castlevania)
  {
    if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
    {
      if oGame.time mod 12=0
        global.hudBelmont_WeaponEn[0]+=1
    }
  }
  if global.hasAbilToken[3]>=1 and tAbilCRecover=3 //-- 3: Mega Man (X Series)
  {
    if global.hudMega_BusterEn[0]<32
    {
      if oGame.time mod 14=0
        global.hudMega_BusterEn[0]+=1
    }
    if global.hudMega_ShotIceEn[0]<32
    {
      if oGame.time mod 32=0
        global.hudMega_ShotIceEn[0]+=1
    }
    if global.hudMega_GravityEn[0]<32
    {
      if oGame.time mod 35=0
        global.hudMega_GravityEn[0]+=1
    }
  }
  if global.hasAbilToken[4]>=1 and tAbilCRecover=4 //-- 4: Samus
  {
    if global.hudSamus_CannonEn[0]>1
    {
      global.hudSamus_CannonEn[0]-=2
    }
    if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
    {
      missileRecharge+=1
      if missileRecharge>=36
      {
        missileRecharge=0
        if missileDelay>0
        {
          missileDelay-=2
          if missileDelay<0 {missileDelay=0}
        }
        global.hudSamus_Missiles[0]+=1
      }
    }
  }
}
