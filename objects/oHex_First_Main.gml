#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_speed=0

//Enemy base statistics
eName="Hex"
eLevel=20
maxLife=10000 //24000 in chains
life=maxLife
atkPower=7
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
bossProgress=0
activateBoss=0

//--------------------
dmgCount=0
lastPhaseTime=0
wingFrm=-1

arcShotTime=300
arcShotDelay=300
warnFrm=0
warnScl=2

sliceTime=-80
sliceDelay=150
currSlice=0
maxSlice=2

pullShotTime=0
pullShotDelay=1000000

superAtkTime=-1
spcAtkApos=272; spcAtkAMax=14
spcAtkBpos=624; spcAtkBMax=14
spcAtkCpos=0; spcAtkCMax=14
spcAtkDpos=room_height; spcAtkDMax=14
spcAtkMod=6

spcAtkHCAng=0
//--------------------

//Misc Data
xCenter=448
yGround=304
roomSpan=240

jeremyText="Hex has me completely blocked as expected. He's gotten a lot better at keeping me at bay. A little too good."
chaoText="His data strings are too confusing to read. I think he's encrypted his own code. In fact, the whole room is unreadable. He's hiding something..."
devText="No Dev Commentary at this time."

chains=4
chain[0]=instance_create(x+10,y+3,oHex_First_Chain)
chain[1]=instance_create(x-10,y+3,oHex_First_Chain); chain[1].image_xscale=-1
chain[2]=instance_create(x+5,y-9,oHex_First_Chain); chain[2].sprite_index=sHexChainB
chain[3]=instance_create(x-5,y-9,oHex_First_Chain); chain[3].sprite_index=sHexChainB; chain[3].image_xscale=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if chains>0 //Main
    {
      //----- Chain damage control -----
      if chains=4
      {
        if dmgCount>=8000
        {
          invertScreen=instance_create(0,0,oScreenInvert)
          invertScreen.invertTime=5
          oGameCamera.shakeAmp=6; oGameCamera.shakeTime=15
          msgCreate(0,0,"Hex","So you got one down. Still supported by 3.",0,1,oMessagePerson,0)
          newMessage.fadingTime=100
          chain[3].bDestroyMe=1
          chains-=1
          dmgCount=0
          arcShotDelay-=15
          sliceDelay-=4
          pullShotDelay=240
          maxSlice+=1
        }
      }
      else if chains=3
      {
        if dmgCount>=7000
        {
          invertScreen=instance_create(0,0,oScreenInvert)
          invertScreen.invertTime=5
          oGameCamera.shakeAmp=6; oGameCamera.shakeTime=15
          msgCreate(0,0,"Hex","Only 2 down so far? You should be better than this!",0,1,oMessagePerson,0)
          newMessage.fadingTime=110
          chain[2].bDestroyMe=1
          chains-=1
          dmgCount=0
          arcShotDelay-=15
          sliceDelay-=3
          maxSlice+=1
          pullShotDelay=1000000
          superAtkTime=0
        }
      }
      else if chains=2
      {
        if dmgCount>=5000
        {
          invertScreen=instance_create(0,0,oScreenInvert)
          invertScreen.invertTime=5
          oGameCamera.shakeAmp=6; oGameCamera.shakeTime=15
          msgCreate(0,0,"Hex","I only need 1 to keep myself shielded.",0,1,oMessagePerson,0)
          newMessage.fadingTime=100
          chain[1].bDestroyMe=1
          chains-=1
          dmgCount=0
          arcShotDelay-=15
          sliceDelay-=3
          maxSlice+=1
          pullShotDelay=180
          superAtkTime=10000
        }
      }
      else if chains=1
      {
        if dmgCount>=4000
        {
          invertScreen=instance_create(0,0,oScreenInvert)
          invertScreen.invertTime=5
          oGameCamera.shakeAmp=6; oGameCamera.shakeTime=15
          chain[0].bDestroyMe=1
          chains-=1
          dmgCount=0
          bCanTakeDamage=true
        }
      }

      //-------------------- ATTACK: ARC SHOT --------------------
      if superAtkTime=-1
      {
        if arcShotTime<10000 or arcShotTime>19999 {arcShotTime+=1}
        if arcShotTime>=arcShotDelay and arcShotTime<=arcShotDelay+100 //Spawn 8 shots
        {
          arcShotTime=10000
          var tArcShot;
          for(i=0;i<8;i+=1)
          {
            tArcShot=instance_create(x+lengthdir_x(336,180+i*45),y+lengthdir_y(336,180+i*45),oHex_First_ArcB)
            tArcShot.type=0; tArcShot.bulletSpeed=1; tArcShot.direction=i*45; tArcShot.atkPower=atkPower
          }
        }
        else if arcShotTime=10000 //Speed up shots
        {
          if point_distance(x,y,oHex_First_ArcB.x,oHex_First_ArcB.y)<272
          {
            with oHex_First_ArcB {bulletSpeed+=1}
            arcShotTime+=1
          }
        }
        else if arcShotTime=10001 //Speed up shots
        {
          if point_distance(x,y,oHex_First_ArcB.x,oHex_First_ArcB.y)<192
          {
            with oHex_First_ArcB {bulletSpeed+=1}
            arcShotTime+=1
          }
        }
        else if arcShotTime=10002 //Destroy shots
        {
          if point_distance(x,y,oHex_First_ArcB.x,oHex_First_ArcB.y)<4
          {
            with oHex_First_ArcB {instance_destroy()}
            arcShotTime=20000
          }
        }
        else if arcShotTime=20040 //Spawn 1 fast shot
        {
          var tArcShot;
          tArcShot=instance_create(x,y,oHex_First_ArcB)
          tArcShot.type=1; tArcShot.bulletSpeed=12; tArcShot.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
          tArcShot.atkPower=atkPower
          warnFrm=0; warnScl=2
          arcShotTime=0
        }

        //-------------------- ATTACK: SCREEN SLICE --------------------
        sliceTime+=1
        if sliceTime>=sliceDelay and sliceTime mod 7=0
        {
          var tRanX,tRanY,tMyLineAng,tSrnSlice;
          if random(10)>5
          {
            tRanX=oPlayer1.x+random_range(-128,128)
            tRanY=choose(0,room_height)
          }
          else
          {
            tRanX=choose(208,688)
            tRanY=oPlayer1.y+random_range(-96,96)
          }
          tMyLineAng=point_direction(tRanX,tRanY,oPlayer1.x,oPlayer1.y-26)

          tSrnSlice=instance_create(tRanX,tRanY,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng

          currSlice+=1
          if currSlice>=maxSlice
          {
            currSlice=0
            sliceTime=0
          }
        }

        //-------------------- ATTACK: PULL SHOT --------------------
        pullShotTime+=1
        if pullShotTime>=pullShotDelay
        {
          var tPullShot,tInitDir;
          tInitDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
          for(i=0;i<6;i+=1)
          {
            tPullShot=instance_create(x+lengthdir_x(352,(tInitDir+180)+(i*60)),y+lengthdir_y(352,(tInitDir+180)+(i*60)),oPassBullet)
            tPullShot.sprite_index=sEfEnergyRip; tPullShot.image_index=1; tPullShot.image_speed=0
            tPullShot.image_xscale=0.15; tPullShot.image_yscale=0.15
            tPullShot.decayTime=352; tPullShot.bulletSpeed=1; tPullShot.direction=tInitDir+(i*60); tPullShot.atkPower=atkPower
          }
          pullShotTime=0
        }
      }

      //-------------------- SPECIAL ATTACK: FAKE OUT --------------------
      if superAtkTime>=0 and superAtkTime<=9999
      {
        superAtkTime+=1
        if superAtkTime=1 //Start attack
        {
          arcShotTime=0
          with oHex_First_Chain {for(i=0;i<6;i+=1) {resType[i]=2}}
          with oHex_First_ArcB {instance_destroy()}
          with oPassBullet {instance_destroy()}
          tile_layer_hide(1000001)
          for(i=0;i<4;i+=1)
          {
            with (250836+i) {y-=1000}
          }
        }
        else if superAtkTime=110 //Hex taunt
        {
          msgCreate(0,0,"Hex","Let's try something else.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if superAtkTime=150 //Warnings
        {
          var tWarn;
          tWarn=instance_create(272,288,oMisc)
          tWarn.sprite_index=sWarningSymbol; tWarn.type=1
          tWarn=instance_create(624,288,oMisc)
          tWarn.sprite_index=sWarningSymbol; tWarn.type=1
        }
        else if superAtkTime=200 //Spawn spikes
        {
          var tEffect;
          for(i=0;i<7;i+=1)
          {
            tEffect=instance_create(216+(i*16),296,oEffect)
            tEffect.sprite_index=sSamusSMissileEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.2+random(0.2)
            tEffect=instance_create(584+(i*16),296,oEffect)
            tEffect.sprite_index=sSamusSMissileEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.2+random(0.2)

            instance_create(208+(i*16),288,oMarioSpikeFloor)
            instance_create(576+(i*16),288,oMarioSpikeFloor)
            with oMisc {instance_destroy()}
          }
        }

        if superAtkTime=310 {spcAtkApos=272; spcAtkAMax=14}
        else if superAtkTime=360 {spcAtkCpos=0; spcAtkCMax=14}
        else if superAtkTime=400 {spcAtkDpos=room_height; spcAtkDMax=14}
        else if superAtkTime=440 {spcAtkBpos=624; spcAtkBMax=14}

        else if superAtkTime=460 {spcAtkCpos=0; spcAtkCMax=14}
        else if superAtkTime=480 {spcAtkApos=272; spcAtkAMax=14}
        else if superAtkTime=510 {spcAtkBpos=624; spcAtkBMax=14}
        else if superAtkTime=520 {spcAtkDpos=room_height; spcAtkDMax=14}

        else if superAtkTime=540 {spcAtkCpos=0; spcAtkCMax=14}
        else if superAtkTime=580 {spcAtkBpos=624; spcAtkBMax=14}
        else if superAtkTime=590 {spcAtkApos=272; spcAtkAMax=14}
        else if superAtkTime=610 {spcAtkDpos=room_height; spcAtkDMax=14}

        else if superAtkTime=770 or superAtkTime=900
        {
          if superAtkTime=900 {spcAtkMod=3}
          spcAtkApos=272; spcAtkAMax=14
          spcAtkCpos=0; spcAtkCMax=14
          spcAtkDpos=room_height; spcAtkDMax=14
          spcAtkBpos=624; spcAtkBMax=14
        }
        else if superAtkTime=1000 //End attack
        {
          var tFlash,tEffect;
          tFlash=instance_create(0,0,oScreenFlash)
          tFlash.image_alpha=0.2; tFlash.fadeSpeed=0.01
          tile_layer_show(1000001)
          for(i=0;i<4;i+=1)
          {
            with (250836+i) {y+=1000}
          }
          with oHex_First_Chain {for(i=0;i<6;i+=1) {resType[i]=3}}
          superAtkTime=-1
        }

        if superAtkTime>=220 and spcAtkAMax>0 and superAtkTime mod spcAtkMod=0 //Lines - Top
        {
          var tMyLineAng,tSrnSlice;
          tMyLineAng=point_direction(448,0,spcAtkApos,room_height)

          tSrnSlice=instance_create(448,0,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng
          spcAtkApos+=24; spcAtkAMax-=1
        }
        if superAtkTime>=260 and spcAtkCMax>0 and superAtkTime mod spcAtkMod=0 //Lines - Right
        {
          var tMyLineAng,tSrnSlice;
          tMyLineAng=point_direction(688,176,208,spcAtkCpos)

          tSrnSlice=instance_create(688,176,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng
          spcAtkCpos+=24; spcAtkCMax-=1
        }
        if superAtkTime>=300 and spcAtkDMax>0 and superAtkTime mod spcAtkMod=0 //Lines - Left
        {
          var tMyLineAng,tSrnSlice;
          tMyLineAng=point_direction(208,176,688,spcAtkDpos)

          tSrnSlice=instance_create(208,176,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng
          spcAtkDpos-=24; spcAtkDMax-=1
        }
        if superAtkTime>=340 and spcAtkBMax>0 and superAtkTime mod spcAtkMod=0 //Lines - Down
        {
          var tMyLineAng,tSrnSlice;
          tMyLineAng=point_direction(448,room_height,spcAtkBpos,0)

          tSrnSlice=instance_create(448,room_height,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng
          spcAtkBpos-=24; spcAtkBMax-=1
        }
      }
      //-------------------- SPECIAL ATTACK: HEX CIRCLE SPAM --------------------
      if superAtkTime>=10000
      {
        superAtkTime+=1
        if superAtkTime=10001 //Start attack
        {
          arcShotTime=0
          with oHex_First_Chain {for(i=0;i<6;i+=1) {resType[i]=2}}
          with oHex_First_ArcB {instance_destroy()}
          tile_layer_hide(1000001)
          for(i=0;i<4;i+=1)
          {
            with (250836+i) {y-=1000}
          }
        }
        else if superAtkTime=10100 //Hex taunt
        {
          msgCreate(0,0,"Hex","I'm sure you remember this attack. Remember, no dashing through these.",0,1,oMessagePerson,0)
          newMessage.fadingTime=130
        }
        else if superAtkTime=10230 //Hex Circle Spawn
        {
          tSrnSlice=instance_create(448,240,oHex_First_HC)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=0; tSrnSlice.spinSpd=6; tSrnSlice.bDestroyOnSize=0
        }
        else if superAtkTime=10400 //Hex Circle Spawn
        {
          tSrnSlice=instance_create(448,240,oHex_First_HC)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=90; tSrnSlice.spinSpd=6; tSrnSlice.bDestroyOnSize=0
        }
        else if superAtkTime=10560 //Hex Circle Spawn
        {
          tSrnSlice=instance_create(448,240,oHex_First_HC)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=180; tSrnSlice.spinSpd=6; tSrnSlice.bDestroyOnSize=0
        }

        if superAtkTime>=10770 and superAtkTime<=11130 and superAtkTime mod 60=0 //Hex Circle Spawn
        {
          tSrnSlice=instance_create(448,240,oHex_First_HC)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=spcAtkHCAng; tSrnSlice.spinSpd=-4; tSrnSlice.bDestroyOnSize=1
          spcAtkHCAng+=30
        }

        if superAtkTime=11190 //Talk
        {
          msgCreate(0,0,"Jeremy","No more of that.",0,0,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if superAtkTime=11250 //Talk
        {
          msgCreate(0,0,"Hex","Clever...",0,0,oMessagePerson,0)
          newMessage.fadingTime=50
        }
        else if superAtkTime=11300 //End attack
        {
          var tFlash,tEffect;
          tFlash=instance_create(0,0,oScreenFlash)
          tFlash.image_alpha=0.2; tFlash.fadeSpeed=0.01
          tile_layer_show(1000001)
          for(i=0;i<4;i+=1)
          {
            with (250836+i) {y+=1000}
          }
          with oHex_First_Chain {for(i=0;i<6;i+=1) {resType[i]=3}}
          superAtkTime=-1
        }
      }
    }
    else if chains=0 //Last phase
    {
      lastPhaseTime+=1
      if lastPhaseTime=1
      {
        arcShotTime=0
        with oPassBullet {instance_destroy()}
        with oHex_First_ArcB {instance_destroy()}
        if global.bBossGallery=1
        {
          bossRoomTally(27)
          global.newMapX=360; global.newMapY=848; room_goto(rBossGallery)
        }
      }
      else if lastPhaseTime=30 {image_index=1}
      else if lastPhaseTime>=61 and lastPhaseTime<=124 {y+=1} //Float down
      else if lastPhaseTime>=161 and lastPhaseTime<=200
      {
        if lastPhaseTime mod 2=0 {x+=1} else {x-=1}
      }
      else if lastPhaseTime=201 //Wing spread
      {
        wingFrm=0
        var tEffect,tXspd;
        for(i=0;i<32;i+=1)
        {
          tXspd=random_range(-4,4)
          tEffect=instance_create(x+random_range(-3,3),y+random_range(-12,12),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sHex_A_EfFeather; tEffect.image_blend=image_blend
          tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=-tXspd*9
          tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        }
      }
      else if lastPhaseTime=207 {wingFrm=1}
      else if lastPhaseTime=213 {wingFrm=2}
      else if lastPhaseTime=250 //Talk
      {
        msgCreate(0,0,"Hex","I told you it was foolish to come here.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if lastPhaseTime=340 {image_index=1; wingFrm=1}
      else if lastPhaseTime=360 {wingFrm=0}
      else if lastPhaseTime=380 //Talk
      {
        msgCreate(0,0,"Hex","It's time I end this little charade.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if lastPhaseTime=460 //Wing spread
      {
        global.bCanGameOver=false
        global.bRecordHits=0
        image_index=2; wingFrm=2
        featherDir=0
        var tEffect,tXspd;
        for(i=0;i<32;i+=1)
        {
          tXspd=random_range(-4,4)
          tEffect=instance_create(x+random_range(-3,3),y+random_range(-12,12),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sHex_A_EfFeather; tEffect.image_blend=image_blend
          tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=-tXspd*9
          tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        }
      }
      else if lastPhaseTime>=461 and lastPhaseTime<=999 //Spam forever / Check player health
      {
        if lastPhaseTime>900 {lastPhaseTime=451}
        if lastPhaseTime mod 5=0
        {
          var tFeatherAtk,tInitDir;
          tInitDir=0
          for(i=0;i<20;i+=1)
          {
            tFeatherAtk=instance_create(x,y,oPassBullet)
            tFeatherAtk.sprite_index=sHex_A_FeatherAtk; tFeatherAtk.atkPower=atkPower
            tFeatherAtk.decayTime=-100; tFeatherAtk.bulletSpeed=8; tFeatherAtk.direction=featherDir+tInitDir
            tInitDir+=360/20
          }
          featherDir+=5
        }

        if oPlayer1.life<=0 and oPlayer1.state=oPlayer1.STANDING //End fight
        {
          with oPassBullet {instance_destroy()}
          with oAttackBase {instance_destroy()}
          lastPhaseTime=1000
          oEvCh10MainA.sceneProgress=1
        }
      }
      if life<1500 {life=1500}
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x+4,y-9,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x-4,y-9,-1,1,image_angle,image_blend,image_alpha)
}
event_inherited()
if arcShotTime>=20001
{
  warnFrm+=1
  warnScl-=0.04
  draw_sprite_ext(sMMcharging,warnFrm,x,y,warnScl,warnScl,0,c_white,1)
}

if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x+2,y-3,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x-2,y-3,-1,1,image_angle,image_blend,image_alpha)
}
