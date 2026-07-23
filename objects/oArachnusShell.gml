#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanTakeDamage=false

//Enemy base statistics
eName="Arachnus"
eLevel=23
maxLife=3750
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {redDmgHit(0)}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bCanPierce=0
{
  with other
  {
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
/*
if sprite_index=sKraidArm
{
  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+16,view_yview[0]+96,anim)
  draw_text(view_xview[0]+16,view_yview[0]+112,image_index)
  draw_text(view_xview[0]+16,view_yview[0]+128,image_number)
}
