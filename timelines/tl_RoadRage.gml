#define 60
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<5;i+=1)
{
  tNewEnemy=instance_create(room_width+16+(i*24),96,oCHAOS_SmallBot)
}
#define 180
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<5;i+=1)
{
  tNewEnemy=instance_create(room_width+16+(i*24),48,oCHAOS_SmallBot)
}
#define 320
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(room_width+16+(i*32),48,oCHAOS_SmallBot)
}
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(room_width+16+(i*32),96,oCHAOS_SmallBot)
}
#define 420
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,96+(64*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=15+(10*i)
}

for(i=0;i<2;i+=1)
{
  tNewBGO=instance_create(-16,64+(64*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_HeavyGunner; tNewBGO.moveSpd=6
}
#define 570
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,64+(64*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=15+(10*i)
}

for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(room_width+16+(i*24),176,oCHAOS_SmallBot)
}
#define 720
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(-16-(i*24),96,oCHAOS_SmallBot)
  tNewEnemy=instance_create(room_width+16+(i*24),144,oCHAOS_SmallBot)
}
#define 810
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(-16-(i*24),144,oCHAOS_SmallBot)
  tNewEnemy=instance_create(room_width+16+(i*24),96,oCHAOS_SmallBot)
}
#define 940
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(room_width+48,128,oCHAOS_FishBot)
tNewEnemy.yThres=160
#define 1020
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<5;i+=1)
{
  tNewEnemy=instance_create(-16-(i*24),96,oCHAOS_SmallBot)
}
#define 1100
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0

for(i=0;i<4;i+=1)
{
  tNewBGO=instance_create(-16,48+(48*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_SmallBot; tNewBGO.moveSpd=6
}
#define 1210
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  tNewEnemy=instance_create(room_width+16,48+(48*i),oCHAOS_SmallBot)
}
#define 1290
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(room_width+32,96,oCHAOS_HeavyGunner)
tNewEnemy.stopTime=30
#define 1420
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,128+(64*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=30+(20*i)
}
#define 1440
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewBGO=instance_create(-16,96+(96*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_FishBot; tNewBGO.moveSpd=3
}
#define 1470
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0
#define 1520
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(-16-(i*24),128,oCHAOS_SmallBot)
}
#define 1600
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+48,96+(96*i),oCHAOS_FishBot)
  tNewEnemy.yThres=16
}
#define 1700
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0
#define 1790
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  tNewBGO=instance_create(-16,48+(48*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_SmallBot; tNewBGO.moveSpd=6
}
#define 1870
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  tNewEnemy=instance_create(room_width+16,48+(48*i),oCHAOS_SmallBot)
}
#define 1990
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,144,oCHAOS_FishBot)
tNewEnemy.yThres=16

for(i=0;i<4;i+=1)
{
  tNewBGO=instance_create(-16,48+(48*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_SmallBot; tNewBGO.moveSpd=6
}
#define 2080
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  tNewEnemy=instance_create(room_width+16,48+(48*i),oCHAOS_SmallBot)
}

for(i=0;i<2;i+=1)
{
  tNewBGO=instance_create(-16,112+(72*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_HeavyGunner; tNewBGO.moveSpd=4
}
#define 2200
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,112+(72*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=30-(10*i)
}
#define 2260
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,144,oCHAOS_FishBot)
tNewEnemy.yThres=16

for(i=0;i<2;i+=1)
{
  tNewBGO=instance_create(-16,96+(96*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_HeavyGunner; tNewBGO.moveSpd=4
}
#define 2390
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,96+(96*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=30-(10*i)
}
#define 2440
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0

for(i=0;i<4;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    tNewBGO=instance_create(-16-(24*ii),48+(48*i),oTruckSec_BG)
    tNewBGO.sprite_index=sCHAOS_SmallBot; tNewBGO.moveSpd=6
  }
}
#define 2530
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewBGO=instance_create(-16,128,oTruckSec_BG)
tNewBGO.sprite_index=sCHAOS_FishBot; tNewBGO.moveSpd=2.5
#define 2690
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    tNewEnemy=instance_create(room_width+16+(24*ii),48+(48*i),oCHAOS_SmallBot)
  }
}
#define 2800
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(room_width+48,80,oCHAOS_FishBot)
tNewEnemy.yThres=144
#define 2930
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewBGO=instance_create(-16,144,oTruckSec_BG)
tNewBGO.sprite_index=sCHAOS_BeetleBot; tNewBGO.moveSpd=3
#define 3110
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(room_width+48,144,oCHAOS_BeetleBot)
#define 3200
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(-16-(i*24),128,oCHAOS_SmallBot)
}

for(i=0;i<2;i+=1)
{
  tNewBGO=instance_create(-16,64+(64*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_HeavyGunner; tNewBGO.moveSpd=6
}
#define 3310
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  tNewEnemy=instance_create(room_width+32,64+(96*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=15+(10*i)
}
#define 3390
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewBGO=instance_create(-16,64+(64*i),oTruckSec_BG)
  tNewBGO.sprite_index=sCHAOS_HeavyGunner; tNewBGO.moveSpd=6
}
#define 3420
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0
#define 3510
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tNewEnemy=instance_create(room_width+32,64+(64*i),oCHAOS_HeavyGunner)
  tNewEnemy.stopTime=15+(10*i)
}
#define 3550
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0
#define 3630
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    tNewEnemy=instance_create(-16-(24*ii),48+(48*i),oCHAOS_SmallBot)
  }
}

for(i=0;i<4;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    tNewBGO=instance_create(-16-(24*ii),48+(48*i),oTruckSec_BG)
    tNewBGO.sprite_index=sCHAOS_SmallBot; tNewBGO.moveSpd=6
  }
}
#define 3680
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
tNewEnemy.yThres=0
#define 3820
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    tNewEnemy=instance_create(-16-(24*ii),48+(48*i),oCHAOS_SmallBot)
  }
}
#define 3890
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewEnemy=instance_create(-48,48,oCHAOS_FishBot)
tNewEnemy.yThres=144
#define 4200
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tNewBGO=instance_create(-16,80,oTruckSec_BG)
tNewBGO.sprite_index=sC_Leviathan; tNewBGO.moveSpd=3
#define 4550
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bossTrack=0
{
  tBossTitle=instance_create(0,0,oBossNameDisplay)
  tBossTitle.bossName="Leviathan"
  tBossTitle.bossTitle="CHAOS Warship"
}

global.currentBoss="Leviathan"
global.bossTrack=1

tNewEnemy=instance_create(room_width+16,0,oC_Leviathan)
