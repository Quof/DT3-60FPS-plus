/*
This script is used to find the amount of Exp to award to the used ability
use: findAbilExp(pWeapon_id,user_level,target_level,exExp)

argument0: Player Weapon id
argument1: Ability level
argument2: Target level
argument3: Extra Exp
*/
var tPWepId,tAbilLv,tTargetLv,tXpAwarded,tXpAdj;
tPWepId=argument0
tAbilLv=argument1
tTargetLv=argument2
tXpAdj=argument3

tXpAwarded=tTargetLv-(tAbilLv*3)
if tXpAdj=1 {tXpAwarded=floor(tXpAwarded/2.3)}
else if tXpAdj=2 {tXpAwarded=floor(tXpAwarded*2.1)}
else if tXpAdj=3 {tXpAwarded=floor(tXpAwarded*3.2)}
else if tXpAdj=10 {tXpAwarded=floor(tXpAwarded/3)}
else if tXpAdj=11 {tXpAwarded=floor(floor(tXpAwarded/2.3)/3)}
else if tXpAdj=12 {tXpAwarded=floor(floor(tXpAwarded*2.1)/3)}
else if tXpAdj=13 {tXpAwarded=floor(floor(tXpAwarded*3.2)/3)}

if global.difficulty=1 {tXpAwarded=floor(tXpAwarded/2)} //Gain half weapon exp if on easy mode
if tXpAwarded<1 {tXpAwarded=1}

if global.difficulty=1 and global.currentBoss!="" {tXpAwarded=0}

if tXpAwarded>0
{
  var tXpShow;
  /*tXpShow=instance_create(round(oPlayer1.x),oPlayer1.y-48,oDamageNotice)
  tXpShow.damageValue=tXpAwarded
  tXpShow.damageColor=c_white*/

  //find which ability was used
  if tPWepId.weaponTag=0
  {
    if global.stLink_Sword[0]<10
    {
      global.stLink_Sword[1]+=tXpAwarded
      if global.stLink_Sword[1]>=global.stLink_Sword[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stLink_Sword[1]-=global.stLink_Sword[2]
        global.stLink_Sword[0]+=1
        if global.stLink_Sword[0]=1 {global.stLink_Sword[2]=1500}
        else if global.stLink_Sword[0]=2 {global.stLink_Sword[2]=2300}
        else if global.stLink_Sword[0]=3 {global.stLink_Sword[2]=3600}
        else if global.stLink_Sword[0]=4 {global.stLink_Sword[2]=5000}
        else if global.stLink_Sword[0]=5 {global.stLink_Sword[2]=8000}
        else if global.stLink_Sword[0]=6 {global.stLink_Sword[2]=12000}
        else if global.stLink_Sword[0]=7 {global.stLink_Sword[2]=18000}
        else if global.stLink_Sword[0]=8 {global.stLink_Sword[2]=25000}
        else if global.stLink_Sword[0]=9 {global.stLink_Sword[2]=40000; global.stLink_Sword[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=1
  {
    if global.stLink_Arrow[0]<10
    {
      global.stLink_Arrow[1]+=tXpAwarded
      if global.stLink_Arrow[1]>=global.stLink_Arrow[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stLink_Arrow[1]-=global.stLink_Arrow[2]
        global.stLink_Arrow[0]+=1
        if global.stLink_Arrow[0]=1 {global.stLink_Arrow[2]=1200}
        else if global.stLink_Arrow[0]=2 {global.stLink_Arrow[2]=1800}
        else if global.stLink_Arrow[0]=3 {global.stLink_Arrow[2]=2600}
        else if global.stLink_Arrow[0]=4 {global.stLink_Arrow[2]=3800}
        else if global.stLink_Arrow[0]=5 {global.stLink_Arrow[2]=5200}
        else if global.stLink_Arrow[0]=6 {global.stLink_Arrow[2]=8000}
        else if global.stLink_Arrow[0]=7 {global.stLink_Arrow[2]=12500}
        else if global.stLink_Arrow[0]=8 {global.stLink_Arrow[2]=19000}
        else if global.stLink_Arrow[0]=9 {global.stLink_Arrow[2]=30000; global.stLink_Arrow[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=2
  {
    if global.stLink_Bomb[0]<10
    {
      global.stLink_Bomb[1]+=tXpAwarded
      if global.stLink_Bomb[1]>=global.stLink_Bomb[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stLink_Bomb[1]-=global.stLink_Bomb[2]
        global.stLink_Bomb[0]+=1
        if global.stLink_Bomb[0]=1 {global.stLink_Bomb[2]=450}
        else if global.stLink_Bomb[0]=2 {global.stLink_Bomb[2]=700}
        else if global.stLink_Bomb[0]=3 {global.stLink_Bomb[2]=1100}
        else if global.stLink_Bomb[0]=4 {global.stLink_Bomb[2]=1600}
        else if global.stLink_Bomb[0]=5 {global.stLink_Bomb[2]=2400}
        else if global.stLink_Bomb[0]=6 {global.stLink_Bomb[2]=3500}
        else if global.stLink_Bomb[0]=7 {global.stLink_Bomb[2]=4800}
        else if global.stLink_Bomb[0]=8 {global.stLink_Bomb[2]=7600}
        else if global.stLink_Bomb[0]=9 {global.stLink_Bomb[2]=11000; global.stLink_Bomb[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=10
  {
    if global.stMega_Buster[0]<10
    {
      global.stMega_Buster[1]+=tXpAwarded
      if global.stMega_Buster[1]>=global.stMega_Buster[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stMega_Buster[1]-=global.stMega_Buster[2]
        global.stMega_Buster[0]+=1
        if global.stMega_Buster[0]=1 {global.stMega_Buster[2]=1700}
        else if global.stMega_Buster[0]=2 {global.stMega_Buster[2]=2500}
        else if global.stMega_Buster[0]=3 {global.stMega_Buster[2]=3900}
        else if global.stMega_Buster[0]=4 {global.stMega_Buster[2]=5600}
        else if global.stMega_Buster[0]=5 {global.stMega_Buster[2]=8900}
        else if global.stMega_Buster[0]=6 {global.stMega_Buster[2]=13000}
        else if global.stMega_Buster[0]=7 {global.stMega_Buster[2]=20000}
        else if global.stMega_Buster[0]=8 {global.stMega_Buster[2]=30000}
        else if global.stMega_Buster[0]=9 {global.stMega_Buster[2]=42000; global.stMega_Buster[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=11
  {
    if global.stMega_ShotIce[0]<10
    {
      global.stMega_ShotIce[1]+=tXpAwarded
      if global.stMega_ShotIce[1]>=global.stMega_ShotIce[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stMega_ShotIce[1]-=global.stMega_ShotIce[2]
        global.stMega_ShotIce[0]+=1
        if global.stMega_ShotIce[0]=1 {global.stMega_ShotIce[2]=1000}
        else if global.stMega_ShotIce[0]=2 {global.stMega_ShotIce[2]=1600}
        else if global.stMega_ShotIce[0]=3 {global.stMega_ShotIce[2]=2300}
        else if global.stMega_ShotIce[0]=4 {global.stMega_ShotIce[2]=3200}
        else if global.stMega_ShotIce[0]=5 {global.stMega_ShotIce[2]=4900}
        else if global.stMega_ShotIce[0]=6 {global.stMega_ShotIce[2]=7500}
        else if global.stMega_ShotIce[0]=7 {global.stMega_ShotIce[2]=12000}
        else if global.stMega_ShotIce[0]=8 {global.stMega_ShotIce[2]=18000}
        else if global.stMega_ShotIce[0]=9 {global.stMega_ShotIce[2]=28000; global.stMega_ShotIce[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=12
  {
    if global.stMega_Gravity[0]<10
    {
      global.stMega_Gravity[1]+=tXpAwarded
      if global.stMega_Gravity[1]>=global.stMega_Gravity[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stMega_Gravity[1]-=global.stMega_Gravity[2]
        global.stMega_Gravity[0]+=1
        if global.stMega_Gravity[0]=1 {global.stMega_Gravity[2]=1000}
        else if global.stMega_Gravity[0]=2 {global.stMega_Gravity[2]=1600}
        else if global.stMega_Gravity[0]=3 {global.stMega_Gravity[2]=2300}
        else if global.stMega_Gravity[0]=4 {global.stMega_Gravity[2]=3200}
        else if global.stMega_Gravity[0]=5 {global.stMega_Gravity[2]=4900}
        else if global.stMega_Gravity[0]=6 {global.stMega_Gravity[2]=7500}
        else if global.stMega_Gravity[0]=7 {global.stMega_Gravity[2]=12000}
        else if global.stMega_Gravity[0]=8 {global.stMega_Gravity[2]=18000}
        else if global.stMega_Gravity[0]=9 {global.stMega_Gravity[2]=28000; global.stMega_Gravity[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=20
  {
    if global.stJGame_A[0]<10
    {
      global.stJGame_A[1]+=tXpAwarded
      if global.stJGame_A[1]>=global.stJGame_A[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stJGame_A[1]-=global.stJGame_A[2]
        global.stJGame_A[0]+=1
        if global.stJGame_A[0]=1 {global.stJGame_A[2]=1000}
        else if global.stJGame_A[0]=2 {global.stJGame_A[2]=1500}
        else if global.stJGame_A[0]=3 {global.stJGame_A[2]=2100}
        else if global.stJGame_A[0]=4 {global.stJGame_A[2]=2900}
        else if global.stJGame_A[0]=5 {global.stJGame_A[2]=4300}
        else if global.stJGame_A[0]=6 {global.stJGame_A[2]=7000}
        else if global.stJGame_A[0]=7 {global.stJGame_A[2]=10000}
        else if global.stJGame_A[0]=8 {global.stJGame_A[2]=20000}
        else if global.stJGame_A[0]=9 {global.stJGame_A[2]=21000; global.stJGame_A[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=21
  {
    if global.stJGame_B[0]<10
    {
      global.stJGame_B[1]+=tXpAwarded
      if global.stJGame_B[1]>=global.stJGame_B[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stJGame_B[1]-=global.stJGame_B[2]
        global.stJGame_B[0]+=1
        if global.stJGame_B[0]=1 {global.stJGame_B[2]=1000}
        else if global.stJGame_B[0]=2 {global.stJGame_B[2]=1500}
        else if global.stJGame_B[0]=3 {global.stJGame_B[2]=2100}
        else if global.stJGame_B[0]=4 {global.stJGame_B[2]=2900}
        else if global.stJGame_B[0]=5 {global.stJGame_B[2]=4300}
        else if global.stJGame_B[0]=6 {global.stJGame_B[2]=7000}
        else if global.stJGame_B[0]=7 {global.stJGame_B[2]=10000}
        else if global.stJGame_B[0]=8 {global.stJGame_B[2]=20000}
        else if global.stJGame_B[0]=9 {global.stJGame_B[2]=21000; global.stJGame_B[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=22
  {
    if global.stJGame_C[0]<10
    {
      global.stJGame_C[1]+=tXpAwarded
      if global.stJGame_C[1]>=global.stJGame_C[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stJGame_C[1]-=global.stJGame_C[2]
        global.stJGame_C[0]+=1
        if global.stJGame_C[0]=1 {global.stJGame_C[2]=1000}
        else if global.stJGame_C[0]=2 {global.stJGame_C[2]=1500}
        else if global.stJGame_C[0]=3 {global.stJGame_C[2]=2100}
        else if global.stJGame_C[0]=4 {global.stJGame_C[2]=2900}
        else if global.stJGame_C[0]=5 {global.stJGame_C[2]=4300}
        else if global.stJGame_C[0]=6 {global.stJGame_C[2]=7000}
        else if global.stJGame_C[0]=7 {global.stJGame_C[2]=10000}
        else if global.stJGame_C[0]=8 {global.stJGame_C[2]=20000}
        else if global.stJGame_C[0]=9 {global.stJGame_C[2]=21000; global.stJGame_C[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=30
  {
    if global.stBelmont_HairWhip[0]<10
    {
      global.stBelmont_HairWhip[1]+=tXpAwarded
      if global.stBelmont_HairWhip[1]>=global.stBelmont_HairWhip[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stBelmont_HairWhip[1]-=global.stBelmont_HairWhip[2]
        global.stBelmont_HairWhip[0]+=1
        if global.stBelmont_HairWhip[0]=1 {global.stBelmont_HairWhip[2]=1500}
        else if global.stBelmont_HairWhip[0]=2 {global.stBelmont_HairWhip[2]=2300}
        else if global.stBelmont_HairWhip[0]=3 {global.stBelmont_HairWhip[2]=3600}
        else if global.stBelmont_HairWhip[0]=4 {global.stBelmont_HairWhip[2]=5000}
        else if global.stBelmont_HairWhip[0]=5 {global.stBelmont_HairWhip[2]=8000}
        else if global.stBelmont_HairWhip[0]=6 {global.stBelmont_HairWhip[2]=12000}
        else if global.stBelmont_HairWhip[0]=7 {global.stBelmont_HairWhip[2]=18000}
        else if global.stBelmont_HairWhip[0]=8 {global.stBelmont_HairWhip[2]=25000}
        else if global.stBelmont_HairWhip[0]=9 {global.stBelmont_HairWhip[2]=40000; global.stBelmont_HairWhip[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=31
  {
    if global.stBelmont_Dagger[0]<10
    {
      global.stBelmont_Dagger[1]+=tXpAwarded
      if global.stBelmont_Dagger[1]>=global.stBelmont_Dagger[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stBelmont_Dagger[1]-=global.stBelmont_Dagger[2]
        global.stBelmont_Dagger[0]+=1
        if global.stBelmont_Dagger[0]=1 {global.stBelmont_Dagger[2]=1200}
        else if global.stBelmont_Dagger[0]=2 {global.stBelmont_Dagger[2]=1800}
        else if global.stBelmont_Dagger[0]=3 {global.stBelmont_Dagger[2]=2600}
        else if global.stBelmont_Dagger[0]=4 {global.stBelmont_Dagger[2]=3800}
        else if global.stBelmont_Dagger[0]=5 {global.stBelmont_Dagger[2]=5200}
        else if global.stBelmont_Dagger[0]=6 {global.stBelmont_Dagger[2]=8000}
        else if global.stBelmont_Dagger[0]=7 {global.stBelmont_Dagger[2]=12500}
        else if global.stBelmont_Dagger[0]=8 {global.stBelmont_Dagger[2]=19000}
        else if global.stBelmont_Dagger[0]=9 {global.stBelmont_Dagger[2]=30000; global.stBelmont_Dagger[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=32
  {
    if global.stBelmont_Holywater[0]<10
    {
      global.stBelmont_Holywater[1]+=tXpAwarded
      if global.stBelmont_Holywater[1]>=global.stBelmont_Holywater[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stBelmont_Holywater[1]-=global.stBelmont_Holywater[2]
        global.stBelmont_Holywater[0]+=1
        if global.stBelmont_Holywater[0]=1 {global.stBelmont_Holywater[2]=900}
        else if global.stBelmont_Holywater[0]=2 {global.stBelmont_Holywater[2]=1500}
        else if global.stBelmont_Holywater[0]=3 {global.stBelmont_Holywater[2]=2200}
        else if global.stBelmont_Holywater[0]=4 {global.stBelmont_Holywater[2]=3200}
        else if global.stBelmont_Holywater[0]=5 {global.stBelmont_Holywater[2]=4600}
        else if global.stBelmont_Holywater[0]=6 {global.stBelmont_Holywater[2]=7000}
        else if global.stBelmont_Holywater[0]=7 {global.stBelmont_Holywater[2]=11000}
        else if global.stBelmont_Holywater[0]=8 {global.stBelmont_Holywater[2]=17000}
        else if global.stBelmont_Holywater[0]=9 {global.stBelmont_Holywater[2]=26000; global.stBelmont_Holywater[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=40
  {
    if global.stSamus_Cannon[0]<10
    {
      global.stSamus_Cannon[1]+=tXpAwarded
      if global.stSamus_Cannon[1]>=global.stSamus_Cannon[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stSamus_Cannon[1]-=global.stSamus_Cannon[2]
        global.stSamus_Cannon[0]+=1
        if global.stSamus_Cannon[0]=1 {global.stSamus_Cannon[2]=1700}
        else if global.stSamus_Cannon[0]=2 {global.stSamus_Cannon[2]=2500}
        else if global.stSamus_Cannon[0]=3 {global.stSamus_Cannon[2]=3900}
        else if global.stSamus_Cannon[0]=4 {global.stSamus_Cannon[2]=5600}
        else if global.stSamus_Cannon[0]=5 {global.stSamus_Cannon[2]=8900}
        else if global.stSamus_Cannon[0]=6 {global.stSamus_Cannon[2]=13000}
        else if global.stSamus_Cannon[0]=7 {global.stSamus_Cannon[2]=20000}
        else if global.stSamus_Cannon[0]=8 {global.stSamus_Cannon[2]=30000}
        else if global.stSamus_Cannon[0]=9 {global.stSamus_Cannon[2]=42000; global.stSamus_Cannon[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=41
  {
    if global.stSamus_Missile[0]<10
    {
      global.stSamus_Missile[1]+=tXpAwarded
      if global.stSamus_Missile[1]>=global.stSamus_Missile[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stSamus_Missile[1]-=global.stSamus_Missile[2]
        global.stSamus_Missile[0]+=1
        if global.stSamus_Missile[0]=1 {global.stSamus_Missile[2]=1000}
        else if global.stSamus_Missile[0]=2 {global.stSamus_Missile[2]=1600}
        else if global.stSamus_Missile[0]=3 {global.stSamus_Missile[2]=2300}
        else if global.stSamus_Missile[0]=4 {global.stSamus_Missile[2]=3200}
        else if global.stSamus_Missile[0]=5 {global.stSamus_Missile[2]=4900}
        else if global.stSamus_Missile[0]=6 {global.stSamus_Missile[2]=7500}
        else if global.stSamus_Missile[0]=7 {global.stSamus_Missile[2]=12000}
        else if global.stSamus_Missile[0]=8 {global.stSamus_Missile[2]=18000}
        else if global.stSamus_Missile[0]=9 {global.stSamus_Missile[2]=28000; global.stSamus_Missile[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=42
  {
    if global.stSamus_Bomb[0]<10
    {
      global.stSamus_Bomb[1]+=tXpAwarded
      if global.stSamus_Bomb[1]>=global.stSamus_Bomb[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stSamus_Bomb[1]-=global.stSamus_Bomb[2]
        global.stSamus_Bomb[0]+=1
        if global.stSamus_Bomb[0]=1 {global.stSamus_Bomb[2]=450}
        else if global.stSamus_Bomb[0]=2 {global.stSamus_Bomb[2]=700}
        else if global.stSamus_Bomb[0]=3 {global.stSamus_Bomb[2]=1100}
        else if global.stSamus_Bomb[0]=4 {global.stSamus_Bomb[2]=1600}
        else if global.stSamus_Bomb[0]=5 {global.stSamus_Bomb[2]=2400}
        else if global.stSamus_Bomb[0]=6 {global.stSamus_Bomb[2]=3500}
        else if global.stSamus_Bomb[0]=7 {global.stSamus_Bomb[2]=4800}
        else if global.stSamus_Bomb[0]=8 {global.stSamus_Bomb[2]=7600}
        else if global.stSamus_Bomb[0]=9 {global.stSamus_Bomb[2]=11000; global.stSamus_Bomb[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=50
  {
    if global.stCGame_A[0]<10
    {
      global.stCGame_A[1]+=tXpAwarded
      if global.stCGame_A[1]>=global.stCGame_A[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stCGame_A[1]-=global.stCGame_A[2]
        global.stCGame_A[0]+=1
        if global.stCGame_A[0]=1 {global.stCGame_A[2]=700}
        else if global.stCGame_A[0]=2 {global.stCGame_A[2]=1300}
        else if global.stCGame_A[0]=3 {global.stCGame_A[2]=1900}
        else if global.stCGame_A[0]=4 {global.stCGame_A[2]=2600}
        else if global.stCGame_A[0]=5 {global.stCGame_A[2]=3900}
        else if global.stCGame_A[0]=6 {global.stCGame_A[2]=5400}
        else if global.stCGame_A[0]=7 {global.stCGame_A[2]=8000}
        else if global.stCGame_A[0]=8 {global.stCGame_A[2]=12000}
        else if global.stCGame_A[0]=9 {global.stCGame_A[2]=18000; global.stCGame_A[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=51
  {
    if global.stCGame_B[0]<10
    {
      global.stCGame_B[1]+=tXpAwarded
      if global.stCGame_B[1]>=global.stCGame_B[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stCGame_B[1]-=global.stCGame_B[2]
        global.stCGame_B[0]+=1
        if global.stCGame_B[0]=1 {global.stCGame_B[2]=1000}
        else if global.stCGame_B[0]=2 {global.stCGame_B[2]=1500}
        else if global.stCGame_B[0]=3 {global.stCGame_B[2]=2100}
        else if global.stCGame_B[0]=4 {global.stCGame_B[2]=2900}
        else if global.stCGame_B[0]=5 {global.stCGame_B[2]=4300}
        else if global.stCGame_B[0]=6 {global.stCGame_B[2]=7000}
        else if global.stCGame_B[0]=7 {global.stCGame_B[2]=10000}
        else if global.stCGame_B[0]=8 {global.stCGame_B[2]=15000}
        else if global.stCGame_B[0]=9 {global.stCGame_B[2]=21000; global.stCGame_B[1]=0}
      }
    }
  }
  else if tPWepId.weaponTag=52
  {
    if global.stCGame_C[0]<10
    {
      global.stCGame_C[1]+=tXpAwarded
      if global.stCGame_C[1]>=global.stCGame_C[2]
      {
        instance_create(oPlayer1.x,oPlayer1.y-42,oSkillUpNotice)
        global.stCGame_C[1]-=global.stCGame_C[2]
        global.stCGame_C[0]+=1
        if global.stCGame_C[0]=1 {global.stCGame_C[2]=1000}
        else if global.stCGame_C[0]=2 {global.stCGame_C[2]=1500}
        else if global.stCGame_C[0]=3 {global.stCGame_C[2]=2100}
        else if global.stCGame_C[0]=4 {global.stCGame_C[2]=2900}
        else if global.stCGame_C[0]=5 {global.stCGame_C[2]=4300}
        else if global.stCGame_C[0]=6 {global.stCGame_C[2]=7000}
        else if global.stCGame_C[0]=7 {global.stCGame_C[2]=10000}
        else if global.stCGame_C[0]=8 {global.stCGame_C[2]=15000}
        else if global.stCGame_C[0]=9 {global.stCGame_C[2]=21000; global.stCGame_C[1]=0}
      }
    }
  }
}
return tXpAwarded
