#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCannonInUse=0
cannonProg=0
cannonTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCannonInUse=1
  {
    if cannonProg=0 //Initiate cannon fire
    {
      oPlayer1.x=x
      oPlayer1.y=y
      if oKeyCodes.kCodePressed[5]=1 //Fire
      {
        oPlayer1.visible=1
        oPlayer1.x=x+(21*image_xscale)
        oPlayer1.y=y-36
        if image_xscale=1 {oPlayer1.facing=oPlayer1.RIGHT}
        else {oPlayer1.facing=oPlayer1.LEFT}
        playSound(global.snd_MarioCannon,0,1,1)
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        for(i=0;i<16;i+=1)
        {
          tEffect=instance_create(x+(18*image_xscale)+random(20),y-64+random(20),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.75)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        cannonProg=1
      }
      else if oKeyCodes.kCodePressed[6]=1 //Cancel
      {
        oPlayer1.attackState=0
        oPlayer1.bCanTakeDamage=true
        oPlayer1.visible=1
        depth=100
        bCannonInUse=0
        io_clear()
      }
    }
    else if cannonProg=1 //FIRE PLAYER FROM CANNON
    {
      cannonTime+=1
      awardAwesome(150)
      oPlayer1.xVel=16
      oPlayer1.yVel=-16

      var tFFEScl,tEEffect;
      for(i=0;i<6;i+=1)
      {
        tFFEScl=random(0.1)
        tEEffect=instance_create(oPlayer1.x-12+(i*4),oPlayer1.y-28+(i*4),oEffectB)
        tEEffect.type=3; tEEffect.sprite_index=sEfFirefly; tEEffect.depth=21
        tEEffect.newBlend=1; tEEffect.image_alpha=0.8
        tEEffect.image_xscale=0.15+tFFEScl+0.2; tEEffect.image_yscale=0.15+tFFEScl
        tEEffect.image_angle=225; tEEffect.fadeSpd=0.05
        if i=0 {tEEffect.image_blend=make_color_rgb(238,64,53)} //red
        else if i=1 {tEEffect.image_blend=make_color_rgb(243,119,55)} //orange
        else if i=2 {tEEffect.image_blend=make_color_rgb(245,234,128)} //yellow
        else if i=3 {tEEffect.image_blend=make_color_rgb(122,192,67)} //green
        else if i=4 {tEEffect.image_blend=make_color_rgb(1,145,208)} //blue
        else if i=5 {tEEffect.image_blend=make_color_rgb(102,48,136)} //purple
        tEEffect.AccelX=0; tEEffect.AccelY=0; tEEffect.followID=-1; tEEffect.rotation=0

        tEEffect=instance_create(oPlayer1.x-12+(i*4)-lengthdir_x(8,225),oPlayer1.y-28+(i*4)+lengthdir_x(8,225),oEffectB)
        tEEffect.type=3; tEEffect.sprite_index=sEfFirefly; tEEffect.depth=21
        tEEffect.newBlend=1; tEEffect.image_alpha=0.8
        tEEffect.image_xscale=0.15+tFFEScl+0.2; tEEffect.image_yscale=0.15+tFFEScl
        tEEffect.image_angle=225; tEEffect.fadeSpd=0.05
        if i=0 {tEEffect.image_blend=make_color_rgb(238,64,53)} //red
        else if i=1 {tEEffect.image_blend=make_color_rgb(243,119,55)} //orange
        else if i=2 {tEEffect.image_blend=make_color_rgb(245,234,128)} //yellow
        else if i=3 {tEEffect.image_blend=make_color_rgb(122,192,67)} //green
        else if i=4 {tEEffect.image_blend=make_color_rgb(1,145,208)} //blue
        else if i=5 {tEEffect.image_blend=make_color_rgb(102,48,136)} //purple
        tEEffect.AccelX=0; tEEffect.AccelY=0; tEEffect.followID=-1; tEEffect.rotation=0
      }

      if cannonTime>=launchDuration
      {
        oPlayer1.attackState=0
        oPlayer1.bCanTakeDamage=true
        depth=100
        cannonTime=0
        cannonProg=0
        bCannonInUse=0
      }
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Get in cannon
if oKeyCodes.kCodePressed[3]=1 and bCannonInUse=0 and global.gamePaused=false
{
  oPlayer1.kLeft=0
  oPlayer1.kRight=0
  oPlayer1.kUp=0
  oPlayer1.kDown=0
  oPlayer1.xVel=0; oPlayer1.xAcc=0
  oPlayer1.state=oPlayer1.STANDING
  oPlayer1.attackState=oPlayer1.ACT_IN_CANNON
  oPlayer1.bCanTakeDamage=false
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  oPlayer1.visible=0
  depth=10
  bCannonInUse=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()

if cannonProg=0 and bCannonInUse=1
{
  draw_set_alpha(1)
  draw_set_font(fnt_GOoptions)
  draw_set_halign(fa_center)
  textDropShadow(string("FIRE THE CANNON: [") +string(global.ctrlJump) +string("]#Get out: [") +string(global.ctrlActA) +string("]"),view_xview[0]+240,view_yview[0]+176,c_white,c_black,4)
}
