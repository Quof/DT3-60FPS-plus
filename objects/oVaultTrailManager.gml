#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
trailTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
trailTime+=1
if trailTime>=15
{
  var tTrailNum;
  tTrailNum=instance_number(oVaultLineMain)

  if tTrailNum<3
  {
    var tNewTrail,tSizeSet;
    tSizeSet=irandom_range(0,2)
    tNewTrail=instance_create(view_xview[0]+64+random(352),view_yview[0]+64+random(224),oVaultLineMain)
    tNewTrail.size=tSizeSet; tNewTrail.fadeSpd=0.03+(0.01*tSizeSet); tNewTrail.speed=tSizeSet
    tNewTrail.image_blend=choose(c_teal,c_blue,c_red,c_purple)
  }
  trailTime=0
}
