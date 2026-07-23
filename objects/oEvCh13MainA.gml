#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

if room=rSamus5_Gate
{
  if global.gameProgress=2670
  {
    fadeAlpha=1
    npcSamus=instance_create(512,280,oMisc)
    npcSamus.sprite_index=sAN_Samus; npcSamus.image_xscale=-1
    npcSamus.image_speed=0; npcSamus.type=1

    npcHex=instance_create(336,224,oMisc)
    npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.image_alpha=0.05 npcHex.type=4; npcHex.moveStep=pi/2

    circleAlpha=1
    circleSize=0
  }
}
else if room=rSamus5_Lv2_N or room=rSamus5_Lv2_R
{
  lavaRiseSpd=0
}
else if room=rSamus5_EscapeC
{
  doorTime=0
}
else if room=rSamus5_VentShaft
{
  circleRad=0
}

gateKraid=string_char_at(global.gameGate5Prog,1)
gateArachnus=string_char_at(global.gameGate5Prog,2)
gateKingWorm=string_char_at(global.gameGate5Prog,3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=2670 and room=rSamus5_Gate //----- [1] Intro to Research Facility - Ch.13 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.activeAbility[1]=0
      global.hasShoes[2]=1; global.hasShoes[3]=1
      charSwitcher(1)
      scenePChk(256,288,0,0.1,1)
    }
    else if sceneDelay>=30 and sceneDelay<=999
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=1000}
    }
    else if sceneDelay>=1030 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=999
    {
      npcSamus.x-=14
      if npcSamus.x<=oPlayer1.x
      {
        with npcSamus {instance_destroy()}
        sceneDelay=1000
      }
    }
    else if sceneDelay>=1000 and sceneDelay<=1099
    {
      circleSize+=3
      if circleSize>=48 {sceneDelay=1100}
    }
    else if sceneDelay>=1130 and sceneDelay<=1999
    {
      circleSize-=0.65
      circleAlpha-=0.02
      if circleAlpha<=0 {sceneDelay=2000}
    }
    else if sceneDelay>=2030 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(112,128,"","Claire gained the Samus Ability Set!#She can now use some of Samus' abilities!",6,2,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","There, no more making fun of me. I'm sure this will make me just as, if not more, useful than Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's not just about pure usefulness. You gotta be as awesome as I am.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Right... I forgot ALL about that part!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","In all seriousness, this seems to suit you. I know you loved the Metroid series.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","I liked it when my life and my friends weren't on the line.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","All right. The Program Chip is here, but this isn't going to be easy. Right now you're in the center of some research facility. In the lower halls you'll find the Program Chip.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","However, it is behind a sealed door that has 3 locks. The locks are all connected to the 3 sectors that branch out from this center facility. Breaking said locks is as easy as just beating 3 large creatures.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","At least it's not terribly complicated.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, but we don't know what's in this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","A classic Metroid escape sequence?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Highly probable. I'm sure the program knew enough to have something like that trigger.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'll go look around then.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Hex","So that's how you did it.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The hell?",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=999
    {
      npcHex.image_alpha+=0.02
      if npcHex.image_alpha>=1 {sceneDelay=1000}
    }
    else if sceneDelay>=1020 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Hex","I never even thought of this!",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What are you doing here?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Hex","Simply observing. It's quite ingenious of these bots to hide from the Virus' infection until the opportune moment to grant you their abilities. It even negates any chance of infection since they wipe their own code in the process.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Hex","I must say, I hate this existence, but what a sad and pathetic way to end it. I could have found uses for them, but no matter.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just go away! It's your fault they resorted to this!",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Hex","And this means what exactly?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh...",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Hex","But no time for exposition here. There is work to do elsewhere. But before that... These 'Gates' are rather interesting. They seem to block outside abilities. There's something I did... I think you'll find it rather irritating.",0,3,oMessageCutscene,1)
  else if sceneProgress=27
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=999
    {
      npcHex.image_alpha-=0.04
      if npcHex.image_alpha<=0 {sceneDelay=1000}
    }
    else if sceneDelay>=1020 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, what did he do?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Changed something about you. Again, he blocks my view, but I think only in this room. Can you see what he changed, Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Chao","Nope.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You'll have to figure that out on your own.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Claire","Great...",0,3,oMessageCutscene,1)
  else if sceneProgress=33
  {
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 13#Claire Fusion"
    global.canCharSwap=1
    global.hasAbilToken[2]=1
    global.hasAbilToken[4]=2
    global.activeAbility[1]=2
    global.gameProgress=2680
    global.gamePaused=false
  }
}
else if global.gameProgress=2680 and room=rSamus5_Lv0_Ele1 //----- [2] About checkpoints -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So some rules have changed for this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh here we go, that's always a bad sign. Have fun with whatever horrible news Jeremy has.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's probably not that bad.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That stone you see over there will fully recover your life energy.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","See?!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And act as a checkpoint.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","What do you mean by that?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","If you lose in this place, you'll respawn at the last checkpoint you activated. You won't be at the start of the map you were in.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I TOLD YOU!!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Metroid isn't that hard though.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is... nevermind. Just remember that YOU were the one that said it, not me.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","Whatever Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh, heads up. That terminal will tell you which Sector you're at and what Sector you should be going to next.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2690
    global.gamePaused=false
  }
}
else if global.gameProgress=2690 and room=rSamus5_Lv1_D and global.gamePaused=false //----- [] Ridley appears & Get Morph Ball -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=336 {sceneProgress=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=90
      {
        if sceneDelay mod 4=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
        var tEffect;
        tEffect=instance_create(432+random(96),16+random(56),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.depth=7
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=91
      {
        with (267739) {instance_destroy()}
        tile_layer_hide(8)
        boss=instance_create(480,-64,oRidleyFirst); boss.image_xscale=-1
      }
      else if sceneDelay>=92 and sceneDelay<=115 {oRidleyFirstParts.image_xscale=-1; boss.y+=8}
      else if sceneDelay=121 {boss.ridParts[0].image_index=1; playSound(global.snd_RidleyScreamA,0,0.98,1)}
      else if sceneDelay=124 {boss.ridParts[0].image_index=2}
      else if sceneDelay=144 {boss.ridParts[0].image_index=1}
      else if sceneDelay=147 {boss.ridParts[0].image_index=0}
      else if sceneDelay>=166
      {
        var tempMplay;
        tempMplay=findMusic(816)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        with oRidDoorBeacon {bActive=1}
        sceneDelay=0; sceneProgress=0
        storeStatus(0)
        global.bCanSave=false
        global.bossTrack=101
      }
    }
  }
  else if global.bossTrack=101
  {
    if sceneProgress=0 and !instance_exists(oRidDoorBeacon)
    {
      with oEventBarrier {instance_destroy()}
      sceneProgress+=1
    }
    else if sceneProgress=1 and !instance_exists(oStoryObject)
    {
      global.bossTrack=0
      global.hasAbilToken[4]=3
      instance_create(0,0,oCheckpointNotice)
      global.metCheckpoint[0]=room; global.metCheckpoint[1]=144; global.metCheckpoint[2]=256
      sceneProgress=0
      global.gameProgress=2700
    }
  }
}
else if global.gameProgress=2700 and room=rSamus5_Lv1_D //----- [] Morph Ball Tutorial A -----
{
  if sceneProgress=0
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Morph Ball A"
    tNewTutorial.tutorialInfo="To go into Morph Ball mode, press [Action C]. To get out of Morph Ball mode, either press [Action C] or [Up]."
    tNewTutorial.scrAreaY=0
    sceneProgress+=1
  }
}
else if global.gameProgress=2710 and room=rSamus5_Lv1_E and global.gamePaused=false //----- [] Ridley breaks through ceiling again -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {with oMetRipper {instance_destroy()}}
    if sceneDelay>=15 and sceneDelay<=40
    {
      if sceneDelay mod 4=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      var tEffect;
      tEffect=instance_create(320+random(96),16+random(24),oEffect)
      tEffect.sprite_index=sMMExplosion; tEffect.depth=7
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if sceneDelay=41
    {
      with (267739) {instance_destroy()}
      tile_layer_hide(8)
    }
    else if sceneDelay=42 {boss=instance_create(368,-64,oRidleyFirst); boss.image_xscale=-1}
    else if sceneDelay>=43 and sceneDelay<=66 {oRidleyFirstParts.image_xscale=-1; boss.y+=8}
    else if sceneDelay>=67
    {
      with oRidDoorBeacon {bActive=1}
      boss.activateBoss=1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists((267938))
    {
      with (267952) {instance_destroy()}
      oRidleyFirst.atkDelay-=4
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists((267939))
    {
      with (267953) {instance_destroy()}
      oRidleyFirst.atkDelay-=4
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    if !instance_exists((267940))
    {
      with (267954) {instance_destroy()}
      oRidleyFirst.atkDelay-=4
      oRidleyFirst.extendStream=7
      sceneProgress+=1
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists((267942))
    {
      with (267955) {instance_destroy()}
      oRidleyFirst.atkDelay-=4
      sceneProgress+=1
    }
  }
  else if sceneProgress=5
  {
    if !instance_exists((267943)) and !instance_exists((267944))
    {
      with (267961) {instance_destroy()}
      oRidleyFirst.atkDelay-=4
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2720 and room=rSamus5_Lv1_F and global.gamePaused=false //----- [] Ridley breaks through door -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Morph Ball B"
      tNewTutorial.tutorialInfo="Hold [Action B] while in Morph Ball mode to reduce your move speed by half."
      tNewTutorial.scrAreaY=0

      with oMetGeemer {instance_destroy()}
      with oMetSkree {instance_destroy()}
      with oMetSmallSidehopper {instance_destroy()}
    }
    else if sceneDelay>=15 and sceneDelay<=40
    {
      if sceneDelay mod 4=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      var tEffect;
      tEffect=instance_create(8+random(24),32+random(64),oEffect)
      tEffect.sprite_index=sMMExplosion; tEffect.depth=7
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if sceneDelay=41
    {
      with (267974)
      {
        with myDoor {instance_destroy()}
        instance_destroy()
      }
    }
    else if sceneDelay=42 {boss=instance_create(-48,64,oRidleyFirst)}
    else if sceneDelay>=43 and sceneDelay<=66 { boss.x+=8}
    else if sceneDelay>=67
    {
      with oRidDoorBeacon {bActive=1}
      boss.activateBoss=1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists((268288))
    {
      with (268289) {instance_destroy()}
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists((268287)) and !instance_exists((268293))
    {
      with (268290) {instance_destroy()}
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2730 and room=rSamus5_Lv1_G //----- [3] Ridley is gone -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Enough of that.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","What did you do?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He shouldn't be able to transition between maps like you can, at least for now.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","So he's stuck in the previous one?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not exactly. I also made sure he went somewhere else.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's only temporary though?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, and Hex is around. He'll most likely figure out how to remove what I did fairly quick.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    instance_create(0,0,oCheckpointNotice)
    global.metCheckpoint[0]=room; global.metCheckpoint[1]=oPlayer1.x; global.metCheckpoint[2]=oPlayer1.y
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2740
    global.gamePaused=false
  }
}
else if global.gameProgress=2740 and room=rSamus5_Lv1_I //----- [] After grabbing Charge Beam -----
{
  if sceneProgress=0
  {
    if oPlayer1.y-26<=216
    {
      msgCreate(0,0,"Jeremy","Hold on, go back to that door you just passed up.",0,1,oMessagePerson,0)
      newMessage.fadingTime=120
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2740 and room=rSamus5_Lv1_J //----- [] After grabbing Charge Beam -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Charge Beam"
    tNewTutorial.tutorialInfo="To charge up your Beam Cannon, hold [Action A]. This beam pierces through enemies and deals constant damage at 65% of the beam's normal damage."
    tNewTutorial.scrAreaY=0
    global.hasAbilToken[4]=4
    global.gameProgress=2750
  }
}
else if global.gameProgress=2750 and room=rSamus5_Lv1_C //----- [] After grabbing High Jump Boots -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    global.metJumpUpgrade=1
    oPlayer1.initialJumpAcc=-7.8; oPlayer1.jumpTimeTotal=28
    global.gameProgress=2760
  }
}
else if global.gameProgress=2760 and room=rSamus5_Lv2_G //----- [] Can't go this way yet -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=96
    {
      msgCreate(0,0,"Jeremy","Hmm, looks like you'll need your dash for this.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2760 and room=rSamus5_Lv2_F //----- [] Getting Dash back & Enemy Trap: Sidehopper -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=512
    {
      instance_create(256,304,oMetSidehopper)
      oEventBarrier.y+=512
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oMetSidehopper)
    {
      with (oEventBarrier) {instance_destroy()}
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and !instance_exists(oStoryObject)
  {
    scenePChk(oPlayer1.x,oPlayer1.y,0,0.1,oPlayer1.image_xscale)
    global.gamePaused=true
    sceneProgress+=1
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=55 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's been some tampering with the enemy data here.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Tampering? What could have been done that would be so bad?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","None of them can be dashed through safely.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Seriously?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Very serious. However, it still works on projectiles.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    instance_create(464,272,oMetroidCheckpoint)
    instance_create(0,0,oCheckpointNotice)
    global.metCheckpoint[0]=room; global.metCheckpoint[1]=480; global.metCheckpoint[2]=304
    sceneDelay=0; sceneProgress=0
    global.hasShoes[2]=2
    global.gameProgress=2770
    global.gamePaused=false
  }
}
else if global.gameProgress=2770 and room=rSamus5_Lv2_K //----- [] Enemy Trap: 2 Sidehoppers -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=768
    {
      delaySpawn(640,304,oMetSidehopper,0,1,1,0.33)
      oEventBarrier.y+=512
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=35 {delaySpawn(896,304,oMetSidehopper,0,1,1,0.33)}
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if !instance_exists(oMetSidehopper)
    {
      with (oEventBarrier) {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=2780
    }
  }
}
else if global.gameProgress=2780 and room=rSamus5_Lv2_K //----- [] After grabbing Missiles -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Missiles"
    tNewTutorial.tutorialInfo="To fire your missiles, press [Action B]. These short range projectiles deal great damage. Their velocity starts slow and gradually builds."
    tNewTutorial.scrAreaY=0
    global.hasAbilToken[4]=5
    global.gameProgress=2790
  }
}
else if global.gameProgress=2790 and room=rSamus5_Lv3_E //----- [] A trap? & Spazer Beam -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=512
    {
      msgCreate(0,0,"Claire","This is sooo a trap.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oStoryObject)
    {
      global.hasAbilToken[4]=6
      global.gameProgress=2800
    }
  }
}
else if global.gameProgress=2800 and room=rSamus5_Lv3_F //----- [] Water rising -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=192 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      if oWater.y>64 {oWater.y-=2}
    }
  }
}
else if global.gameProgress=2800 and room=rSamus5_Lv3_H //----- [] Bombs -----
{
  if sceneProgress=0
  {
    if !instance_exists(oStoryObject)
    {
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Bombs"
      tNewTutorial.tutorialInfo="To use Bombs, go into Morph Ball mode, and press [Action A]."
      tNewTutorial.scrAreaY=0
      global.hasAbilToken[4]=7
      global.gameProgress=2810
    }
  }
}
else if room=rSamus5_Lv1_Y //----- [] Gravity Suit -----
{
  if global.gamePaused=false
  {
    if global.gameProgress=2810
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=204
        {
          delaySpawn(128,304,oMetSidehopper,2,1,1,0.33)
          delaySpawn(352,304,oMetSidehopper,2,1,1,0.33)
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=5
          enemyBarrier=instance_create(64,160,oEnemyBarrier); enemyBarrier.image_yscale=4
          enemyBarrier=instance_create(400,144,oEnemyBarrier); enemyBarrier.image_yscale=5
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        if oEnemyRemain.enemyCount<=3 {sceneProgress+=1}
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=1 {delaySpawn(240,304,oMetSidehopper,2,1,1,0.33)}
        else if sceneDelay=75
        {
          delaySpawn(176,304,oMetSidehopper,2,1,1,0.33)
          delaySpawn(304,304,oMetSidehopper,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        if oEnemyRemain.enemyCount<=0
        {
          with (oEnemyBarrier) {instance_destroy()}
          with (oEnemyRemain) {instance_destroy()}
          sceneProgress=0
          global.gameProgress=2811
        }
      }
    }
    else if global.gameProgress=2811
    {
      if sceneProgress=0
      {
        if !instance_exists(oStoryObject)
        {
          tNewTutorial=instance_create(0,0,oTutorialPanel)
          tNewTutorial.tutorialTitle="Gravity Suit"
          tNewTutorial.tutorialInfo="This is a Gate Exclusive Ability. With this, you can freely move under water. But be careful, you can still run out of air."
          tNewTutorial.scrAreaY=1
          global.gameProgress=2820
        }
      }
    }
  }
}
else if room=rSamus5_Lv3_K //----- [] Air Dash -----
{
  if global.gameProgress=2820
  {
    if sceneProgress=0
    {
      if !instance_exists(oStoryObject)
      {
        instance_create(0,0,oCheckpointNotice)
        global.metCheckpoint[0]=room
        global.metCheckpoint[1]=176
        global.metCheckpoint[2]=176
        global.hasShoes[3]=2
        global.gameProgress=2830
      }
    }
  }
  else if global.gameProgress=2830 //Trap event after air dash regained
  {
    if sceneProgress=0 //Wait till player is away from checkpoint and spawn Evirs/close off checkpoint and exit
    {
      if oPlayer1.x>=272
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=6
        
        enemyBarrier=instance_create(240,48,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(960,912,oEnemyBarrier); enemyBarrier.image_yscale=4
        
        createEnemy(240,480,oMetEvir,2,1,1)
        createEnemy(352,480,oMetEvir,2,1,1)
        createEnemy(912,544,oMetEvir,2,1,1)
        createEnemy(112,768,oMetEvir,2,1,1)
        createEnemy(400,880,oMetEvir,2,1,1)
        createEnemy(576,624,oMetEvir,2,1,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //Check if all enemies are gone
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2840
      }
    }
  }
}
else if global.gameProgress=2840 and room=rSamus5_Lv3_M //----- [] Super High Jump Boots -----
{
  if sceneProgress=0
  {
    if !instance_exists(oStoryObject)
    {
      global.metJumpUpgrade=2
      oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35
      global.gameProgress=2850
    }
  }
}
else if global.gameProgress=2850 and room=rSamus5_Lv2_N //----- [] Lava rises & Varia Suit -----
{
  if global.gamePaused=false
  {
    if oMetLava.y>=208 {oMetLava.y-=lavaRiseSpd}
  }
  
  if sceneProgress=0
  {
    if oPlayer1.y<=1540
    {
      lavaRiseSpd=2
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oStoryObject)
    {
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Varia Suit"
      tNewTutorial.tutorialInfo="This is a Gate Exclusive Ability. With this, you no longer take damage from most lava."
      tNewTutorial.scrAreaY=0
      global.gameProgress=2855
    }
  }
}
else if global.gameProgress=2855 and room=rSamus5_Lv2_R //----- [] Lava rises & enemy trap -----
{
  if global.gamePaused=false
  {
    if oMetLava.y>=336 {oMetLava.y-=lavaRiseSpd}
  }
  
  if sceneProgress=0
  {
    if oPlayer1.y<=1256
    {
      lavaRiseSpd=1
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.y<=272
    {
      lavaRiseSpd=6
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    var enemyCounter,enemyBarrier;
    enemyCounter=instance_create(0,0,oEnemyRemain)
    enemyCounter.enemyCount=4
    enemyBarrier=instance_create(112,112,oEnemyBarrier); enemyBarrier.image_angle=90; enemyBarrier.image_yscale=20
    enemyBarrier=instance_create(368,416,oEnemyBarrier); enemyBarrier.image_angle=90; enemyBarrier.image_yscale=4
    
    delaySpawn(144,144,oMetMultiviola,2,1,1,0.33)
    delaySpawn(400,144,oMetMultiviola,2,1,1,0.33)
    delaySpawn(144,304,oMetMultiviola,2,1,1,0.33)
    delaySpawn(400,304,oMetMultiviola,2,1,1,0.33)
    sceneProgress+=1
  }
  else if sceneProgress=3
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=2856
    }
  }
}
else if room=rSamus5_Lv2_S //----- [] Diffusion Missile -----
{
  if global.gameProgress=2856
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=176
      {
        var tEnemyBarrier;
        tEnemyBarrier=instance_create(128,192,oEnemyBarrier); tEnemyBarrier.image_yscale=7
        tEnemyBarrier=instance_create(400,304,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=45
      {
        for(i=0;i<3;i+=1)
        {
          tEffect=instance_create(352+random_range(-24,24),368-random(40),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
      }
      else if sceneDelay>=46
      {
        var tEnemySpawn;
        tEnemySpawn=instance_create(352,368,oMetSidehopper); tEnemySpawn.bStrong=1
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMetSidehopper)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if !instance_exists(oStoryObject)
      {
        tNewTutorial=instance_create(0,0,oTutorialPanel)
        tNewTutorial.tutorialTitle="Diffusion Missiles"
        tNewTutorial.tutorialInfo="You can now charge your missiles. These will deal 2x damage as well as deal splash damage at the normal missile damage level."
        tNewTutorial.scrAreaY=1
        global.hasAbilToken[4]=8
        global.gameProgress=2860
      }
    }
  }
}
else if room=rSamus5_Lv1_R //----- [] Switch before Kraid -----
{
  if gateKraid="0"
  {
    if (288057).activated=1
    {
      with oEventBarrier {instance_destroy()}
      gateKraid="1"
      var tNewString;
      tNewString=string_delete(global.gameGate5Prog,1,1)
      tNewString=string_insert("1",tNewString,1)
      global.gameGate5Prog=tNewString
    }
  }
}
else if room=rSamus5_Lv1_S //----- [] Map before Kraid -----
{
  if gateKraid="1"
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=576
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=10
        enemyBarrier=instance_create(64,240,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(1152,64,oEnemyBarrier); enemyBarrier.image_yscale=6
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1 {delaySpawn(192,288,oMetSidehopper,2,1,1,0.33)}
      else if sceneDelay=35 {delaySpawn(320,272,oMetSidehopper,2,1,1,0.33)}
      else if sceneDelay=70 {delaySpawn(896,272,oMetSidehopper,2,1,1,0.33)}
      else if sceneDelay=105 {delaySpawn(1024,288,oMetSidehopper,2,1,1,0.33)}
      else if sceneDelay>=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=6
      {
        sceneDelay+=1
        if sceneDelay=1 {delaySpawn(288,272,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay=30 {delaySpawn(368,288,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay=60 {delaySpawn(480,304,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay=90 {delaySpawn(736,304,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay=120 {delaySpawn(848,288,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay=150 {delaySpawn(928,272,oMetCacatac,2,1,1,0.33)}
        else if sceneDelay>=210 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        gateKraid="2"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,1,1)
        tNewString=string_insert("2",tNewString,1)
        global.gameGate5Prog=tNewString
      }
    }
  }
}
else if room=rSamus5_Lv1_Boss and global.gamePaused=false //----- [] Boss Fight: Kraid -----
{
  if gateKraid="2"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=320
        {
          var enemyBarrier;
          enemyBarrier=instance_create(496,128,oEnemyBarrier); enemyBarrier.image_yscale=4
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=15
        {
          boss=instance_create(144,room_height+96,oKraid)
          var tempMplay;
          tempMplay=findMusic(815)
          playMusic(tempMplay,0,0)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        var tEffect;
        tEffect=instance_create(112+random(160),400+random(8),oEffectGrav)
        tEffect.sprite_index=sKraidRock; tEffect.type=2; tEffect.fadeSpd=0.04; tEffect.rotation=0; tEffect.grav=0.25
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-3-random(2)
        
        tEffect=instance_create(112+random(160),400+random(4),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.image_alpha=0.6
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        boss.segBody.y-=1
        if boss.y<=133 {sceneProgress+=1}
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=4
      {
        var tBossTitle;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Kraid"
        tBossTitle.bossTitle="A Metroid Boss Fight"
        boss.activateBoss=1
        global.currentBoss="Kraid"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        awardBossAP(4500)
        var tFullHeartDrop,tempMplay;
        tFullHeartDrop=instance_create(392,64,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        tempMplay=findMusic(502)
        playMusic(tempMplay,0,0)
        with oEnemyBarrier {instance_destroy()}
        global.currentBoss=""
        global.bossTrack=0
        gateKraid="5"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,1,1)
        tNewString=string_insert("5",tNewString,1)
        global.gameGate5Prog=tNewString
        sceneProgress=0
      }
    }
  }
}


else if room=rSamus5_Lv2_U //----- [] Map before Arachnus -----
{
  if gateArachnus="0"
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1504
      {
        var tEnemyBarrier;
        tEnemyBarrier=instance_create(1344,240,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        tEnemyBarrier=instance_create(1776,240,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=45
      {
        for(i=0;i<3;i+=1)
        {
          tEffect=instance_create(1408+random_range(-24,24),304-random(40),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
      }
      else if sceneDelay=46
      {
        var tEnemySpawn;
        tEnemySpawn=instance_create(1408,304,oMetSidehopper); tEnemySpawn.bStrong=1
      }
      if sceneDelay>=31 and sceneDelay<=75
      {
        for(i=0;i<3;i+=1)
        {
          tEffect=instance_create(1728+random_range(-24,24),304-random(40),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
      }
      else if sceneDelay=76
      {
        var tEnemySpawn;
        tEnemySpawn=instance_create(1728,304,oMetSidehopper); tEnemySpawn.bStrong=1
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMetSidehopper) {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=45
      {
        for(i=0;i<3;i+=1)
        {
          tEffect=instance_create(1568+random_range(-24,24),304-random(40),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=8
        }
      }
      else if sceneDelay=46
      {
        var tEnemySpawn;
        tEnemySpawn=instance_create(1568,304,oMetSidehopper); tEnemySpawn.bStrong=1
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if !instance_exists(oMetSidehopper)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        gateArachnus="1"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,2,1)
        tNewString=string_insert("1",tNewString,2)
        global.gameGate5Prog=tNewString
      }
    }
  }
}


else if room=rSamus5_Lv2_Boss and global.gamePaused=false //----- [] Boss Fight: Arachnus -----
{
  if gateArachnus="1"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=128
        {
          var enemyBarrier;
          enemyBarrier=instance_create(80,192,oEnemyBarrier); enemyBarrier.image_yscale=4
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=15
        {
          var tempMplay;
          tempMplay=findMusic(815)
          playMusic(tempMplay,0,0)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay mod 2=0
        {
          var tEffect;
          tEffect=instance_create(336+random_range(-32,32),32+random(16),oEffectGrav)
          tEffect.sprite_index=sKraidRock; tEffect.type=2; tEffect.fadeSpd=0.03; tEffect.rotation=choose(-10,10); tEffect.grav=0.33
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-0.25,0.25); tEffect.ySpd=1
        }
        if sceneDelay=70
        {
          for(i=0;i<24;i+=1)
          {
            tEffect=instance_create(336+random_range(-32,32),32+random(32),oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          boss=instance_create(336,40,oArachnus)
          boss.sprite_index=sArachnusBall; boss.image_speed=0.5
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        boss.y+=8
        if boss.y>=256
        {
          boss.sprite_index=sArachnusIdle
          boss.image_speed=0.2
          boss.y=256
          for(i=0;i<12;i+=1)
          {
            tEffect=instance_create(336+random_range(-24,24),252+random(8),oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          sceneProgress+=1
        }
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay=20
        {
          playSound(global.snd_KraidRoarA,0,1,68000)
          boss.sprite_index=sArachnusSwingPrep
        }
        else if sceneDelay=40 {boss.sprite_index=sArachnusIdle}
        else if sceneDelay=55 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=5
      {
        var tBossTitle;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Arachnus"
        tBossTitle.bossTitle="A Metroid Boss Fight"
        boss.activateBoss=1
        global.currentBoss="Arachnus"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        awardBossAP(4500)
        var tFullHeartDrop,tempMplay;
        tFullHeartDrop=instance_create(224,96,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        tempMplay=findMusic(503)
        playMusic(tempMplay,0,0)
        with oEnemyBarrier {instance_destroy()}
        global.currentBoss=""
        global.bossTrack=0
        gateArachnus="5"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,2,1)
        tNewString=string_insert("5",tNewString,2)
        global.gameGate5Prog=tNewString
        sceneProgress=0
      }
    }
  }
}
else if room=rSamus5_Lv3_O //----- [] Map before King Worm -----
{
  if gateKingWorm="0"
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=960
      {
        var enemyBarrier;
        
        enemyBarrier=instance_create(928,176,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(2256,128,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        gateKingWorm="1"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,3,1)
        tNewString=string_insert("1",tNewString,3)
        global.gameGate5Prog=tNewString
      }
    }
  }
}
else if room=rSamus5_Lv3_Boss and global.gamePaused=false //----- [] Boss Fight: King Worm -----
{
  if gateKingWorm="1"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=240
        {
          var enemyBarrier;
          enemyBarrier=instance_create(32,208,oEnemyBarrier); enemyBarrier.image_yscale=4
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=1 {fadeColor=c_black}
        else if sceneDelay>=11 and sceneDelay<=60 {fadeAlpha+=0.02}
        else if sceneDelay=70
        {
          boss=instance_create(240,0,oKingWorm)
          with oEnemyBase {bCanDealDamage=false}
        }
        else if sceneDelay>=81 and sceneDelay<=130 {fadeAlpha-=0.02}
        else if sceneDelay>=170
        {
          boss.y+=4
          if boss.y>=128 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=2
      {
        var tempMplay,tBossTitle;
        tempMplay=findMusic(815)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress+=1
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="King Worm"
        tBossTitle.bossTitle="A Metroid Boss Fight"
        boss.activateBoss=1
        global.currentBoss="King Worm"
        global.bossTrack=1
        with oEnemyBase {bCanDealDamage=true}
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        awardBossAP(4500)
        var tFullHeartDrop,tempMplay;
        tFullHeartDrop=instance_create(240,96,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        tempMplay=findMusic(504)
        playMusic(tempMplay,0,0)
        with oEnemyBarrier {instance_destroy()}
        global.currentBoss=""
        global.bossTrack=0
        gateKingWorm="5"
        var tNewString;
        tNewString=string_delete(global.gameGate5Prog,3,1)
        tNewString=string_insert("5",tNewString,3)
        global.gameGate5Prog=tNewString
        sceneProgress=0
      }
    }
  }
}
else if global.gameProgress=2860 and room=rSamus5_Lv4_A //----- [4] Intro to Tourian -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is it, the Chip is down here.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","There's going to be Metroids, aren't there?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, and they'll have to be frozen to beat.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","But I never got an Ice Beam.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm going to try modifying your weapons a bit. You should be able to freeze a Metroid by dropping its HP down to 0. Though if you let it sit too long, it'll unfreeze and recover a bit. 5 missiles or a diffusion missile will take out a frozen Metroid.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Same rules as before too? Defeat all Metroids to move on?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes. Also note that Metroid stats will be obscured, I'm not sure why though.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2870
    global.gamePaused=false
  }
}

else if global.gameProgress=2960 and room=rSamus5_Lv4_Boss and global.gamePaused=false //----- [] Boss Fight: Mother Brain -----
{
  if global.bossTrack=0
  {
    if oPlayer1.x<=368
    {
      viewFix=instance_create(240,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      var tBossTitle;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Mother Brain"
      tBossTitle.bossTitle="Organic Supercomputer"
      oMotherBrain.activateBoss=1
      global.currentBoss="Mother Brain"
      global.bossTrack=1
      storeStatus(0)
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=0
    {
      var enemyBarrier;
      enemyBarrier=instance_create(48,160,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(384,80,oEnemyBarrier); enemyBarrier.image_yscale=4
      sceneProgress+=1
    }
    else if sceneProgress=2 //End Boss
    {
      view_object[0]=oPlayer1
      awardBossAP(5000)
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(248,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(505)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=2970
      sceneProgress=0
    }
  }
}
else if global.gameProgress=2970 and room=rSamus5_Lv4_K //----- [5] Where is the Chip? -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hey, where is the Chip?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It was moved.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oooh, DAMN IT! I forgot about Ridley!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","The self destruct sequence didn't start either...",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah, that's odd. Where is Ridley? Do you know?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","If he has the Chip, then he's down here, because it's not that far ahead of us.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","One more stretch, Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2980
    global.gamePaused=false
  }
}
else if global.gameProgress=3000 and room=rSamus5_Lv4_FinalBoss //----- [6] Boss Fight: Ridley (First & Second) -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=368
      {
        global.gamePaused=true
        oPlayer1.y+=8
        if oPlayer1.y>=336
        {
          scenePChk(368,336,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=11 and sceneDelay<=99
      {
        oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_speed=0.4
        oPlayer1.x+=7
        if oPlayer1.x>=432
        {
          scenePChk(432,336,0,0.1,1)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1 {enemyBarrier=instance_create(288,64,oEnemyBarrier); enemyBarrier.image_yscale=4; enemyBarrier.image_angle=90}
      else if sceneDelay>=20
      {
        boss=instance_create(496,208,oRidley)
        with oEnemyBase {bCanDealDamage=false; image_alpha=0; image_blend=c_black}
        npcHex=instance_create(576,208,oMisc)
        npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.image_alpha=0 npcHex.type=4; npcHex.moveStep=pi/2
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=60
      {
        with oEnemyBase {image_alpha+=0.025}
        npcHex.image_alpha+=0.025
      }
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","What are you doing here?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","Interfering. From the data I've gathered, Ridley can't defeat you on his own. I think a little modification is in order.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","That's cheating!",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Hex","Life's terrible sometimes, isn't it?",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay>=30 and sceneDelay<=90
      {
        if sceneDelay=60
        {
          with oEnemyBase {baseColor=c_yellow; image_blend=baseColor}
        }
        var tEffect;
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(boss.x-16+random(90),boss.y-16+random(95),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","Nothing is different aside from his color...",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Hex","Much more than that has changed. I've made sure he's completely immune to your attacks.",0,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay>=11 and sceneDelay<=70 {npcHex.image_alpha-=0.025}
      else if sceneDelay=90 {boss.ridParts[0].image_index=1}
      else if sceneDelay=94 {boss.ridParts[0].image_index=2; playSound(global.snd_RidleyScreamA,0,0.98,1)}
      else if sceneDelay=134 {boss.ridParts[0].image_index=1}
      else if sceneDelay=138 {boss.ridParts[0].image_index=0}
      else if sceneDelay>=160 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=12
    {
      var tempMplay,tBossTitle,enemyBarrier;
      tempMplay=findMusic(816)
      playMusic(tempMplay,0,0)
      with oMisc {instance_destroy()}
      with oEnemyBase {instance_destroy()}
      enemyBarrier=instance_create(288,64,oEnemyBarrier); enemyBarrier.image_yscale=4; enemyBarrier.image_angle=90
      boss=instance_create(496,208,oRidley)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Ridley"
      tBossTitle.bossTitle="Space Pirate Leader"
      boss.activateBoss=1
      global.currentBoss="Ridley"
      global.bossTrack=1
      global.gamePaused=false
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=10 //Phase 2 starts
      {
        var tBoss;
        tBoss=instance_create(544,room_height+64,oRidleyLast)
        tBoss.activateBoss=1
        instance_create(0,0,oCheckpointNotice)
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
        global.bossTrack=2
      }
    }
  }
}
else if room=rSamus5_Lv4_RidleyTunnel and global.gamePaused=false //----- [] Boss Fight: Ridley (Tunnel) -----
{
  oPlayer1.y=208
  oPlayer1.yVelLimit=0
  oPlayer1.yAccLimit=0
  if instance_exists(oSamusBomb) {oSamusBomb.y-=12}
  sceneDelay+=1
  if sceneDelay mod 39=0 {instance_create(0,room_height,oRidleyTunnelLights)}
  
  if sceneProgress=0
  {
    fadeColor=c_black
    fadeAlpha=1
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    var tEffect;
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(96+random(288),random(64),oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.25+random(0.25); tEffect.depth=4
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    fadeAlpha-=0.05
    if fadeAlpha=0 {sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    var tBoss;
    tBoss=instance_create(240,room_height+48,oRidleyTunnel)
    tBoss.activateBoss=1
    sceneProgress+=1
  }
  else if sceneProgress=4
  {
    fadeAlpha+=0.02
    if fadeAlpha>=1
    {
      sceneDelay+=1
      if sceneDelay>=15
      {
        global.currentBoss=""
        global.bossTrack=0
        global.gameProgress=3030
        global.newMapX=160; global.newMapY=64
        room_goto(rSamus5_EscapeA)
      }
    }
  }
}
else if global.gameProgress=3040 and global.gamePaused=false //----- [] Escape Sequence start -----
{
  if instance_exists(oScreenTimer) and global.forceTime=0 //Game Over if timer reaches 0
  {
    oPlayer1.life-=oPlayer1.maxLife
  }
  
  if room=rSamus5_EscapeA //Start timer
  {
    if sceneProgress=0 and !instance_exists(oScreenTimer)
    {
      if oPlayer1.x>=224 and oPlayer1.x<512
      {
        instance_create(420,16,oEvG5EscapeEffects)
        global.forceTime=4500
        var tTimer;
        tTimer=instance_create(412,8,oScreenTimer)
        tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=25
      {
        msgCreate(0,0,"Jeremy","Uh... well there it is.",0,1,oMessagePerson,0)
        newMessage.fadingTime=65
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=65
      {
        msgCreate(0,0,"Claire","Why did the escape thingy start the way it did?",0,1,oMessagePerson,0)
        newMessage.fadingTime=95
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=95
      {
        msgCreate(0,0,"Jeremy","My guess is Hex.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay>=60
      {
        msgCreate(0,0,"Claire","Right, I keep forgetting about him...",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if room=rSamus5_EscapeC //Ridley shows up
  {
    if doorTime=0 and global.forceTime<=300 //Door opens
    {
      (297935).myDoor.type=0; (297935).myDoor.sprite_index=sMetroidDoorBlue
      doorTime=1
    }
    
    if sceneProgress=0
    {
      if oPlayer1.y<=2216
      {
        var tEffect,tBoss;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(96+random(288),random(64),oEffect)
          tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.25+random(0.25); tEffect.depth=4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        tBoss=instance_create(240,room_height,oRidleyEscape)
        tBoss.activateBoss=1
        playSound(global.snd_RidleyScreamA,0,1,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=25
      {
        msgCreate(0,0,"Claire","Didn't I blast him away!? This is getting annoying!",0,1,oMessagePerson,0)
        newMessage.fadingTime=95
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=95
      {
        msgCreate(0,0,"Jeremy","It really is, it's just... wait a minute...",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=90
      {
        msgCreate(0,0,"Claire","What?",0,1,oMessagePerson,0)
        newMessage.fadingTime=40
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay>=40
      {
        msgCreate(0,0,"Jeremy","Okay, so I know this might suck for you, but when you get to the top, I need you to not exit until a certain point.",0,2,oMessagePerson,0)
        newMessage.fadingTime=155
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay>=155
      {
        msgCreate(0,0,"Claire","Sigh... why?",0,1,oMessagePerson,0)
        newMessage.fadingTime=55
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay>=55
      {
        msgCreate(0,0,"Jeremy","Because you're going to get Ridley caught in the sequence's explosion. I'm pretty sure that will take him out.",0,2,oMessagePerson,0)
        newMessage.fadingTime=155
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay>=155
      {
        msgCreate(0,0,"Claire","That is... a really good idea!",0,1,oMessagePerson,0)
        newMessage.fadingTime=65
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay>=65
      {
        msgCreate(0,0,"Jeremy","I'll disable the door, just in case, but I need you to wait till the timer is under 10 seconds.",0,2,oMessagePerson,0)
        newMessage.fadingTime=155
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=9
    {
      sceneDelay+=1
      if sceneDelay>=155
      {
        msgCreate(0,0,"Claire","It isn't exactly in seconds this time.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=10
    {
      sceneDelay+=1
      if sceneDelay>=70
      {
        msgCreate(0,0,"Jeremy","Right... just wait till it's under 300 then.",0,1,oMessagePerson,0)
        newMessage.fadingTime=85
        oRidleyEscape.bossProgress=1
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
}
else if room=rSamus5_VentShaft //----- [] Getting the Program Chip -----
{
  if global.gameProgress=3050
  {
    if sceneProgress=0
    {
      global.gamePaused=true
      stopAllMusic()
      oPlayer1.x=176; oPlayer1.y=400
      fadeColor=c_black; fadeAlpha=1
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        fadeAlpha-=0.05
        if fadeAlpha=0 {sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        if sceneDelay mod 8=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
        var tEffect;
        for(i=0;i<2;i+=1)
        {
          tEffect=instance_create(144+random(64),336+random(16),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      if sceneDelay>=90
      {
        (297940).myDoor.image_index=3; (297940).myDoor.visible=0
        var tEffect;
        for(i=0;i<64;i+=1)
        {
          tEffect=instance_create(144+random(64),192+random(160),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.25
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        oPlayer1.sprite_index=sClaireAirRoll; oPlayer1.image_speed=0.33
        playerMoveY=-10
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=56 {oPlayer1.x+=2}
      oPlayer1.y+=playerMoveY
      playerMoveY+=0.3
      if oPlayer1.y>=320 and playerMoveY>0
      {
        scenePChk(oPlayer1.x,320,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","So... did I finally do it?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yes?",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        pChip=instance_create(oPlayer1.x,212,oProgramChip)
        pChip.chipType=4
        pChip.visible=0
      }
      else if sceneDelay>=21 and sceneDelay<=35
      {
        circleRad+=2
        if sceneDelay=25
          pChip.visible=1
      }
      else if sceneDelay>=36 and sceneDelay<=50
        circleRad-=2
      else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=100
        pChip.y+=1
      else if sceneDelay=130
      {
        var tEffect;
        for(i=0;i<20;i+=1)
        {
          tEffect=instance_create(oProgramChip.x,oProgramChip.y,oKillEffect)
          tEffect.speed=5
          tEffect.direction=random(360)
          tEffect.friction=0.1+random(0.3)
          tEffect.fadeAlpha=0.04+random(0.02)
          tEffect.imageRot=random_range(-5,5)
        }
        with oProgramChip {instance_destroy()}
      }
      else if sceneDelay=160
      {
        abilSetRemove(0)
        global.programChips=5
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"","Claire can now use Samus' abilities outside of this Gate.",6,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Claire","FINALLY!! We did!",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yep, and only 1 more to go.",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        playSound(global.snd_EnemyDieMM,0,1,42000)
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(144+random(64),336+random(16),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      else if sceneDelay=20 {oPlayer1.image_xscale=-1}
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","There's no way...",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Aftershock maybe?",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Jerry, that doesn't even make any sense.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well...",0,3,oMessageCutscene,1)
    else if sceneProgress=17
    {
      sceneDelay+=1
      if sceneDelay=5
      {
        var tEffect,tBoss;
        for(i=0;i<20;i+=1)
        {
          tEffect=instance_create(144+random(64),320+random(32),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        tBoss=instance_create(176,room_height+16,oRidleyFinal)
        playSound(global.snd_RidleyScreamA,0,1,12000)
      }
      else if sceneDelay=6 {oRidleyFinal.ridParts[0].image_index=2}
      else if sceneDelay>=7 and sceneDelay<=99
      {
        oRidleyFinal.y-=3
        if oRidleyFinal.y<=224 {sceneDelay=100}
      }
      else if sceneDelay=101 {oRidleyFinal.ridParts[0].image_index=1}
      else if sceneDelay=104 {oRidleyFinal.ridParts[0].image_index=0}
      else if sceneDelay=105 {(297940).myDoor.visible=1}
      else if sceneDelay=108 {(297940).myDoor.image_index=2}
      else if sceneDelay=111 {(297940).myDoor.image_index=1}
      else if sceneDelay=114 {(297940).myDoor.image_index=0}
      else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Claire","How?! We got the Chip?",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Hex","I told you, Ridley is invincible. I've seen to that.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Wait a minute... the Chip wasn't linked to Ridley, it was linked to the escape...",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Claire","Huh?",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","That must be why it didn't trigger when Mother Brain was defeated. I bet Hex knew about it and tried to keep it from happening.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Claire","But it did happen!",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Of course, the program has to create a situation that allows success...",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Claire","What?",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'll have to explain that later, Ridley is right there.",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Hex","You won't win. Ridley can't be defeated and I've sealed the exits.",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Don't listen to him, we'll figure this out.",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Hex","Remove them, Ridley!",0,3,oMessageCutscene,1)
    else if sceneProgress=30
    {
      global.gamePaused=false
      instance_create(0,0,oCheckpointNotice)
      global.metCheckpoint[0]=room
      global.metCheckpoint[1]=288
      global.metCheckpoint[2]=320
      var tempMplay;
      tempMplay=findMusic(816)
      playMusic(tempMplay,0,0)
      oRidleyFinal.activateBoss=1
      global.currentBoss="Ridley"
      global.bossTrack=1
      sceneDelay=0; sceneProgress=0
      global.gameProgress=3060
    }
  }
  else if global.gameProgress=3060
  {
    if sceneProgress=1 //End Boss
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        stopAllMusic()
      }
      else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","So I just wanna freeze frame here for a second and let you enjoy the moment of losing AGAIN, Hex!",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Hex","What? HOW?! How did you get past all of Ridley's defenses?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You've been outplayed, just leave.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","Fine, you win, take your stupid Chip. It won't help you in the long run anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Damn, that was funny.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","Can we remove the freeze frame yet?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Right, I just had to do that.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      playSound(global.snd_EnemyDieMM,0,1,12000)
      var tEffect;
      for(i=0;i<96;i+=1)
      {
        tEffect=instance_create(oRidleyFinal.x-16+random(90),oRidleyFinal.y-16+random(95),oEffect)
        tEffect.sprite_index=sMMGlassBreak; tEffect.depth=4; tEffect.image_speed=0; tEffect.image_index=irandom_range(0,2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=15+irandom(25); tEffect.xSpd=random_range(-4,4); tEffect.ySpd=random_range(-4,4)
      }
      
      var tIndexCheck,tWalNum,tMoneyType,moneyWorth;
      moneyWorth=1
      tMoneyType=moneyWorth
      moneyWorth*=10
      tWalNum=0
      for(i=0;i<20;i+=1)
      {
        tIndexCheck=string_char_at(global.walletBoost,i+1); if tIndexCheck="1" {tWalNum+=1}
      }
      moneyWorth*=(1+tWalNum*0.1)
      for(i=0;i<32;i+=1)
      {
        tMoneyDrop=instance_create(oRidleyFinal.x-16+random(90),oRidleyFinal.y-16+random(95),oMoneyPickupPhysics)
        tMoneyDrop.moneyType=tMoneyType; tMoneyDrop.moneyWorth=moneyWorth; tMoneyDrop.enemyDrop=1
        tMoneyDrop.xVel=random_range(-5,5); tMoneyDrop.yVel=-4-random(2)
      }
      with oEnemyBase {instance_destroy()};
      (297941).myDoor.type=0; (297941).myDoor.sprite_index=sMetroidDoorBlue
      awardBossAP(6000)
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(328,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(505)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      global.bossTrack=0
      global.gamePaused=false
      global.gameProgress=3070
      sceneProgress=0
    }
  }
}
else if global.gameProgress=3070 and room=rMain_48Gate //----- [7] Where to next -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Should we report back to Central City?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's no need. Check your map and keep heading east in the desert. I'm pretty sure I picked up the signal from the last Program Chip from that direction. With Hex getting more aggressive, we need to hurry.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3080
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2670 and room=rSamus5_Gate //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=33
    }
    else if global.gameProgress=2680 and room=rSamus5_Lv0_Ele1 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=14
    }
    else if global.gameProgress=2730 and room=rSamus5_Lv1_G //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=8
    }
    else if global.gameProgress=2860 and room=rSamus5_Lv4_A //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=8
    }
    else if global.gameProgress=2970 and room=rSamus5_Lv4_K //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=8
    }
    else if global.gameProgress=3000 and room=rSamus5_Lv4_FinalBoss //[6]
    {
      if global.bossTrack=0 and sceneProgress>=1
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0
        sceneDelay=0; sceneProgress=12
      }
    }
    else if global.gameProgress=3070 and room=rMain_48Gate //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=3
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rSamus5_Gate
{
  if global.gameProgress=2670
  {
    //Circle
    draw_set_alpha(circleAlpha)
    draw_set_color(c_white)
    draw_circle(oPlayer1.x,oPlayer1.y-26,circleSize,0)
  }
}
else if room=rSamus5_Lv4_FinalBoss
{
  draw_set_alpha(0.4)
  draw_set_blend_mode(bm_add)
  draw_rectangle_color(0,128,640,448,c_black,c_black,c_red,c_red,false)
  draw_set_blend_mode(bm_normal)
}
else if room=rSamus5_VentShaft
{
  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
