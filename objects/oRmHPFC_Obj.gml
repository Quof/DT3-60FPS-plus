#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myProg=0
mySeq=0

if global.gameProgress>=3960
{
  y=296
  image_angle=315
  myProg=3
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myProg=1 //Fall
  {
    y+=8
    var tEffect;
    tEffect=instance_create(x-32,bbox_top+random(4),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
    tEffect=instance_create(x,bbox_top+random(4),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
    if y>=296
    {
      playSound(global.snd_Slam,0,0.9,1)
      var tEffect;
      for(i=0;i<4;i+=1)
      {
        tEffect=instance_create(x-random(32),y,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        tEffect.image_speed=0.33; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=-0.5-random(0.5)
      }
      image_angle-=1
      myProg=2
    }
  }
  else if myProg=2 //Rotate
  {
    image_angle-=2
    mySeq+=1
    if mySeq>=22
    {
      playSound(global.snd_Slam,0,0.9,21000)
      var tEffect;
      for(i=0;i<2;i+=1)
      {
        tEffect=instance_create(1344+random_range(-2,2),224+random_range(-2,2),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        tEffect.image_speed=0.33; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=-0.5-random(0.5)
      }
      myProg=3
    }
  }
}
