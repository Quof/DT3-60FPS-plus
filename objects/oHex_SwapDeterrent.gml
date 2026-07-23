#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myDir,atkTime
event_inherited()
bActive=true
bCanDealDamage=false; bCanTakeDamage=false
image_alpha=0
image_xscale=3; image_yscale=3

//Enemy base statistics
eName="Hex Swap Deterrent"
eLevel=39
maxLife=1350
life=maxLife
atkPower=16
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

atkProg=0
lightningYscale=1
snapDelay=0

sappingDelay=0
sapProg=0

jeremyText="All I can see is that this deals a ton of damage to you. That said, you slowly recover HP the longer you leave this thing active. The hell? Why would Hex have an ability like this?"
chaoText="While this is latched onto your idle partner, you won't be able to swap to them. Well technically you can, but you'll take a lot of damage. Oh yeah! If you leave this thing active too long, it'll eventually break through that shield. When it does, it'll start to slowly sap away your life points. Also I think Jeremy is seeing false data."
devText="Hex blocks dev commentary."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if oPlayer1.charSwapRecover>0 {atkPower=16}
    else {atkPower=8}

    if atkProg=0
    {
      x=oPlayerIdle.x; y=oPlayerIdle.y-26
      image_angle+=30
      image_xscale-=0.075; image_yscale-=0.075
      image_alpha+=0.04
      if image_alpha>=1
      {
        bCanDealDamage=1; bCanTakeDamage=1
        image_alpha=1; image_xscale=1; image_yscale=1
        atkProg=1
      }
    }
    else if atkProg=1
    {
      image_angle-=3
      if point_distance(x,y,oPlayerIdle.x,oPlayerIdle.y-26)>12
      {
        snapDelay+=1
        if snapDelay>=5 {x=oPlayerIdle.x; y=oPlayerIdle.y-26}
      }
      else {snapDelay=0}

      //Snap to idle character
      if oGame.time mod 3=0
      {
        if lightningYscale=1 {lightningYscale=-1}
        else {lightningYscale=1}
      }

      //Sap progress
      sappingDelay+=1
      if sappingDelay=600 {sapProg=1}
      else if sappingDelay=750 {sapProg=2}
      else if sappingDelay=900
      {
        sapProg=3
        instance_create(x,y,oHex_Sapper)
      }
    }
  }
  else if life<=0
  {
    sapProg=0
    with oHex_Sapper {instance_destroy()}
    bCanDealDamage=0; bCanTakeDamage=0
    image_xscale+=0.05; image_yscale+=0.05
    image_alpha-=0.05
    if image_alpha<=0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if atkProg=1
{
  for(i=0;i<4;i+=1)
  {
    draw_sprite_ext(sHFight_SD_Lightning,image_index,x+lengthdir_x(16,image_angle+(i*90)),y+lengthdir_y(16,image_angle+(i*90)),image_xscale,lightningYscale,image_angle,image_blend,image_alpha)
  }
}
if sapProg>=1 {draw_sprite_ext(sprite_index,image_index,x,y,1.5,1.5,image_angle*1.5,c_red,0.4)}
if sapProg>=2 {draw_sprite_ext(sprite_index,image_index,x,y,2,2,image_angle*2,c_red,0.3)}
if sapProg>=3 {draw_sprite_ext(sprite_index,image_index,x,y,2.5,2.5,image_angle*2.5,c_red,0.2)}
