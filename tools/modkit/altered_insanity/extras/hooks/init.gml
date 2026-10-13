//Altered Insanity's game variables (the original added them to initGameVars). Runs when the mods are loaded and again
//each time the game's variables are set up (a new game, loading a save).
var i;

//Speedrun Hall (not part of this conversion; set so code that looks at them works)
global.speedrunMode=0
global.speedrunHours=0
global.speedrunMinutes=0
global.speedrunSeconds=0
global.speedrunFrames=0
global.speedrunDeaths=0
global.speedrunHits=0
global.speedrunChapter=0
global.speedrunIndex=0
global.prevSave=""
global.marioDead=0
for(i=0;i<30;i+=1)
{
  global.speedrunNightmare[i]=0
  global.speedrunLean[i]=0
  global.speedrunNormal[i]=0
  global.speedrunFull[i]=0
  global.speedrunNightmareAlter[i]=0
  global.speedrunLeanAlter[i]=0
  global.speedrunNormalAlter[i]=0
  global.speedrunFullAlter[i]=0
}
global.bSpeedrunResultsShow=0
global.speedrunRecord=0
global.speedrunX=0
global.speedrunY=0
global.speedrunEleX=0
global.speedrunEleY=0
global.speedrunEleFloor=0
global.SRchapter=0
global.requireNightmare=0
global.SRstatStyle=2
global.SRequipment=1
global.SRalter=0

//Altered Beast's (the Altered Beast mod has the rest of it): some of this mod's code looks at them, so they're set here
//too, as they are with the equipment not altered (the same as that mod's init hook sets them; its load hook reads them)
global.alterEquip=0
global.pGreenLife=0; global.pGreenLifeDamageProgress=0; global.pGreenLifeDamageNeeded=75
global.amuletItem=0
global.alterIntro=0
global.abilitiesEnabled="111111111111"
global.TrueEnabled=0
global.LinkSwordTrue=0
global.LinkArrowTrue=0
global.LinkBombTrue=0
global.XBusterTrue=0
global.XIceTrue=0
global.XGravTrue=0
global.BelmontWhipTrue=0
global.BelmontKnifeTrue=0
global.BelmontWaterTrue=0
global.SamusCannonTrue=0
global.SamusMissileTrue=0
global.SamusBombTrue=0

//Virtual Insanity
//two more locked doors (51 and 52)
if variable_global_exists("lockedDoor")
{
  while string_length(global.doorKey)<52 {global.doorKey+="0"}
  while string_length(global.lockedDoor)<52 {global.lockedDoor+="0"}
}
//the boss challenges' best times (their doors use the boss gallery's records, after the game's own 0-64), and the
//records DT3+'s gallery keeps alongside (bossRoomTally looks at them)
for(i=65;i<81;i+=1)
{
  global.bossGalleryTime[i]=99999
  global.bossGalleryHitsN[i]=99999
  global.bossGalleryTimeN[i]=99999
  global.bossGalleryPlatN[i]=0
}

global.cousinoer5Progress=0
global.inBossChallenge=false
global.c5Trials="0000000000000000000000000000"
global.trialGag=1
global.alienGag=1
global.Cousinoer5HUBX=0
global.Cousinoer5HUBY=0
global.Cousinoer5ReturnRoom=""
//when you get this message cousinoer5Progress will be 1
global.msg0="0.
Welcome to Virtual Insanity! No you cannot glide effortlessly along the ground here. Glad you're here though, I've got a mystery for you to solve! I need you to accept my EULA though, I won't be held responsible for exploded brains, nor your brain morphing into the galaxy itself, be careful! Just type 'accept' in the prompt (Make sure to save first, or else I'll take your soul!) and I'll pull you through the rabbit hole."
//when you get this message cousinoer5Progress will be 5
global.msg1="1.
Welcome to the Chaos Mystery, what's that you ask? It's a mystery! Without further ado, here's your first puzzle: 'This room has been instrumental in your quest'. Go to this room"
//when you get do HEALING cousinoer5Progress will be 11
//when you do FOAM BORN cousinoer5Progress will be 22 and message below will appear
global.msg2="2.
Home of Thunderbird, spot the difference and go from there."
//when you find the area, cousinoer5Progress will be 87
//when you beat the area, cousinoer5Progress will be 153 and message below appears
global.msg3="3.
I have a quest for you. I want dead pixels. All of them. The path will reveal itself."
//when you find the area, cousinoer5Progress will be 573
//when you beat all the challenges cousinoer5Progress will be 1673 and message below will show
global.msg4="4.
30 lives in reverse."
global.msg5="5.
Figure out this puzzle, find the room it hints at
M   E M   ↓   N
_ _ _ _ _ _ _ _"
global.msg6="6.
You know this word subconciously."
global.msg7="7.
It can be helped! Perform the dance of life"
global.msg8="8.
Congrats! You thwarted the Scarier Barrier! Sorry if I ended your no death run... Or your no consumable run... Double sorry if you had to go through great lengths to find that last heart piece you've been putting off, and triple sorry if you're on achilles and wanted to try this! On the bright side, you're done with puzzles! On the down side, I'm not done testing you! Go back to the instrumental room, and really explore this time."
