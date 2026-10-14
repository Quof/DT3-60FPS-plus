if spspConvo=0 //Abomination defeated
{
  oPlayer1.y=holdY
  //sceneDelay+=1
  sceneDelay+=1*gDeltaTime //60fps change: per frame
  if sceneProgress=0
  {
    if sceneDelay=80 {msgCreate(0,0,"Jerry","We... we did it!",0,3,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","Wait... did you?",0,3,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if sceneDelay=1 {msgCreate(0,0,"Jerry","It DID explode into a million pieces... which... I wasn't expecting.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
    else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","I'm just messing with you, Jerry. But really, I'm not seeing it anymore, other than the barriers, it's gone.",0,3,oMessagePerson,0); newMessage.fadingTime=170}
    else if sceneDelay=170 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    if sceneDelay=1 {msgCreate(0,0,"Jerry","Which means Hex won't be able to call on it any longer.",0,3,oMessagePerson,0); newMessage.fadingTime=120}
    else if sceneDelay=120 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","Yes, his back up plan is over.",0,3,oMessagePerson,0); newMessage.fadingTime=80}
    else if sceneDelay=80 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6
  {
    if sceneDelay=1 {msgCreate(0,0,"Chao","I am a little sad though...",0,3,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","Why? What's up sis?",0,3,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8
  {
    if sceneDelay=1 {msgCreate(0,0,"Chao","That creature was calling out to us to help it. And look what we did.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
    else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=9
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","There was no way we could have known it was going to happen like that.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
    else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=10
  {
    if sceneDelay=1 {msgCreate(0,0,"Chao","Was there though? Both of us should have been able to foresee that the parasite would have done this on its demise. Maybe we could have prevented that.",0,3,oMessagePerson,0); newMessage.fadingTime=220}
    else if sceneDelay=220 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=11
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","I don't know what to say, sis. I really don't.",0,3,oMessagePerson,0); newMessage.fadingTime=110}
    else if sceneDelay=110 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=12
  {
    if sceneDelay=1 {msgCreate(0,0,"Chao","It's fine, I guess, I was just really hoping to help it.",0,3,oMessagePerson,0); newMessage.fadingTime=110}
    else if sceneDelay=110 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=13
  {
    if sceneDelay=1 {msgCreate(0,0,"Claire","Sorry Chao.",0,3,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=14
  {
    if sceneDelay=1 {msgCreate(0,0,"Chao","It's okay, Claire. It's not your fault.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=15
  {
    if sceneDelay=1 {msgCreate(0,0,"Jeremy","Well... There's only one thing left.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=16
  {
    if sceneDelay=1 {msgCreate(0,0,"Jerry","Yeah. Let's take down that ship, and Hex with it.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17
  {
    /*
    var tFlash,secretExit;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
    
    with oAbomSideBarriers {instance_destroy()}
    with enemyBarrierA {instance_destroy()}
    with enemyBarrierB {instance_destroy()}
    */
    awardBossAP(25000)
    global.gateHProg=200
    sceneDelay=0; sceneProgress=0
    spspConvo=1
    global.currentBoss=""
    global.canPause=1
    
    global.wpWaterLEntry=global.wpWaterLevel
    global.recAreaTrans+=1
    global.newMapX=576; global.newMapY=32
    global.gamePaused=false
    writeToPlayerGlobals()
    if global.bNightmareMode=0 {global.difficulty=2}
    if global.rmDeaths>=5 {global.chaoRecognition=1}
    global.rmDeaths=0; global.hitsTaken=0
    transition_steps=10
    transition_kind=21
    room_goto(rMain_76)
  }
}
