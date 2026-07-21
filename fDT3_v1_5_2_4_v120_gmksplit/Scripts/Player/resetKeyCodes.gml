/* !scriptId=141 */
//Resets all keystates to neutral
//use: resetKeyCodes()
//returns: nothing

for(i=1;i<=12;i+=1)
{
  //oKeyCodes.kCode[i]=1
  oKeyCodes.kCodePressed[i]=0
}

/*
kLeft=0
kRight=0
kUp=0
kDown=0

kJump=0
kJumpPressed=0

kCharSwap=0
kCharSwapPressed=0
kAbilSwap=0
kAbilSwapPressed=0

kActA=0
kActAPressed=0
kActB=0
kActBPressed=0
kActC=0
kActCPressed=0

kRun=0
