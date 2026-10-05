#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if type=2 {x-=5*gDeltaTime}
//else if type=3 {x+=5*gDeltaTime}
if type=2 {x-=5} //60fps change: this alarm runs once (a one-time placement offset), so it must not be scaled; it was placed 2.5/3.75px off at 60/120fps
else if type=3 {x+=5} //60fps change: see above
