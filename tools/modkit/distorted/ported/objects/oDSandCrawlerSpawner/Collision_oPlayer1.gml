if global.gamePaused=false
{
  if !instance_exists(oSandCrawler)
    instance_create(oPlayer1.x,oPlayer1.y,oSandCrawler)
}
