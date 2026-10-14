event_inherited()
bActive=true
bCanDealDamage=false
if room=rDiscoF or room=rDiscoG or room=rExtGateS_2 or room=rDesertedTowerB //spsp ns
{
  image_xscale=1.5
  image_yscale=1.5
}
if global.location=93 {sprite_index=sUselessCastle} //spsp ns

//Enemy base statistics
eName="Useless Data"
eLevel=1
maxLife=10
life=maxLife
pointWorth=1
atkPower=1
baseItemChance=10
moneyWorth=0

jeremyText="Looks like just a useless piece of data laying around. You could probably use it as a one time use Latch Crystal. Remember those?#... Huh, it also looks like standard programmer art."
chaoText="After looking through this thing's code, I've found that it's unfinished AI... or in this case, forgotten. There are no comments left to clue in on what it was supposed to do, but hey, it's nice cannon fodder. Should we think twice before destroying these?"
devText="Dopple 2.0."
extraInfo="Completely useless."

if room=rCCity_SouthA //spsp ns
{
    newName="Windowpane"
    sprite_index=sNullColl
    
    jeremyText=""
    chaoText=""
    devText=""
    extraInfo=""
}
