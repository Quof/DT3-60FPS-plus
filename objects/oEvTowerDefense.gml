#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
explainMenu=0
global.gamePaused=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if explainMenu=0 //Show explain menu during first TD battle
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=10
    {
      if global.gameProgress<=3890
      {
        var tMyRules;
        tMyRules=instance_create(0,0,oTD_ExplainMenu)
        tMyRules.type=1
        sceneDelay=0; sceneProgress+=1
      }
      else
      {
        global.gamePaused=false
        explainMenu=1
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if explainMenu=1 //TD sequences
{
  if global.gamePaused=false
  {
    if TD_Difficulty=1 //------------------------------ First story TD Battle ------------------------------
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=1
        swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=10; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=56; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=56; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1216,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=10; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=150; swarmSpawn.spawnMax=2; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1968,240,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=1; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,240,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=8; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=18; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1216,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=10; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=40; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1216,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=150; swarmSpawn.spawnMax=6; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=52; swarmSpawn.spawnMax=18; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=52; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=52; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          swarmSpawn=instance_create(1216,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=6; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1968,240,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=2; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 1 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1
          if sceneDelay=10
          {
            if global.gameProgress=3880 {global.gameProgress=3890}
            else {sceneDelay=0; explainMenu=2}
          }
        }
      }
    }
    else if TD_Difficulty=2 //------------------------------ Second story TD Battle ------------------------------
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
        swarmSpawn.spawnFreq=52; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1968,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1792,432,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=10; swarmSpawn.myDir=180
          swarmSpawn=instance_create(1968,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=8; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,432,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=100; swarmSpawn.spawnMax=6; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1968,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=1; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=1; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1968,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=8; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1264,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,432,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=110; swarmSpawn.spawnMax=10; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1264,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=18; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,432,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=10; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1264,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=32; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1936,544,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,432,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1968,128,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=1; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 2 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1
          if sceneDelay=10
          {
            if global.gameProgress=3900 {global.gameProgress=3910}
            else {sceneDelay=0; explainMenu=2}
          }
        }
      }
    }
    else if TD_Difficulty=3 //------------------------------ Optional 1 ------------------------------
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=68; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=18; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=64; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=30; swarmSpawn.spawnMax=10; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=35; swarmSpawn.spawnMax=14; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1680,464,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=4; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=3; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1680,464,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=45; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=55; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=18; swarmSpawn.spawnMax=55; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=5; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 3 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=3 {global.gameOptTowerDef=4}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
    else if TD_Difficulty=4 //------------------------------ Optional 2 ------------------------------
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
        swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
        swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=20; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=160; swarmSpawn.spawnMax=3; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=160; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=58; swarmSpawn.spawnMax=26; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=58; swarmSpawn.spawnMax=26; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=22; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=22; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=65; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=65; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=20; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=210; swarmSpawn.spawnMax=4; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=210; swarmSpawn.spawnMax=4; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 4 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=4 {global.gameOptTowerDef=5}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
    else if TD_Difficulty=5 //------------------------------ Optional 3 ------------------------------
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=55; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
        swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=65; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=65; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=180; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=180; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=45; swarmSpawn.spawnMax=32; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=12; swarmSpawn.spawnMax=100; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=50; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 5 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=5 {global.gameOptTowerDef=6}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
  }
}
else if explainMenu=2 //End during non-story battles or refights
{
  if global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      msgCreate(0,0,"Jeremy","Nice job there. I'll teleport you back to Central City.",0,2,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay>=80
    {
      global.activeAbility[0]=1
      global.activeAbility[1]=1
      global.newMapX=1200
      global.newMapY=288
      writeToPlayerGlobals()
      room_goto(rCCity_NorthA)
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oTD_HUD.tdStat_Wave+=1
with oTD_FlagPole
{
  if oTD_HUD.tdStat_Wave=1 {waveCountdown=1800}
  else {waveCountdown=900}
  bWaveStart=0
}
