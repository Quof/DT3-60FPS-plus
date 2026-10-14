if global.gamePaused=false
{
  if bMoving=1
  {
    wheelRotate+=rotateSpd*gDeltaTime
    x+=2*gDeltaTime
    y+=2*gDeltaTime

    if oGame.time mod (1/gDeltaTime)=0
    {
      var tEffect;
      tEffect=instance_create(x,y-10,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect._direction=random_range(160,290)
      tEffect=instance_create(x+107,y+97,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect._direction=random_range(160,290)
      tEffect=instance_create(x+107,y+334,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect._direction=random_range(-20,110)
      tEffect=instance_create(x,y+227,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect._direction=random_range(-20,110)
    }
    if x>=2144 {bMoving=0}
  }
  myGrapplePoints[0].x=x+30; myGrapplePoints[0].y=y+91
  if false {myGrapplePoints[1].x=x+30; myGrapplePoints[1].y=y+185} //spsp
  myGrapplePoints[2].x=x+79; myGrapplePoints[2].y=y+135
  if false {myGrapplePoints[3].x=x+79; myGrapplePoints[3].y=y+236}        //spsp
}
