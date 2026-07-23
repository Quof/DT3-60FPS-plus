#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if current_frame mod (1/gDeltaTime) == 0 then { x-=1 } //QWH, added mod condition if statement
if x<-64
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background(backMarioWorldCloudA,x,y)
