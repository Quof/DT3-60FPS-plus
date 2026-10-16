//Randomizer: what the Item Finder finds in the room (oIdentifier's user event 0, once a room): any location still there
//(keys and heart containers too, which the game's own alert leaves out). Returns 0 none, 1 an item, 2 an item that
//opens the way on (an ability, an ability set's item or a key; in an Archipelago game, one the multiworld marks as
//progression)
var tFind,tObj,i;
tFind=0
tObj[0]=oHeartPiece; tObj[1]=oMoneyChest; tObj[2]=oArrowQuiver; tObj[3]=oHeartEnergy; tObj[4]=oMissilePack
tObj[5]=oGamePower; tObj[6]=oAirUpgrade; tObj[7]=oWalletBoost; tObj[8]=oWeaponLevelUpgrade; tObj[9]=oAPBoost
tObj[10]=oLinkBombUpgrade; tObj[11]=oMorphBombUpgrade; tObj[12]=oDoorKey; tObj[13]=oHeartContainer
tObj[14]=oMMBoostedCharge; tObj[15]=oMetPick_SpringBall; tObj[16]=oRndStory //(the story's ability pickups' places)
for(i=0;i<17;i+=1)
{
  with (tObj[i])
  {
    if variable_local_exists("rndLoc")
    {
      if rndLoc>=0
      {
        if !rndIsGot(rndLoc)
        {
          if tFind=0 {tFind=1}
          if global.rndAP=1
          {
            if global.rndApLocKnown[rndLoc]=1 {if global.rndApLocFlags[rndLoc] mod 2=1 {tFind=2}}
          }
          else if global.rndItemProg[rndPlaced(rndLoc)]>0 {tFind=2}
        }
      }
    }
  }
}
return tFind
