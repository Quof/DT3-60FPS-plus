/*
Changes the scene player character animation
use: scenePCanim(id,anim,spr,start_frame,anim_spd,end_frame,chg_sprite,chg_frame,chg_speed)

argument0: instance id
argument1: sets the animCheck var
argument2: sprite to change to
argument3: start frame
argument4: animation speed
argument5: frame to end on
argument6: sprite to change to after animation ends
argument7: frame to change to after animation ends
argument8: speed to change to after animation ends
*/
var tPCscene,tPCcheck,tPCspr,tPCfrm,tPCspd,tPCanimEnd,tPCsprChg,tPCfrmChg,tPCspdChg;

tPCscene=argument0
tPCcheck=argument1
tPCspr=argument2
tPCfrm=argument3
tPCspd=argument4
tPCanimEnd=argument5
tPCsprChg=argument6
tPCfrmChg=argument7
tPCspdChg=argument8

tPCscene.animCheck=tPCcheck
tPCscene.sprite_index=tPCspr
tPCscene.image_index=tPCfrm
tPCscene.image_speed=tPCspd
tPCscene.lastFrame=tPCanimEnd
tPCscene.spriteEnd=tPCsprChg
tPCscene.frameEnd=tPCfrmChg
tPCscene.animEnd=tPCspdChg
