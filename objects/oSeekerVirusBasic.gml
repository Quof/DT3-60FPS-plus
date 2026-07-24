#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_speed=0.3

//Enemy base statistics
eName="Seeker Virus - Basic"
maxLife=100
life=maxLife
atkPower=2
bNoBonus=true
hitOneTime=0

direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
_direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)

jeremyText="Just a basic Virus instance without a host. It simply tries to go in your initial direction."
chaoText="Eww, it's all gooey like the ones we saw on the island. Wow, that seems like so long ago that we were there..."
devText="Oh wow, you scanned this thing...#Starting things off with a minigame seemed like a nifty way to start the third game. I wanted to keep it simple, yet with some sort of mechanic that I could expand upon should the minigame pop up later on..."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 {sprite_index=sVirusGelRed}
else if type=2 {sprite_index=sVirusGelBlue}
else if type=9 {image_blend=make_color_rgb(30,30,30)}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0
  {
    //speed=moveSpd
    _speed=moveSpd
    x += cos(degtorad(_direction)) * _speed * gDeltaTime
    y -= sin(degtorad(_direction)) * _speed * gDeltaTime
  }

  if x<-256 or x>room_width+256 or y<-256 or y>room_height+256
    instance_destroy()
}
else
  {speed=0; _speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitOneTime=0
{
  if global.gameProgress=2
  {
    if oEvCh1MainA.checkMinigameHit=0 and type=9
    {
      msgCreate(64,296,"Jeremy","Jerry, even though you can't move. You CAN still duck.",0,1,oMessagePerson,0)
      newMessage.fadingTime=130
      oEvCh1MainA.checkMinigameHit=1
    }
  }
  event_inherited()
  hitOneTime=1
}
