//Evil Boss Gallery: the helmet hit, after the damage (user event 15). It never runs out of life (back to full): the
//damage counts toward breaking it in Helmethead's barrier, or, dazed, hurts him (0.6 of it). A mirror helmet sends the
//arrow back at the player; a diving one falls dazed
var tDmg;
tDmg=lifeBefore-life
life=maxLife
if tDmg>0
{
  if mode=2
  {
    if instance_exists(owner) {owner.life-=round(tDmg*0.6)}
  }
  else if broken=0
  {
    if instance_exists(owner)
    {
      if owner.myBarrier>=1
      {
        breakDmg+=tDmg
        if breakDmg>=breakNeed
        {
          broken=1
          playSound(global.snd_PotShatter,0,1,1)
          var tEffect;
          tEffect=instance_create(x,y-6,oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
    }
  }
}
if reflectNow=1
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tArrow;
  tArrow=instance_create(other.x,other.y,oPassBullet)
  tArrow.sprite_index=sEvgLinkArrow; tArrow.atkPower=3; tArrow.bulletSpeed=7; tArrow.decayTime=-100
  tArrow._direction=point_direction(other.x,other.y,oPlayer1.x,returnPlayerYCenter())
  reflectNow=0
}
if diveHit=1
{
  playSound(global.snd_HardHit1,0,1,1)
  bCanDealDamage=0
  mode=2
  modeT=0
  diveHit=0
}
