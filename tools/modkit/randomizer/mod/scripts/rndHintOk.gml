//Randomizer: whether a vending machine's hint (oVendingMachine) can be about location argument0: not taken yet, not
//hinted yet (rndHinted), and its item a progression item (rndProgOf: an ability or set, the Varia Suit, a key, a
//Program Chip, a cursed equipment piece; an instrument only with Instrument Randomization, else each is at its own
//gate's reward). In an Archipelago game, its item as the client scouted it, progression (flags 1), the player's own
//(argument1 0) or another world's (1)
var i,it,k;
i=argument0
if string_char_at(global.rndHinted,i+1)="1" {return 0}
if rndIsGot(i) {return 0}
if global.rndAP=1
{
  if global.rndApLocKnown[i]!=1 {return 0}
  if (global.rndApLocFlags[i] & 1)=0 {return 0}
  if argument1=0 {return global.rndApLocOwn[i]=1}
  return global.rndApLocOwn[i]!=1
}
it=rndPlaced(i)
k=global.rndItemKind[it]
if k=26 and global.rndIRMode=0 {return 0}
return rndProgOf(k,global.rndItemParam[it])>0
