myColor=colorSet
//if myColor=1 {baseColor=c_red; image_blend=baseColor}
//else if myColor=2 {baseColor=c_blue; image_blend=baseColor}
//else if myColor=3 {baseColor=c_green; image_blend=baseColor}
//else if myColor=4 {baseColor=c_yellow; image_blend=baseColor}
if myColor>=1 and myColor<=4 {baseColor=global.czColor[myColor]; image_blend=baseColor} //color zone change: matches its zone's color (Color Zone Colors option)
