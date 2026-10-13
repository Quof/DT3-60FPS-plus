event_inherited()
instance_create(x,y,oBombBWave)
image_speed=0.75
damageType="EXPLOSION"
if global.TrueEnabled=1 and global.LinkBombTrue=1
{
damageType="TRUE"
}
weaponTag=2
atkLv=global.stLink_Bomb[0]
tAlterOmen=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
    }
}
if tAlterOmen=0
{
//atkPower=220+(global.stLink_Bomb[0]*4)+(global.skillTree[9]*2)
atkPower=220+(scrOmenLv(global.stLink_Bomb[0])*4)+(global.skillTree[9]*2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=220+((global.stLink_Bomb[0]-10)*4)
}

atkPower=weaponDmgMod(0,atkPower)
if tAlterOmen=0
{
//stunTime=22+round(global.stLink_Bomb[0]/2)
stunTime=22+round(scrOmenLv(global.stLink_Bomb[0])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
stunTime=22+round((global.stLink_Bomb[0])-10/2)
}
bCanPierce=1

if tAlterOmen=0
{
image_xscale=1+(global.linkBombUpgrade*0.04)
image_yscale=1+(global.linkBombUpgrade*0.04)
}
else
{
image_xscale=1
image_yscale=1
}


tSpawnBomb = 0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=20 {tSpawnBomb=1}
    }
}
if tSpawnBomb = 1
{
    item = global.amuletItem
    if item=0
    {
        //useless data
        enemy = instance_create(x,y,oUselessData);
        enemy.armor = 1
        enemy.bShowHealthBar=false
        enemy.bShowDamagePopout=false
    }
    else if item=1
    {
        //grapple point
        enemy = instance_create(x,y,oStrikeChainPoint);
    }
    else if item=2
    {
        //bouncer
        enemy = instance_create(x,y,oSmallJumper);
    }
    else if item=3
    {
        //cannon
        enemy = instance_create(x,y,oTravelCannon);
        enemy.launchDuration = 30
        enemy.image_xscale = oPlayer1.image_xscale
    }
    else if item=4
    {
        //little red propeller guy mario enemy
        enemy = instance_create(x,y,oToady);
        enemy.armor = 1
        enemy.bShowHealthBar=false
        enemy.bShowDamagePopout=false
    }
    else if item=5
    {
        //rocketeer
        enemy = instance_create(x,y,oCHAOS_Rocketeer);
        enemy.armor = 1
    }
}

if global.alterEquip=1
{
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=15 {weakenTime=90} //Equipment: Bomber Jacket
      }
    }
}

if global.alterEquip=1
{
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=24
        {
            image_xscale*=2
            image_yscale*=2
            atkPower*=0.7
        }
      }
    }
}
