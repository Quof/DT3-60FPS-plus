#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Gate 2: Hyrule -----
event_inherited()
enemyCount=-1
fadeColor=c_white
if global.gameProgress=620
  fadeAlpha=1
else
  fadeAlpha=0

if room=rLink2_PalaceA_10
{
  gameProgCheck=string_char_at(global.gameGate2Prog,1)
}
else if room=rLink2_PalaceA_11
{
  gameProgCheck=string_char_at(global.gameGate2Prog,1)
  if gameProgCheck="1" and global.bossTrack=0
    boss=instance_create(576,304,oHelmetHead)
  else if gameProgCheck="3"
  {
    with oLevelDecal
      instance_destroy()
  }
}
else if room=rLink2_PalaceF_12
{
  gameProgCheck=string_char_at(global.gameGate2Prog,2)
  if gameProgCheck="5"
  {
    with oLevelDecal
      instance_destroy()
  }
}
else if room=rLink2_MountPass
{
  gameProgCheck=string_char_at(global.gameGate2Prog,3)
}
else if room=rLink2_PalaceC_14
{
  gameProgCheck=string_char_at(global.gameGate2Prog,3)
  if gameProgCheck="4"
  {
    with oLevelDecal
      instance_destroy()
  }
}
else if room=rLink2_PalaceW_1
{
  gameProgCheckA=string_char_at(global.gameGate2Prog,1)
  gameProgCheckB=string_char_at(global.gameGate2Prog,2)
  gameProgCheckC=string_char_at(global.gameGate2Prog,3)
}
else if room=rLink2_PalaceW_13
  circleRad=0

if global.gameProgress=900 and room=rLink2_HP
{
  global.gamePaused=true
  stopAllMusic()
  fadeAlpha=1
  fadeColor=c_black
  oPlayer1.x=336
  oPlayer1.y=256
  oPlayer1.sprite_index=sJerryIdle
  stopPlayer()
  zeldaImage=instance_create(464,192,oMisc)
  zeldaImage.sprite_index=sZeldaSpeak
  zeldaImage.type=1
  zeldaImage.image_xscale=-1
  zeldaImage.image_alpha=0
  ffEfDelay=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=620 and room=rLink2_HP //----- [1] Intro to Hyrule - Ch.4 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      charSwitcher(0)
      scenePChk(400,160,1,0.1,1)
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=35
    {
      efCharge=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      efCharge.sprite_index=sMMcharging; efCharge.image_speed=0.5; efCharge.depth=15
      efCharge.type=1; efCharge.image_xscale=4; efCharge.image_yscale=4

      for(i=0;i<4;i+=1)
      {
        efStars[i]=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        efStars[i].sprite_index=sMMcharging; efStars[i].image_speed=0.5; efStars[i].depth=15
        efStars[i].type=1; efStars[i].image_alpha=0.4-(0.075*i)
        efStars[i].image_xscale=1+i; efStars[i].image_yscale=1+i
      }
    }
    else if sceneDelay>=41 and sceneDelay<=79
    {
      for(i=0;i<4;i+=1)
      {
        if i mod 2=0 {efStars[i].image_angle+=2*(i*2)}
        else {efStars[i].image_angle-=2*(i*2)}
      }
      efCharge.image_xscale-=0.1
      efCharge.image_yscale-=0.1
    }
    else if sceneDelay=80
    {
      with efCharge {instance_destroy()}
    }
    else if sceneDelay=95
    {
      abilMario=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      abilMario.sprite_index=sAN_Link; abilMario.depth=15; abilMario.type=1
      abilMario.image_xscale=4; abilMario.image_yscale=4; abilMario.image_alpha=0.75
    }
    else if sceneDelay>=96 and sceneDelay<134
    {
      abilMario.image_xscale-=0.1
      abilMario.image_yscale-=0.1
    }
    else if sceneDelay=135
    {
      with abilMario {instance_destroy()}
    }
    else if sceneDelay=140
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3;tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      with oMisc {instance_destroy()}
    }
    else if sceneDelay=150 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
  {
    playSound(global.snd_NewAbilitySet,0,1,1)
    msgCreate(112,128,"","Jerry gained the Link Ability Set!#He can now wield some of Link's abilities.",6,2,oMessageCutscene,1)
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Awesome.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now you can fight back, though as before, we need to find what's locking the ability to this world. Remember, you won't be able to use it outside of this place till then.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I've started to get my awesome back, so I'm cool with that.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wait a minute! It said only Jerry... WHAT ABOUT ME?!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You don't get to be as awesome as me.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","First, I'm the one that gets locked out of the world, and now, I don't get to share in this! How is this fair?!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","When you're as cool as me, you don't question the rules.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh shut up Jerry, that doesn't even make sense.#JEREMY, what's going on? You better have a good answer or I'm sending your sister after you!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And what would happen if I said, I don't know?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh, CHAO!",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","I think these abilities choose the person. Based off their inner most desires of the heart.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","But we're in a program, Jerry would even say that doesn't make sense!",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nah, I'm pretty happy with that.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm about to rage so hard!",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A little gamer rage never hurt.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh, shut it Jerry!",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay Jeremy, any idea where this ability lock thingy is?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not entirely sure yet, though there is a Program Chip here. That's our best bet. I've pinned down its location in the Great Palace.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hell no, I lost so many times there.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm pretty sure it's going to be worse than that.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm starting to like this.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's obviously sealed up and I'm pretty sure some cleverly concealed McGuffins will do the trick for this seal.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You have no idea where they are, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not at all, but you're a decent enough Zelda explorer... guy right... I hope. Just find some town somewhere, I'm sure the people will lead us to where we need to go.#Oh yes, one other thing...",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Claire can't be swapped in while these effects are in place. She'd be useless anyway since she has no abilities.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Claire","What a way to say it, and don't even think about making a cheap shot, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh come on now, that's too easy, I'd NEVER do that.",0,3,oMessageCutscene,1)
  else if sceneProgress=31
  {
    sceneDelay=0; sceneProgress=0
    var tNewTutorial,tNewChapter,tempMplay;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Action Button A"
    tNewTutorial.tutorialInfo=string("To use Link's primary ability, the Master Sword, press Action Button A, which is currently set to [") +string(global.ctrlActA) +string("].")
    tNewTutorial.scrAreaY=0
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 4#Jerry's Adventure"
    tempMplay=findMusic(203)
    playMusic(tempMplay,0,0)
    global.canCharSwap=1
    global.hasAbilToken[1]=2
    global.activeAbility[0]=1
    global.gameProgress=630
    global.gamePaused=false
  }
}
else if global.gameProgress=640 //----- [2] Random Encounter -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What the hell?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","This didn't have random encounters.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah there's a bug or something interfering with how it's supposed to work.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well yeah... Any way to fix that?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There is I'm sure, but I don't know.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","We'll figure it out. There's a town close by, go check that out.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=650
    global.gamePaused=false
  }
}
else if global.gameProgress=660 and room=rLink2_TownA_Ext //----- [3] Zelda Town -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","Told ya.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Anything important here?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Probably not, but the townsfolk can tell you where to go.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No spells or abilities?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","You wouldn't get that lucky Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=670
    global.gamePaused=false
  }
}
else if global.gameProgress=680 and room=rLink2_PalaceA_1 //----- [4] Desert Palace -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, I think I can remove those random encounters. Just give me time.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh man, if you can do that, I will love you forever.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't really care as long as quick time events don't show up.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Never say that particular set of words in that order ever again.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=690
    global.gamePaused=false
  }
}
else if global.gameProgress=690 and room=rLink2_PalaceA_6 //----- [5] After grabbing Arrows -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh bad ass!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They are indeed, but keep in mind they can run out. You can get arrow pickups from enemy drops.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Normal stuff then... Oh and what is that thing on the left?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It recharges your arrows or any active consumable weapon. However, something to note. Your arrows will automatically recharge on their own.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Handy.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, some quicker than others...#Oh yeah! Random encounters were turned off!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How did that happen?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Figured out what the Virus messed with. I just changed a 1 to a 0 and poof, it worked.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well then, thanks. I was going nuts with the random encounters out there.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    var tNewTutorial,tNewBarrier;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Action Button B"
    tNewTutorial.tutorialInfo=string("To use Link's Arrows, press [") +string(global.ctrlActB) +string("]. You can charge the arrow by holding it down. Hold [Up] or [Down] before firing to change the firing direction.")
    tNewTutorial.scrAreaY=0
    tNewBarrier=instance_create(640,240,oSwitchBarrier)
    tNewBarrier.switchID=140072
    sceneDelay=0; sceneProgress=0
    global.newMapX=144
    global.newMapY=272
    instance_create(0,0,oCheckpointNotice)
    global.hasAbilToken[1]=3
    global.gameProgress=700
    global.gamePaused=false
  }
}
else if room=rLink2_PalaceA_11 //----- [] Boss Fight: Helmethead -----
{
  if gameProgCheck="1"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0 and oPlayer1.x>=448
      {
        viewFix=instance_create(448,176,oMisc)
        viewFix.type=0
        viewFix.sprite_index=sNull
        view_object[0]=viewFix
        sceneProgress+=1
      }
      else if sceneProgress=1
      {
        instance_create(240,240,oBossBarrier)
        instance_create(640,240,oBossBarrier)
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Helmethead"
        tBossTitle.bossTitle="Unpleasant Ghostly Suit of Armor"
        tempMplay=findMusic(802)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        global.currentBoss="Helmethead"
        global.bossTrack=1
        storeStatus(0)
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        view_object[0]=oPlayer1
        with oMisc {instance_destroy()}
        var tFullHeartDrop;
        tFullHeartDrop=instance_create(440,192,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        awardBossAP(250)
        var tempMplay;
        tempMplay=findMusic(204)
        playMusic(tempMplay,0,0)
        with oBossBarrier {instance_destroy()}
        sceneProgress=0
        global.currentBoss=""
        global.bossTrack=0
        gameProgCheck="2"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,1,1)
        tNewString=string_insert("2",tNewString,1)
        global.gameGate2Prog=tNewString
      }
    }
  }
  else if gameProgCheck="2"
  {
    if sceneProgress=0 and oPlayer1.x>=992
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=272
        {
          scenePChk(oPlayer1.x,272,0,0.1,1)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oLevelDecal.x,oLevelDecal.y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=13
      {
        playSound(global.snd_BombExplode,0,0.95,11025)
        with oLevelDecal {instance_destroy()}
      }
      else if sceneDelay=30
      {
        gameProgCheck="3"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,1,1)
        tNewString=string_insert("3",tNewString,1)
        global.gameGate2Prog=tNewString
        global.gamePaused=false
      }
    }
  }
}
else if global.gameProgress=720 and room=rLink2_PalaceF_1 //----- [6] Forest Palace -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","This is really boring for me.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Now you know how I feel when...",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","You really don't want to finish that sentence.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh no, I do.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They're really cute aren't they sis?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","You thought so too?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Adorable actually.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sooo, what's going on here, this isn't a Zelda 2 thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","How incredibly observant of you, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's nothing to say. It just isn't a Zelda 2 thing. I have a feeling though, that this is going to get a bit more complicated than just; find key, find door.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Wait wait, there is one thing I was able to do. I've set up a map system for you like the one you have on the Mainland.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","These secondary maps don't have as much info like item details like the main one, but you can find your location and sometimes a bit of other info if I can scan for it.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","To get to it, press [U] or [I] to swap between maps when the map submenu is active.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","One thing I wanted to mention before I go on being awesome. Did you guys like how I can pass right through encounters on the map sometimes?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Is that a complaint?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nah, too many encounters would be annoying.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=725
    global.gamePaused=false
  }
}
else if global.gameProgress=725 and room=rLink2_PalaceF_9 //----- [7] After grabbing Bombs -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=224
      {
        scenePChk(oPlayer1.x,224,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is getting better and better.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","These do a lot of damage and can blow up certain objects.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","In other words, they rock ass!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They need to be handled differently though. The bomb itself doesn't deal any damage, you'll need to time the explosion. They explode after 3 seconds.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I can handle that.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now that you have all 3 main abilities for this set, I want to tell you about Ability Levels. If you go into your pause menu and select the Ability Set submenu, you will see your abilities displayed.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It shows your ability's power and level along with a few other statistics. When they level up, their power will boost. To do so, you may have noticed those weapon icons hidden around. Grabbing those will increase a certain ability's level by 1.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Easy enough, so just find the upgrades you want the most.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I... guess? Oh yeah, the amount of power they gain is also proportionate to their base power at level 0.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And now I'm bored.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just figured I share that bit of info in case you actually cared for once.",0,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Action Button C"
    tNewTutorial.tutorialInfo=string("To use Link's Bombs, press [") +string(global.ctrlActC) +string("]. Like the arrows, their initial angle can be changed by holding Up or Down before firing. Press the bomb button again while it is active to speed up its detonation.")
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.newMapX=208
    global.newMapY=256
    instance_create(0,0,oCheckpointNotice)
    global.hasAbilToken[1]=4
    global.gameProgress=730
    global.gamePaused=false
  }
}
else if global.gameProgress=730 and room=rLink2_PalaceF_9 //----- [] Stalfos attack -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=528
      {
        enemyBarrier=instance_create(352,96,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(688,96,oEnemyBarrier); enemyBarrier.image_yscale=12
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=15 {delaySpawn(416,288,oStalfos,0,1,1,0.33)}
      else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oStalfos) {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=15 {delaySpawn(640,288,oStalfos,0,1,1,0.33)}
      else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if !instance_exists(oStalfos) {sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=15 {delaySpawn(416,288,oStalfos,0,1,1,0.33)}
      else if sceneDelay=45 {delaySpawn(640,288,oStalfos,0,1,1,0.33)}
      else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6
    {
      if !instance_exists(oStalfos)
      {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=740
      }
    }
  }
}
else if room=rLink2_PalaceF_12 //----- [] Boss Fight: Dead Hand -----
{
  if gameProgCheck="3"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0 and oPlayer1.x>=160
      {
        viewFix=instance_create(240,176,oMisc)
        viewFix.type=0
        viewFix.sprite_index=sNull
        view_object[0]=viewFix
        sceneProgress+=1
      }
      else if sceneProgress=1
      {
        var bossBarr;
        bossBarr=instance_create(80,224,oBossBarrier)
        bossBarr=instance_create(384,224,oBossBarrier)
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Dead Hand"
        tBossTitle.bossTitle="Undead Thing With A Weird Name"
        tempMplay=findMusic(802)
        playMusic(tempMplay,0,0)
        boss=instance_create(320,288,oDeadHand)
        boss.activateBoss=1
        global.currentBoss="Dead Hand"
        global.bossTrack=1
        storeStatus(0)
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        view_object[0]=oPlayer1
        with oMisc {instance_destroy()}
        var tFullHeartDrop;
        tFullHeartDrop=instance_create(240,112,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        awardBossAP(500)
        var tempMplay;
        tempMplay=findMusic(209)
        playMusic(tempMplay,0,0)
        with oBossBarrier {instance_destroy()}
        sceneProgress=0
        global.currentBoss=""
        global.bossTrack=0
        gameProgCheck="4"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,2,1)
        tNewString=string_insert("4",tNewString,2)
        global.gameGate2Prog=tNewString
      }
    }
  }
  else if gameProgCheck="4"
  {
    if sceneProgress=0 and oPlayer1.x>=928
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=256
        {
          scenePChk(oPlayer1.x,256,0,0.1,1)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oLevelDecal.x,oLevelDecal.y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=13
      {
        playSound(global.snd_BombExplode,0,0.95,11025)
        with oLevelDecal {instance_destroy()}
      }
      else if sceneDelay=30
      {
        gameProgCheck="5"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,2,1)
        tNewString=string_insert("5",tNewString,2)
        global.gameGate2Prog=tNewString
        global.gamePaused=false
      }
    }
  }
}
else if global.gameProgress=740 and room=rLink2_PalaceW_1 //----- [8] Water Palace: This is weird -----
{
  if gameProgCheckC="0"
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What's going on with this?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm not sure, but it seems you need to break the 3 gems to get in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","But aren't one of the gems IN this place? I thought this barrier would be at the Great Palace!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Looks like things are being messed with again...",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Chao","The Great Palace is open. There's no barrier there.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So something DID screw with things here.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You know what this means right?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, that there's something worse than the Great Palace.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      sceneDelay=0; sceneProgress=0
      gameProgCheckC="1"
      var tNewString;
      tNewString=string_delete(global.gameGate2Prog,3,1)
      tNewString=string_insert("1",tNewString,3)
      global.gameGate2Prog=tNewString
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=750 and room=rLink2_MountPass //----- [9] Mountain Pass -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This leads to the Great Palace.",0,3,oMessageCutscene,1)
  if gameProgCheck="0"
  {
    if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What about the 3 gems?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This might sound weird but... go to the Great Palace anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Really, why?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm seeing something really odd here.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Chao","The gem barrier is not guarding the Great Palace.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It isn't?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","Nope, there's a palace to the south-east from here that it's guarding.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Wait a minute, you're telling me that the Great Palace has one of the gems?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Chao","Yes, I figured it out just a moment ago.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Great, someone or something is messing with this place.",0,3,oMessageCutscene,1)
  }
  else if gameProgCheck="1"
  {
    if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Can't believe something is screwing with the data that much.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The Virus has a good grip on all this it seems.",0,3,oMessageCutscene,1)
    else if sceneProgress=4
      sceneProgress=12
  }
  if sceneProgress=12
  {
    sceneDelay=0; sceneProgress=0
    gameProgCheck="2"
    var tNewString;
    tNewString=string_delete(global.gameGate2Prog,3,1)
    tNewString=string_insert("2",tNewString,3)
    global.gameGate2Prog=tNewString
    global.gameProgress=760
    global.gamePaused=false
  }
}
else if global.gameProgress=760 and room=rLink2_MountPass //----- [] Pass Rock Point -----
{
  if oPlayer1.x>=256 {global.gameProgress=770}
}
else if global.gameProgress=780 and room=rLink2_DeathMount_A //----- [10] Death Mountain & Damage Types -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I've got something important to share with you. Something I probably should have talked about earlier.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Is this about Attack Types?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","... And what if it is?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","You said I could talk about that!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I did sis, how about you take over then?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","Really?! YES!",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay=15
    {
      for(i=0;i<6;i+=1)
      {
        dmgType=instance_create(50,139+(i*20),oMisc)
        dmgType.sprite_index=sPauseM_AtkTypes; dmgType.type=1
        dmgType.depth=0; dmgType.image_speed=0; dmgType.image_index=i
      }
      createScreenText(70,140,-1,fnt_EnemyName,fa_left,"Normal Type",3,c_white,0,0)
      createScreenText(70,160,-1,fnt_EnemyName,fa_left,"Pierce Type",3,c_white,0,0)
      createScreenText(70,180,-1,fnt_EnemyName,fa_left,"Elemental Type",3,c_white,0,0)
      createScreenText(70,200,-1,fnt_EnemyName,fa_left,"Shot Type",3,c_white,0,0)
      createScreenText(70,220,-1,fnt_EnemyName,fa_left,"Explosion Type",3,c_white,0,0)
      createScreenText(70,240,-1,fnt_EnemyName,fa_left,"Special Type",3,c_white,0,0)
    }
    else if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","These icons are the different damage types that you can use. Every enemy has their own resistance and vulnerability to these. Your ability submenu will display your attack's damage type.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","For Link's set, you have access to the following:#Master Sword - Normal#Arrows - Pierce#Bombs - Explosion",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","An enemy's damage reactions to these can be found in their scan data.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay+=1
    if sceneDelay=15
    {
      for(i=0;i<5;i+=1)
      {
        dmgType=instance_create(192,152+(i*20),oMisc)
        dmgType.sprite_index=sScanMenuDmgTypes; dmgType.type=1
        dmgType.depth=0; dmgType.image_speed=0; dmgType.image_index=i
      }
      createScreenText(210,140,-1,fnt_EnemyName,fa_left,"Completely Invulnerable - No Damage",3,c_white,0,0)
      createScreenText(210,160,-1,fnt_EnemyName,fa_left,"Somewhat Resistant - Half Damage",3,c_white,0,0)
      createScreenText(210,180,-1,fnt_EnemyName,fa_left,"Normal - No change",3,c_white,0,0)
      createScreenText(210,200,-1,fnt_EnemyName,fa_left,"Partial Weakness - Double Damage",3,c_white,0,0)
      createScreenText(210,220,-1,fnt_EnemyName,fa_left,"Extremely Vulnerable - Triple Damage",3,c_white,0,0)
    }
    else if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Chao","In their scan data, you'll find these icons. Here are their meanings... Warmer colors are the bad ones. Does that make sense?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hit them till they disappear, pretty much.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Chao","Something like that...#OH!! Here's something helpful!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Chao","When you damage an enemy, if you see an orange damage value, it means the enemy has a resistance to that attack. If you see a green value, it means the enemy took extra damage. I hope all this helps out.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Chao","I think the most important thing though, is using the right tool for the right job, regardless of damage output.",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    with oScreenText {instance_destroy()}
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=790
    global.gamePaused=false
  }
}
else if global.gameProgress=790 and room=rLink2_DeathRoadA //----- [] Boss Fight: Barba -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=416
    {
      viewFix=instance_create(416,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      var bossBarr;
      bossBarr=instance_create(240,192,oBossBarrier)
      bossBarr.image_yscale=1.5
      bossBarr=instance_create(576,240,oBossBarrier)
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Barba"
      tBossTitle.bossTitle="Great Lava Serpent"
      tempMplay=findMusic(802)
      playMusic(tempMplay,0,0)
      boss=instance_create(392,room_height,oBarba)
      boss.activateBoss=1
      global.currentBoss="Barba"
      global.bossTrack=1
      storeStatus(0)
      sceneProgress=795
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      view_object[0]=oPlayer1
      with oMisc {instance_destroy()}
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(448,192,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      awardBossAP(600)
      var tempMplay;
      tempMplay=findMusic(202)
      playMusic(tempMplay,0,0)
      with oBossBarrier {instance_destroy()}
      sceneProgress=0
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=795
    }
  }
}
else if global.gameProgress=800 and room=rLink2_PalaceC_1 //----- [11] Great Palace -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true; oPlayer1.sprite_index=sJerryIdle}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Here we are, the Great Palace and no barrier.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whatever, I've beaten the original game without having to use a continue, how bad could this be?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you really have to ask that Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=810
    global.gamePaused=false
  }
}
else if room=rLink2_PalaceC_14 //----- [] Boss Fight: Thunderbird -----
{
  if gameProgCheck="2"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0 and oPlayer1.x>=544
      {
        viewFix=instance_create(544,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
        sceneProgress+=1
      }
      else if sceneProgress=1
      {
        var bossBarr;
        bossBarr=instance_create(288,0,oBossBarrier)
        bossBarr.image_yscale=5.5
        bossBarr=instance_create(784,0,oBossBarrier)
        bossBarr.image_yscale=5.5
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Thunderbird"
        tBossTitle.bossTitle="Horrific Bird of Fire Spam"
        tempMplay=findMusic(802)
        playMusic(tempMplay,0,0)
        boss=instance_create(832,192,oThunderbird)
        boss.activateBoss=1
        global.currentBoss="Thunderbird"
        global.bossTrack=1
        storeStatus(0)
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        view_object[0]=oPlayer1
        with oMisc {instance_destroy()}
        var tFullHeartDrop;
        tFullHeartDrop=instance_create(544,128,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        awardBossAP(600)
        var tempMplay;
        tempMplay=findMusic(205)
        playMusic(tempMplay,0,0)
        with oBossBarrier {instance_destroy()}
        sceneProgress=0
        global.currentBoss=""
        global.bossTrack=0
        gameProgCheck="3"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,3,1)
        tNewString=string_insert("3",tNewString,3)
        global.gameGate2Prog=tNewString
      }
    }
  }
  else if gameProgCheck="3"
  {
    if sceneProgress=0 and oPlayer1.x>=1248
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          scenePChk(oPlayer1.x,288,0,0.1,1)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oLevelDecal.x,oLevelDecal.y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=13
      {
        playSound(global.snd_BombExplode,0,0.95,11025)
        with oLevelDecal {instance_destroy()}
      }
      else if sceneDelay=30
      {
        gameProgCheck="4"
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,3,1)
        tNewString=string_insert("4",tNewString,3)
        global.gameGate2Prog=tNewString
        global.gamePaused=false
      }
    }
  }
}
else if global.gameProgress=815 and room=rLink2_PalaceW_1 //----- [12] Water Palace: Getting in -----
{
  if gameProgCheckA="3" and gameProgCheckB="5" and gameProgCheckC="4"
  {
    if sceneProgress=0 and oPlayer1.x>=224
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=240
      {
        oPlayer1.y=240
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=5
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        with oScaledTrapZone {instance_destroy()}
      }
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This is going to suck isn't it?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You have to ask that?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hoping for some reassurance or motivation.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Well you know how I am on that. But enough of these things, I should probably tell you about water.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It's tasteless and necessary?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, that's entirely what I was going to say about it. But also to warn you that water hinders your movement and staying in it for too long will cause you to drown.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ah, so normal water rules right?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yeah, I suppose there's really no reason to explain water, it's not like you haven't been around it before.",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      with oScaledTrapZone {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=820
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=830 and room=rLink2_PalaceW_2 //----- [13] Water Palace: Troubles -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We never had to deal with water before... Aside from that little detour in Metropolis. That doesn't count.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you see that, Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yes...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh what is it now?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Program Chip is definitely in this place. I'd be able to reassign its coordinates straight to you, but something is blocking me out. It's massive whatever it is.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know what to do then.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You'll just need to be careful, I haven't seen anything like this since...",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Since what?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ignore me. I'm being a drama king here. Oh yeah, I've activated a map system for you here.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameGate2Prog="666"
    global.gameProgress=840
    global.gamePaused=false
  }
}
else if global.gameProgress=840 and room=rLink2_PalaceW_11 //----- [Unskippable] Enemy Trap 1 -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=512
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=7

        enemyBarrier=instance_create(304,416,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(704,416,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(336,400,oCyclopsBat,2,1,1,0.33)
        delaySpawn(688,400,oCyclopsBat,2,1,1,0.33)
      }
      else if sceneDelay=170
      {
        delaySpawn(464,448,oOctorok,2,1,1,0.33)
        delaySpawn(560,448,oOctorok,2,1,1,0.33)
      }
      else if sceneDelay=280
      {
        delaySpawn(688,480,oGreenOrc,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=3 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(512,432,oDoomknocker,2,1,1,0.33)}
      else if sceneDelay=110
      {
        delaySpawn(336,480,oAquaticDemon,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=850
      }
    }
  }
}
else if global.gameProgress=850 and room=rLink2_PalaceW_11 //----- [Unskippable] Enemy Trap 2 -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=992
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=7

        enemyBarrier=instance_create(816,416,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(1152,416,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(880,448,oAquaticDemon,2,1,1,0.33)
        delaySpawn(1104,448,oAquaticDemon,2,1,1,0.33)
      }
      else if sceneDelay=170
      {
        delaySpawn(912,624,oOctorok,2,1,1,0.33)
        delaySpawn(1072,624,oOctorok,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=4 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(832,560,oCyclopsBat,2,1,1,0.33)
        delaySpawn(1152,560,oCyclopsBat,2,1,1,0.33)
        delaySpawn(992,448,oCyclopsBat,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=860
      }
    }
  }
}
else if global.gameProgress=860 and room=rLink2_PalaceW_11 //----- [] After grabbing Boss Key -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
    global.gameProgress=870
}
else if global.gameProgress=870 and room=rLink2_PalaceW_10 //----- [14] Opening Boss Door -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1312 and oPlayer1.y>=400
    {
      global.gamePaused=true
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=528
      {
        scenePChk(oPlayer1.x,528,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      masterKey=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      masterKey.sprite_index=sDoorKey; masterKey.type=1
      masterKey.image_xscale=1.5; masterKey.image_yscale=1.5
    }
    else if sceneDelay>=21 and sceneDelay<=76
    {
      masterKey.image_angle+=5
      masterKey.y-=1
    }
    else if sceneDelay>=77 and sceneDelay<=120
    {
      masterKey.image_angle+=15
      masterKey.depth=5

      var tFFScl;
      tFFScl=random(0.2)
      tEffect=instance_create(masterKey.x,masterKey.y,oEffectB)
      tEffect.depth=4; tEffect.type=3; tEffect.sprite_index=sEfFirefly
      tEffect.newBlend=1; tEffect.image_alpha=0.3
      tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl
      tEffect.direction=random(360); tEffect.speed=random(2)+4; tEffect.friction=random(0.1)+0.1
      tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(240,240,random(30))
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
    else if sceneDelay>=121 and sceneDelay<=160
    {
      masterKey.image_angle+=20
      masterKey.image_xscale+=0.5; masterKey.image_yscale+=0.5
    }
    else if sceneDelay>=161 {sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    with oMisc {instance_destroy()}
    with oEffectB {instance_destroy()}
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    global.gamePaused=false
    sceneProgress=0
    global.gameProgress=880
  }
}
else if global.gameProgress=880 and room=rLink2_PalaceW_12 //----- [15] Boss Fight: Aqua Serpent -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=432
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gamePaused=true
        viewFix=instance_create(432,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        oPlayer1.y=272
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The Chip is close by.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Obviously something is guarding it.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm not picking anything up.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Chao","I am, it's in the water.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What's going on with this? Something is screwing with my communication.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      createScreenText(70,100,-1,fnt_ScreenText,fa_left,"Can't have you interfering.",3,c_white,1,0)
      oScreenText.image_alpha=0
      sceneProgress+=1
    }
    else if sceneProgress=8
    {
      oScreenText.image_alpha+=0.02
      if oScreenText.image_alpha=1
        sceneProgress+=1
    }
    else if sceneProgress=9 and bWaitForInput=false //Wait for [Confirm] keypress
      msgCreate(-1000,-1000,"","",1,0,oMessageCutscene,1)
    else if sceneProgress=10
    {
      if oScreenText.image_alpha=0
      {
        sceneDelay+=1
        if sceneDelay>=15
        {
          with oScreenText {instance_destroy()}
          sceneDelay=0; sceneProgress+=1
        }
      }
      else
        oScreenText.image_alpha-=0.02
    }
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Who was that?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't know.",0,3,oMessageCutscene,1)
    else if sceneProgress=13
    {
      createScreenText(70,100,-1,fnt_ScreenText,fa_left,"From here, this is all I am able to do,#but it will be enough...",3,c_white,1,0)
      oScreenText.image_alpha=0
      sceneProgress+=1
    }
    else if sceneProgress=14
    {
      oScreenText.image_alpha+=0.02
      if oScreenText.image_alpha=1
        sceneProgress+=1
    }
    else if sceneProgress=15 and bWaitForInput=false //Wait for [Confirm] keypress
      msgCreate(-1000,-1000,"","",1,0,oMessageCutscene,1)
    else if sceneProgress=16
    {
      if oScreenText.image_alpha=0
      {
        sceneDelay+=1
        if sceneDelay>=15
        {
          with oScreenText {instance_destroy()}
          sceneDelay=0; sceneProgress+=1
        }
      }
      else {oScreenText.image_alpha-=0.02}
    }
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Something just tried to block me out. Whatever it was, it was really precise. Fortunately, it was weak.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You think the Virus is on to us?",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Most likely...#Anyway, I want to warn you about this thing...",0,3,oMessageCutscene,1)
    else if sceneProgress=20
    {
      if view_object=oPlayer1
      {
        viewFix=instance_create(432,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      global.gamePaused=false
      var bossBarr;
      bossBarr=instance_create(176,112,oBossBarrier)
      bossBarr.image_yscale=2
      bossBarr=instance_create(672,176,oBossBarrier)
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Aqua Serpent"
      tBossTitle.bossTitle="Underwater Terror"
      tempMplay=findMusic(803)
      playMusic(tempMplay,0,0)
      boss=instance_create(608,400,oAquaSerpent)
      boss.activateBoss=1
      global.currentBoss="Aqua Serpent"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0
      sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oAquaSerpent) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(800)
      with oBossBarrier {instance_destroy()}
      stopAllMusic()
      global.bossTrack=2
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        oWaterVolume.y=256
        oWaterFloatPlatform.y=256
        scenePChk(432,256,0,0.1,1)
        view_object[0]=oPlayer1
        with oMisc {instance_destroy()}
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","No more water, I'm done with that... Unless Claire is the one going under.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Not likely.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I CAN be hopeful though.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This bothers me.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It's cool Jeremy, Claire and I aren't going out anymore, so I don't mind you sneaking a peek.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Not that, it's what happened just now. My connection to you was tampered with and I don't know who or what did it.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Maybe the Virus has found a way to distort the connections between us.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I hope not, but it's the only explanation I can think of. There's only one thing that knows my methods and encryptions.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","He's no longer around, so if it wasn't the Virus, someone or something got lucky.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Regardless of what it was, it's of concern.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh yeah, where's the Chip?",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's not here.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Where is it then?",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Next room.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Of course! It never ends!",0,3,oMessageCutscene,1)
    else if sceneProgress=19
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(432,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      var tempMplay;
      tempMplay=findMusic(201)
      playMusic(tempMplay,0,0)
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=890
    }
  }
}
else if global.gameProgress=890 and room=rLink2_PalaceW_13 //----- [16] Not really shadow fight -----
{
  if sceneProgress=0 and oPlayer1.x>=288
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    oPlayer1.y+=4
    if oPlayer1.y>=288
    {
      oPlayer1.y=288
      oPlayer1.sprite_index=sJerryIdle
      stopPlayer()
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Chip is definitely here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet, let's do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Unfortunately so is something else.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This better not be what I think it is.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      shadowJerry=instance_create(oPlayer1.x,oPlayer1.y,oMisc)
      shadowJerry.sprite_index=sJerryDamaged; shadowJerry.type=1
      shadowJerry.image_xscale=-1; shadowJerry.image_blend=c_black; shadowJerry.image_speed=0.1
      tShdYSpd=-3
    }
    else if sceneDelay>=6 and sceneDelay<=100
    {
      shadowJerry.hspeed=3
      shadowJerry.vspeed=tShdYSpd
      tShdYSpd+=0.3
      if shadowJerry.y>=288 and sceneDelay>=10
      {
        shadowJerry.y=288
        shadowJerry.sprite_index=sJerryIdle
        shadowJerry.hspeed=0; shadowJerry.vspeed=0
        sceneDelay=100
      }
    }
    else if sceneDelay>=125 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hell no, Jeremy, I'm not fighting this.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sounds good to me, hold on...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A shadow fight is not something I'm looking forward to.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","This I gotta see.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh please enjoy.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","You know I will.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sarcasm is hard to express in text alone.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're easy to read Jerry, I simply went with it.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh, there we go!",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      for(i=0;i<40;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.1)
        tEffect=instance_create(shadowJerry.x-10+random(20),shadowJerry.y+2-random(44),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1; tEffect.image_alpha=0.7
        tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
        tEffect.direction=random_range(80,100); tEffect.speed=random(0.5)+1; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(100)+50,255)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      with shadowJerry {instance_destroy()}
    }
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What did you just do?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I sent it to the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You can do that?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I used to, but not anymore.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Not anymore? Then how did you do it just now?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There was an access point to it just now. A near direct connection. It's weird, it popped up when I was blocked out earlier too.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Chao","So it wasn't the Virus that tried to block you then?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Still hard to say.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Chao","Well it's pretty obvious that it was something from the Vault. The Virus wouldn't be able to do what it's done if it was in there. You did say that it was like a virus vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh... Then the Vault definitely isn't working properly.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Then let's hurry up and get these chips quickly so you can get The Darkness back in control.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Speaking of that...",0,3,oMessageCutscene,1)
  else if sceneProgress=29
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      pChip=instance_create(288,176,oProgramChip)
      pChip.chipType=1; pChip.visible=0
    }
    else if sceneDelay>=21 and sceneDelay<=35
    {
      circleRad+=2
      if sceneDelay=25 {pChip.visible=1}
    }
    else if sceneDelay>=36 and sceneDelay<=50
      circleRad-=2
    else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And all this for only one of these.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's four more.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't remind me.",0,3,oMessageCutscene,1)
  else if sceneProgress=33
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
        tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
        tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
      }
      with oProgramChip {instance_destroy()}
    }
    else if sceneDelay=160 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Where to now?",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Go back to Central City and get to the control room. Remember, it's in the structure on the bridge.",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Just gotta smack around a few robots.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh yeah, now that you have the Chip, the restrictions on the Gate have been removed. Claire can be used and you can also use this ability outside of the Gate.",0,3,oMessageCutscene,1)
  else if sceneProgress=38
  {
    circleRad=0
    fadeAlpha=0
    with oMisc {instance_destroy()}
    with oProgramChip {instance_destroy()}
    global.canCharSwap=2
    var tempMplay;
    tempMplay=findMusic(201)
    playMusic(tempMplay,0,0)
    global.programChips=2
    global.gamePaused=false
    global.currentBoss=""
    global.gameProgress=900
  }
}
else if global.gameProgress=900 and room=rLink2_HP //----- [17] Triforce/Zelda gives thanks and a heart container -----
{
  if sceneProgress>=5 and sceneProgress<=27
  {
    ffEfDelay+=1
    if ffEfDelay mod 3=0
    {
      var tFFScl,tEffect;
      tFFScl=random(0.1)
      tEffect=instance_create(zeldaImage.x-10+random(20),zeldaImage.y+2-random(44),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.depth=50; tEffect.newBlend=1
      tEffect.image_alpha=0.5; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
      tEffect.direction=random_range(88,92); tEffect.speed=random(0.5)+1; tEffect.friction=random(0.01)+0.01
      tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(100)+50,255)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }

  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {oPlayer1.image_xscale=1}
    else if sceneDelay>=25
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's going on?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know, something is calling out though.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2

      for(i=0;i<80;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.1)
        tEffect=instance_create(zeldaImage.x-10+random(20),zeldaImage.y+2-random(44),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.7; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(0.5)+1; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(100)+50,255)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      zeldaImage.image_alpha=0.6
    }
    else if sceneDelay>=120
    {
      var tempMplay;
      tempMplay=findMusic(207)
      playMusic(tempMplay,0,0)
      oIdentifier.followTarget=zeldaImage
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This was unexpected.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","She says she wants to thank you.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","For what?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Getting rid of that serpent and stopping the Virus here.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I can't see that data.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","I can't see it either.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah I'm not hearing anything. What's going on?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","She says she's going to give you a gift.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","You'll see.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.1

      for(i=0;i<3;i+=1)
      {
        imageTri[i]=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        imageTri[i].sprite_index=sTriforcePiece; imageTri[i].type=1
        imageTri[i].depth=10; imageTri[i].image_alpha=0
        imageTri[i].speed=128; imageTri[i].direction=90+(120*i)
      }
    }
    else if sceneDelay=21
    {
      imageTri[0].y-=2
      for(i=0;i<3;i+=1)
      {
        imageTri[i].image_alpha=1
        imageTri[i].speed=0
        imageTri[i].direction+=180
      }
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's she going to do with this?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just shut up and watch.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      for(i=0;i<3;i+=1)
      {
        imageTri[i].speed=1
      }
    }
    else if sceneDelay=136
    {
      for(i=0;i<3;i+=1)
      {
        imageTri[i].speed=0
      }
    }
    else if sceneDelay=160
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.1
      for(i=0;i<3;i+=1)
      {
        with imageTri[i] {instance_destroy()}
      }
      for(i=0;i<40;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.1)
        tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.7; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(0.5)+1; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.005; tEffect.image_blend=c_yellow
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
    }
    else if sceneDelay>=230 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"","Zelda has left behind a Heart Container.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Awesome, though I don't understand what's going on.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's like what X could do. He was written and interpreted by The Darkness according to the data it observed.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Chao","It seems more than that. She feels an imbalance and wants to help.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I can see that... I guess.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's all number crunching.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Chao","You just don't understand it then.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm gonna go with Jeremy on this. By that, I mean let's move on.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Chao","Eh, fine.",0,3,oMessageCutscene,1)
  else if sceneProgress=28
  {
    sceneDelay+=1
    if sceneDelay>=20 and sceneDelay<=200
    {
      zeldaImage.image_alpha-=0.01
      if zeldaImage.image_alpha<=0 {sceneDelay=270}
    }
    else if sceneDelay>=300 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I will admit that was pretty cool.",0,3,oMessageCutscene,1)
  else if sceneProgress=30
  {
    sceneDelay+=1
    if sceneDelay=15
    {
      var tHeartContainer,tempMplay;
      tHeartContainer=instance_create(280,280,oHeartContainer)
      tHeartContainer.objectNum=2
      oIdentifier.followTarget=oPlayer1
      with oMisc {instance_destroy()}
      tempMplay=findMusic(207)
      playMusic(tempMplay,0,0)
      fadeAlpha=0
      global.canCharSwap=2
      global.gamePaused=false
      global.gameProgress=910
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=620 and room=rLink2_HP //[1]
    {
      bWaitForInput=false
      with oEffect {instance_destroy()}
      with oMisc {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=31
    }
    else if global.gameProgress=640 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=7
    }
    else if global.gameProgress=660 and room=rLink2_TownA_Ext //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=6
    }
    else if global.gameProgress=680 and room=rLink2_PalaceA_1 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=5
    }
    else if global.gameProgress=690 and room=rLink2_PalaceA_6 //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=11
    }
    else if global.gameProgress=710 and room=rLink2_PalaceF_1 //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=18
    }
    else if global.gameProgress=730 and room=rLink2_PalaceF_9 //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=13
    }
    else if global.gameProgress=740 and room=rLink2_PalaceW_1 //[8]
    {
      if gameProgCheckC="0"
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=9
      }
    }
    else if global.gameProgress=750 and room=rLink2_MountPass //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=12
    }
    else if global.gameProgress=780 and room=rLink2_DeathMount_A //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=17
    }
    else if global.gameProgress=800 and room=rLink2_PalaceC_1 //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=4
    }
    else if global.gameProgress=815 and room=rLink2_PalaceW_1 //[12]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=10
    }
    else if global.gameProgress=830 and room=rLink2_PalaceW_2 //[13]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=10
    }
    else if global.gameProgress=830 and room=rLink2_PalaceW_10 //[14]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=3
    }
    else if global.gameProgress=880 and room=rLink2_PalaceW_12 //[15]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oScreenText {instance_destroy()}
        sceneDelay=0; sceneProgress=20
      }
      else if global.bossTrack=2 and sceneProgress>=2
      {
        fadeAlpha=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=19
      }
    }
    else if global.gameProgress=890 and room=rLink2_PalaceW_13 //[16]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=38
    }
    else if global.gameProgress=900 and room=rLink2_HP //[17]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=30
    }
  }
}

//Room switches
if room=rLink2_PalaceA_10
{
  if gameProgCheck="0"
  {
    if (140073).activated=1
    {
      gameProgCheck="1"
      var tNewString;
      tNewString=string_delete(global.gameGate2Prog,1,1)
      tNewString=string_insert("1",tNewString,1)
      global.gameGate2Prog=tNewString
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
if room=rLink2_PalaceW_13
{
  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}
