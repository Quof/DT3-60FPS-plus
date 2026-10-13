if global.gamePaused=false
{
    if timeToDecide = 0
    {
          //RANDOM CRYPTIC MESSAGE
          var ranMessage;
    
          ranMessage=irandom_range(1,22)
          if ranMessage=1 {msg="ENJOY YOUR STAY"}
          if ranMessage=2 {msg="DON'T BLAME ME"}
          if ranMessage=3 {msg="TRY TO SURVIVE"}
          if ranMessage=4 {msg="GET YOUR WEAPONS READY"}
          if ranMessage=5 {msg="BE ATTITUDE FOR GAINS"}
          if ranMessage=6 {msg="NO ESCAPE FROM CROSSING FATE"}
          if ranMessage=7 {msg="ARE YOU A BAD ENOUGH DUDE"}
          if ranMessage=8 {msg="JUST JUMP JUMP"}
          if ranMessage=9 {msg="GET READY"}
          if ranMessage=10 {msg="LET'S DDR"}
          if ranMessage=11 {msg="WARMASTER WAS SUMMONED"}
          if ranMessage=12 {msg="KEEP YOUR DIGNITY"}
          if ranMessage=13 {msg="ARE YOU A BAD ENOUGH DUDE?"}
          if ranMessage=14 {msg="STRONGERS ARE WAITING"}
          if ranMessage=15 {msg="IT CAN'T BE HELPED"}
          if ranMessage=16 {msg="RIP AND TEAR UNTIL IT IS DONE"}
          if ranMessage=17 {msg="HEAD FOR THE GARDEN OF MADNESS"}
          if ranMessage=18 {msg="DIPLOMACY HAS FAILED ONCE AGAIN"}
          if ranMessage=19 {msg="OPEN COMBAT"}
          if ranMessage=20 {msg="RULES OF NATURE"}
          if ranMessage=21 {msg="KEEP YOUR DIGNITY"}
          if ranMessage=22 {msg="BATTLE ROUTINE SET"}
        if (oPlayer1.x > centerPoint)
        {
            oNPC_C5ChallengeMaster.path = 1
            path = 1
        }
        else
        {
            oNPC_C5ChallengeMaster.path = 2
            path = 2
        }
    }
    if timeToDecide < -60
    {
        instance_destroy();
    }
    //timeToDecide-=1
    timeToDecide-=1*gDeltaTime //60fps change: per frame (whole numbers of steps, so it still lands on 0)
}
