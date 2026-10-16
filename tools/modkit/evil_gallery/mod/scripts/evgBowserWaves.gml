//Evil Boss Gallery: Evil Bowser's landing shockwaves (in his instance, as he lands): one each way along the floor from
//his feet at waveSpd; after a meteor, a slow one each way too (half as fast), so it takes two hops
var tW;
tW=instance_create(x-14,y,oEvgShockwave); tW.dir=-1; tW.spd=waveSpd; tW.atkPower=atkPower
tW=instance_create(x+14,y,oEvgShockwave); tW.dir=1; tW.spd=waveSpd; tW.atkPower=atkPower
if meteorFall=1
{
  tW=instance_create(x-14,y,oEvgShockwave); tW.dir=-1; tW.spd=waveSpd*0.5; tW.atkPower=atkPower
  tW=instance_create(x+14,y,oEvgShockwave); tW.dir=1; tW.spd=waveSpd*0.5; tW.atkPower=atkPower
}
