// spsp
// Turn off if below a health threshold. Revive time handled in the step event.
// Also, dead hands = lower melee resist for the main body. Done for both main and body just in case.
if life<=dead
{
    bCanDealDamage=false; bCanTakeDamage=false
    with oEnmityHand
    {
        if life<=dead
        {
            oEnmityBody.resType[0]+=1
            oEnmity.resType[0]+=1
        }
    }
}
