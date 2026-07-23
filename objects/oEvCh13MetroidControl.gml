#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1

if room=rSamus5_Lv4_A //First map
{
  if global.gameProgress>=2870 and global.gameProgress<=2900 {global.gameProgress=2870}
}
else if room=rSamus5_Lv4_C
{
  if global.gameProgress<=2880
  {
    for(i=0;i<7;i+=1)
    {
      mySpike[i]=instance_create(480,48+(i*16),oStaticSpikeRed)
    }
  }
}
else if room=rSamus5_Lv4_E //First checkpoint
{
  if global.gameProgress<=2940 {global.gameProgress=2910}
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rSamus5_Lv4_B //----------------------------------------------------------------------
{
  if global.gameProgress<=2870 //Clear all Metroids
  {
    if sceneProgress=0
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2880}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_C //----------------------------------------------------------------------
{
  if global.gameProgress<=2880
  {
    if sceneProgress=0 //Clear first 2 Metroids
    {
      if !instance_exists(288769) and !instance_exists(288770)
      {
        with (289416) {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //Check player locations and spawn spikes
    {
      if oPlayer1.x>=672
      {
        for(i=0;i<4;i+=1)
        {
          instance_create(592+(i*16),176,oStaticSpikeRed)
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 //Move spikes and clear next 2 Metroids
    {
      if mySpike[0].x<1008
      {
        for(i=0;i<7;i+=1)
        {
          mySpike[i].x+=0.5
        }
      }
      if !instance_exists(288771) and !instance_exists(288773)
      {
        with (289417) {instance_destroy()}
        with oStaticSpikeRed {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=3 //Clear last Metroid
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2890}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_D //----------------------------------------------------------------------
{
  if global.gameProgress<=2890 //Clear all Metroids
  {
    if sceneProgress=0
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2900}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_F //----------------------------------------------------------------------
{
  if global.gameProgress<=2910 //Clear all Metroids
  {
    if sceneProgress=0
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2920}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_G //----------------------------------------------------------------------
{
  if global.gameProgress<=2920
  {
    if sceneProgress=0 //Check player locations and spawn Metroids
    {
      if oPlayer1.x<=128 and oPlayer1.y>=960
      {
        instance_create(304,1184,oMetMetroid)
        instance_create(384,1152,oMetMetroid)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //Clear all Metroids
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2930}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_H //----------------------------------------------------------------------
{
  if global.gameProgress<=2930 //Clear all Metroids
  {
    if sceneProgress=0
    {
      if !instance_exists(290405) and !instance_exists(290406) and !instance_exists(290407)
      {
        with (291768) {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=784
      {
        var enemyCounter;
        enemyBarrier=instance_create(720,176,oEnemyBarrier); enemyBarrier.image_yscale=3
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMetMetroid)
      {
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=2940
      }
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_J //----------------------------------------------------------------------
{
  if global.gameProgress<=2950
  {
    if sceneProgress=0 //Check player locations and spawn Metroids
    {
      if oPlayer1.x<=240
      {
        var enemyCounter;
        enemyBarrier=instance_create(48,240,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(416,240,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //First wave
    {
      sceneDelay+=1
      if sceneDelay=1 {delaySpawn(240,96,oMetMetroid,0,1,1,0.33)}
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMetMetroid) {sceneProgress+=1}
    }
    else if sceneProgress=3 //Second wave
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        delaySpawn(144,144,oMetMetroid,0,1,1,0.33)
        delaySpawn(336,144,oMetMetroid,0,1,1,0.33)
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if !instance_exists(oMetMetroid) {sceneProgress+=1}
    }
    else if sceneProgress=5 //Third wave
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        delaySpawn(240,96,oMetMetroid,0,1,1,0.33)
        delaySpawn(240,224,oMetMetroid,0,1,1,0.33)
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6
    {
      if !instance_exists(oMetMetroid)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2960
      }
    }
  }
}
else if room=rSamus5_Lv4_L //----------------------------------------------------------------------
{
  if global.gameProgress<=2980 //Clear all Metroids
  {
    if sceneProgress=0
    {
      if !instance_exists(oMetMetroid) {global.gameProgress=2990}
    }
  }
  else
  {
    if global.gameProgress<=3060 {with oMetMetroid {instance_destroy()}}
    with oEventBarrier {instance_destroy()}
  }
}
else if room=rSamus5_Lv4_M //----------------------------------------------------------------------
{
  if global.gameProgress<=2990
  {
    if sceneProgress=0 //Check player locations and spawn Metroids
    {
      if oPlayer1.x<=304
      {
        var enemyCounter;
        enemyBarrier=instance_create(48,304,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(544,304,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //First wave
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        delaySpawn(192,224,oMetMetroid,0,1,1,0.33)
        delaySpawn(416,224,oMetMetroid,0,1,1,0.33)
        delaySpawn(304,80,oMetMetroid,0,1,1,0.33)
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMetMetroid) {sceneProgress+=1}
    }
    else if sceneProgress=3 //Second wave
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        delaySpawn(128,352,oMetMetroid,0,1,1,0.33)
        delaySpawn(432,240,oMetMetroid,0,1,1,0.33)
        delaySpawn(272,64,oMetMetroid,0,1,1,0.33)
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if !instance_exists(oMetMetroid)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=3000
      }
    }
  }
}
