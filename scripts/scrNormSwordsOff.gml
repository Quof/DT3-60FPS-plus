/*
normalized gallery change (added): takes the sword equipment (Magic Sword 1, Sword of Bravery 2, Power Glove 3) off
Jerry and Claire; it goes back to the item list (global.equipItems "1": owned, not equipped). Used in the boss gallery
while its lever (oGalleryLever) is on: rBossGallery's creation code and the lever. The pause menu won't put it back on
in there (scrNormSwordBlocked); anywhere else it can be.
*/
var i,tItem;
for(i=0;i<3;i+=1)
{
  tItem=global.equipJerry[i]
  if tItem>=1 and tItem<=3
  {
    global.equipItems=string_delete(global.equipItems,tItem,1)
    global.equipItems=string_insert("1",global.equipItems,tItem)
    global.equipJerry[i]=0
  }
  tItem=global.equipClaire[i]
  if tItem>=1 and tItem<=3
  {
    global.equipItems=string_delete(global.equipItems,tItem,1)
    global.equipItems=string_insert("1",global.equipItems,tItem)
    global.equipClaire[i]=0
  }
}
