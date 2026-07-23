#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tubeRunA=noone
tubeRunB=noone
tubeDropA=noone
tubeDropB=noone
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rSamus5_Lv3_D
{
  //Going through tube
  if (oPlayer1.x>=240 and oPlayer1.x<=272) or (oPlayer1.x>=544 and oPlayer1.x<=576)
  {
    if oPlayer1.y>=352 and oPlayer1.y<=448
    {
      tile_layer_depth(8,999999)
      if tubeRunA=noone
      {
        tubeRunA=instance_create(336,352,oInvisibleSolid); tubeRunA.image_xscale=9
        tubeRunB=instance_create(336,432,oInvisibleSolid); tubeRunB.image_xscale=9
        if tubeDropA!=noone
        {
          with tubeDropA {instance_destroy()}
          with tubeDropB {instance_destroy()}
          tubeDropA=noone; tubeDropB=noone
        }
      }
    }
  }
  //Passing down behind tube
  if oPlayer1.x>=320 and oPlayer1.x<=544
  {
    if (oPlayer1.y>=320 and oPlayer1.y<=336) or (oPlayer1.y>=512 and oPlayer1.y<=528)
    {
      tile_layer_depth(999999,8)
      if tubeDropA=noone
      {
        tubeDropA=instance_create(320,368,oInvisibleSolid); tubeDropA.image_yscale=4
        tubeDropB=instance_create(480,368,oInvisibleSolid); tubeDropB.image_yscale=4
        if tubeRunA!=noone
        {
          with tubeRunA {instance_destroy()}
          with tubeRunB {instance_destroy()}
          tubeRunA=noone; tubeRunB=noone
        }
      }
    }
  }
}
else if room=rExtGateF_5
{
  //Going through tube
  if (oPlayer1.x>=80 and oPlayer1.x<=160) or (oPlayer1.x>=512 and oPlayer1.x<=592)
  {
    if oPlayer1.y>=528 and oPlayer1.y<=544
    {
      tile_layer_depth(8,999999)
      if tubeRunA=noone
      {
        tubeRunA=instance_create(320,608,oInvisibleSolid); tubeRunA.image_xscale=4
        tubeRunB=instance_create(320,688,oInvisibleSolid); tubeRunB.image_xscale=4
        if tubeDropA!=noone
        {
          with tubeDropA {instance_destroy()}
          with tubeDropB {instance_destroy()}
          tubeDropA=noone; tubeDropB=noone
        }
      }
    }
  }
  //Passing down behind tube
  if oPlayer1.x>=320 and oPlayer1.x<=384
  {
    if oPlayer1.y>=528 and oPlayer1.y<=544
    {
      tile_layer_depth(999999,8)
      if tubeDropA=noone
      {
        tubeDropA=instance_create(304,624,oInvisibleSolid); tubeDropA.image_yscale=4
        tubeDropB=instance_create(384,624,oInvisibleSolid); tubeDropB.image_yscale=4
        if tubeRunA!=noone
        {
          with tubeRunA {instance_destroy()}
          with tubeRunB {instance_destroy()}
          tubeRunA=noone; tubeRunB=noone
        }
      }
    }
  }
}
