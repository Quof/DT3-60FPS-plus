event_inherited()
bActive=true
bCanDealDamage=false
if room=rDiscoF or room=rDiscoG
{
  image_xscale=1.5
  image_yscale=1.5
}

//Enemy base statistics
eName="Useless Data"
eLevel=1
maxLife=10
life=maxLife
pointWorth=1
atkPower=1
baseItemChance=10
moneyWorth=0
for(i=1;i<6;i+=1) {resType[i]=1}

jeremyText="Not much to say about these."
chaoText="Don't think twice before destroying these."
devText="Had to make it immune to most things to prevent cheese. Can't have power bomb be useful."
extraInfo="Lazy dev's switch"
