/*
input bleed change (added): called by the player (characterStepEvent, charJeremyStepEvent) when it starts reading its
buttons again after a stretch of not reading them (the game paused for dialogue, a menu or a shop; the travel cannon;
hiding). A button that's held now but wasn't held when it stopped reading was pressed in the meantime, so the press
belongs to whatever was open (it advanced the dialogue or closed the menu): it's locked, reading as let go, until it's
actually let go (scrButtonLocked). This stopped A advancing the last line of dialogue from also jumping, and B leaving a
shop from also using Action C when Action C is on B. Buttons held from before (a jump, a charge) carry on as before.
*/
var c,tWas;
for(c=5;c<=14;c+=1)
{
  if c<=10 or c>=13
  {
    if c=5 {tWas=kJump}
    else if c=6 {tWas=kActA}
    else if c=7 {tWas=kActB}
    else if c=8 {tWas=kActC}
    else if c=9 {tWas=kCharSwap}
    else if c=10 {tWas=kAbilSwap}
    else if c=13 {tWas=kDashLeft}
    else {tWas=kDashRight}
    kBtnLock[c]=0
    if tWas=0 {kBtnLock[c]=scrButtonHeldDirect(c)}
  }
}
