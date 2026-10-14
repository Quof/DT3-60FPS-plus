event_inherited()
bActive=1
image_speed=0.25

//Enemy base statistics
eName="Latch Crystal"
maxLife=10000
life=maxLife
bCanDealDamage=false
bShowHealthBar=false
bShowDamagePopout=false
stunResist=50
bIsBoss=true
bNoBonus=true
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
if room=rDoubleSplit2
{
    resType[0]=1    //no whipping in the DDLC room
    resType[3]=1    //also no guns
    sprite_index=sNMLatchCrystal
    jeremyText="These are immune to normal and shot type attacks."
    chaoText="I can scan them now!"
    devText="Because juggling crystals without airdash just wasn't hard enough."
}
