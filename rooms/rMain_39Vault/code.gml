locationCheck(39)
abilSetRemove(0)
global.partySplit=0
global.mapTeleport=0

if global.gameProgress>=2550
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,4)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,4,1)
    tNewString=string_insert("0",tNewString,4)
    global.eGateProg=tNewString
  }
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2; backFollow.backSet=backFarreachesA
backFollow.xMoveScale=0.6; backFollow.yMoveScale=0.89
backFollow.depth=1499999; backFollow.image_blend=make_color_rgb(90,90,90)

backFollow=instance_create(48,64,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(160,64,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(112,256,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(320,304,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(192,32,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(224,176,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(288,96,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(384,64,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;

gameScene=instance_create(0,0,oEvCh9MainA)

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
