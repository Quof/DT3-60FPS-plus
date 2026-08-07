///scrPadBindName(argument0)
var b;
b=argument0
if b=-1 {return "---"}
if b<=31 {return "BTN "+string(b)}
if b=101 {return "POV UP"}
if b=102 {return "POV RIGHT"}
if b=103 {return "POV DOWN"}
if b=104 {return "POV LEFT"}
if b=111 {return "STICK LEFT"}
if b=112 {return "STICK RIGHT"}
if b=113 {return "STICK UP"}
if b=114 {return "STICK DOWN"}
if b=115 {return "LT"}
return "RT"
