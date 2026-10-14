if global.gamePaused=false
{
  headX=oPlayer1.x+headdist
  headROT=point_direction(headX,headheight,oPlayer1.x,returnPlayerYCenter())

  //dragontime+=1
  //firetime+=1
  dragontime+=1*gDeltaTime //60fps change: per frame
  firetime+=1*gDeltaTime //60fps change: per frame

  if dragontime>=dragondelay
  {
    //draw event!!
    var dragon;
    for(i=0;i<dragonspread*2+1;i+=1)
    {
      dragon=instance_create(headX,headheight,oTOTO_FireB)
      //dragon.direction=headROT-dragonoffset*(dragonspread-i)
      dragon._direction=headROT-dragonoffset*(dragonspread-i) //60fps change: DT3+'s oTOTO_FireB moves by its own _direction
      dragon.atkType=0; dragon.atkPower=ATK; dragon.mySpd=dragonSPD
    }
    playSound(global.snd_Fireball,0,0.9,32000)
    dragontime=-30
  }
  if firetime>=firedelay
  {
    var fire;
    fire=instance_create(oPlayer1.x,returnPlayerYCenter(),oGSlash)
    firetime=-30
  }
}
