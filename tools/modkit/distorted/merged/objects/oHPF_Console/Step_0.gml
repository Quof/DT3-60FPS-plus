if global.gamePaused=false
{
  screenFrm+=0.25*gDeltaTime
  if bActivate=1
  {
    if type=0 //Energy bridge
    {
      image_blend=make_color_rgb(200,255,200)
      with controlID
      {
        instance_destroy()
      }
      bActivate=2
    }
    else if type=1 //Door
    {
      image_blend=make_color_rgb(200,255,200)
      if controlID.progCheck=0 {controlID.progCheck=1}
    }
    else if type=2 //Door & Laser Turrets
    {
      if turretProg=0 //Activate turrets and door
      {
        image_blend=make_color_rgb(200,255,200)
        if controlID.progCheck=0 {controlID.progCheck=1}
        for(i=0;i<turMax;i+=1)
        {
          with turID[i]
          {
            event_user(0)
          }
        }
        turretProg=1
        //spsp ns
        if room=rHPF_H and x>500 //start clock
        {
          var tTimer;
          tTimer=instance_create(204,312,oScreenTimer)
          tTimer.type=2; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
          global.forceTime=4*60*30-(2400+900*global.bNightmareMode) //leeway of at least ~1000 frames with regular damage; +30s on nightmare
        }
      }
      else if turretProg=1 //Check if all turrets(enemies) are destroyed
      {
        var tTurCheck;
        tTurCheck=0
        for(i=0;i<turMax;i+=1)
        {
          if !instance_exists(turID[i]) {tTurCheck+=1}
        }
        if tTurCheck>=turMax
        {
          with controlID {instance_destroy()}
          turretProg=2
          with oScreenTimer {instance_destroy()} //spsp ns
        }
        else if room=rHPF_H and x>500 //spsp ns
        {
          if global.forceTime<=0 and rude=0
          {
            instance_create(oPlayer1.x+64,returnPlayerYCenter(),oBloodVirus)
            instance_create(oPlayer1.x-64,returnPlayerYCenter(),oBloodVirus)
            instance_create(oPlayer1.x,returnPlayerYCenter()+64,oBloodVirus)
            instance_create(oPlayer1.x,returnPlayerYCenter()-64,oBloodVirus)
            instance_create(oPlayer1.x+160,returnPlayerYCenter()+160,oBloodVirus)
            instance_create(oPlayer1.x-160,returnPlayerYCenter()-160,oBloodVirus)
            instance_create(oPlayer1.x+160,returnPlayerYCenter()-160,oBloodVirus)
            instance_create(oPlayer1.x-160,returnPlayerYCenter()+160,oBloodVirus)
            rude=1
        }
      }
    }
  }
}
}
