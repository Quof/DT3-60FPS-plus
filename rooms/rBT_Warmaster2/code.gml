//warmaster ii change (added): Warmaster II's arena (Bubble Tower B, the hub's 8th bottom door): the old Warmaster arena
//(rWarshipZ_E3's middle) relit for his three new models. oBTB_Ev_Warmaster2 runs the fight
locationCheck(34)
global.mapTeleport=41
global.rbSwitchBlueOn=false
global.partySplit=0
abilSetRemove(0)

background_visible[1]=1; background_visible[2]=1
background_alpha[1]=0.04; background_alpha[2]=0.04

var tE,tempMplay;
tE=instance_create(0,0,oWM2_EnvGlow); tE.kind=9
instance_create(0,0,oBTB_Ev_Warmaster2)

if global.bossTrack=0 {tempMplay=findMusic(0); playMusic(tempMplay,0,0)}
else //a retry: life and ammo go back to what they were when the fight started (storeStatus(0) then)
{
  storeStatus(1)
  tempMplay=findMusic(829); playMusic(tempMplay,0,0)
}
