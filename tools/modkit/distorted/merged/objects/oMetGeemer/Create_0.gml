//Requires: runAcc,bClockWise,currentDir
event_inherited()
image_speed=0.2
if global.currentMusic=503
{
  baseColor=make_color_rgb(255,160,160)
  image_blend=baseColor
}
else if global.currentMusic=504
{
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor
}

//Enemy base statistics
eName="Geemer"
eLevel=23
maxLife=95
if room=rWarshipK {maxLife=10000} //spsp ns
life=maxLife
pointWorth=29
atkPower=7
resType[0]=2
resType[1]=2
resType[4]=5
baseItemChance=65
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

UP=0
DOWN=1
LEFT=2
RIGHT=3

jeremyText="It can stick to and crawl along any surface. I believe these have the original Metroid bug that causes them to spin midair if their surface is destroyed."
//chaoText="In some of the Metroid games, these could extend their spikes when Samus was close. Did you know that Super Metroid's code refers to Geemers as Zoomers? But unlike other creatures that got a name change, Zoomers and Geemers became seperate species."
chaoText="In some of the Metroid games, these could extend their spikes when Samus was close. Did you know that Super Metroid's code refers to Geemers as Zoomers? But unlike other creatures that got a name change, Zoomers and Geemers became separate species." //typo fix
devText="For me, these are super iconic to the 2D Metroid games. They were the first enemy I encountered in the Metroid universe when playing the NES game way way back in time. They've certainly gotten easier to deal with as Samus gets more abilities through the years."

alarm[0]=1
