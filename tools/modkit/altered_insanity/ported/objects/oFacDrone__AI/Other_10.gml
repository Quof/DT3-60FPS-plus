if instance_exists(myInfectSpot)
{
  with myInfectSpot {instance_destroy()}
}
bIsBoss=0
jeremyText="Oh no, the Aero Scanner is back. I mean, it's not really the Aero Scanner, but its behavior is nearly identical. It has that annoying laser pointer attack. To avoid it, put something between you and it. You'll know you're doing it right when the laser turns blue. If there's no cover though, dashing at the moment it would deal damage will keep it from harming you."
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
bActive=1
bInfected=1
