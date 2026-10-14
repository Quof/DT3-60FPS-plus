if room=rMario1_4 {if swingSpeed>0 {swingSpeed+=1} else {swingSpeed-=1}} //spsp ns speedup
else if room=rExtGateA_3
{
    swingSpeed*=-1
    //spsp ns
    if x mod 3 = 0 {chainLinks-=1}
    else {chainLinks+=1}
}
else if room=rDiscoC //spsp ns
{
    if x<3120 and x>2400 {swingSpeed*=-1}
}
else if room=rExtGateA_4 {swingSpeed*=-1.4}

if global.location=103 //spsp ns newly added for this trap, code itself copy-pasted
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}
