/*
Keeps all relevant instances activated.
*/
//keep certain instances on screen so they stay active
oGame.x=x
oGame.y=y
oHUD.x=x
oHUD.y=y
oGlobalEvent.x=x
oGlobalEvent.y=y
//deactivate all instances off screen
instance_deactivate_region(view_xview[0]-128,view_yview[0]-128,view_wview[0]+128,view_hview[0]+128,false,true)
//activate all instances on screen
instance_activate_region(view_xview[0]-128,view_yview[0]-128,view_wview[0]+128,view_hview[0]+128,true)
//activate specific instances
instance_activate_object(oIdentifier)
if instance_exists(oAttackBase)
  instance_activate_object(oAttackBase)
