#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y+=4
if global.gameOptDT>=3 and global.bBossGallery=0 {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instance_exists(oSandCrawlerBoss)
  {
    if oSandCrawlerBoss.biteTime=-1
    {
      if point_distance(oSandCrawlerBoss.x,0,oPlayer1.x,0)<24 or oSandCrawlerBoss.bossProgress=0
      {
        oSandCrawlerBoss.x=oPlayer1.x
        oSandCrawlerBoss.y=y+(16*image_yscale)
        oSandCrawlerBoss.biteTime=0
      }
    }
  }
}
