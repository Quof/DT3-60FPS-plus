locationCheck(99)
background_blend[0]=c_gray

abilSetRemove(1)
charSwitcher(0)
global.hasShoes[0]=2; global.hasShoes[1]=2
global.canDoubleJump=2
global.hasAbilToken[0]=2

gameScene=instance_create(0,0,oEvTrueEscape)
mapScene=instance_create(0,0,oEvCh20SideA)
escapeEff=instance_create(0,0,oWarshipEscapeEffects)

var tempMplay;
if global.gameProgress>=5350
{
  /*jerryChar=instance_create(1424,256,oNPC_GeneralA)
  jerryChar.sprite_index=sJerryIdle; jerryChar.image_speed=0.1; jerryChar.image_xscale=-1
  jerryChar.talker="Jerry"; jerryChar.boxSize=2
  jerryChar.stringToShow="Just go, Claire! You don't have much time! We've got this, don't you worry."*/
  tempMplay=findMusic(1020)
}
else {tempMplay=findMusic(0)}
playMusic(tempMplay,0,0)
