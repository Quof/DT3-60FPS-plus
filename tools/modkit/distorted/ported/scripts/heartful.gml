//this is a script
/*
example:
heartful(x,y,direction,speed,colour,decay)
*/

/// RECALCULATE X POINTS!!

var y_offset;
y_offset=-0.5

var x_values,y_values,coordinates,direction_offsets;
x_values[0]=0
x_values[1]=0.285
x_values[2]=0.57
x_values[3]=0.855
x_values[4]=1.14

// x0
y_values[0]=1+y_offset
y_values[1]=-1+y_offset
// x1
y_values[2]=1.2+y_offset
y_values[3]=-0.766+y_offset
//x2
y_values[4]=1.234+y_offset
y_values[5]=-0.547+y_offset
//x3
y_values[6]=1.137+y_offset
y_values[7]=-0.2365+y_offset
//x4
y_values[8]=0.545+y_offset
y_values[9]=0.545+y_offset

// starting from the bottom apple, going counterclockwise
// negative x = left, negative y = down
// [a,0] = x, [a,1] = y
coordinates[0,0]=x_values[0]
coordinates[0,1]=y_values[1]
coordinates[1,0]=x_values[1]
coordinates[1,1]=y_values[3]
coordinates[2,0]=x_values[2]
coordinates[2,1]=y_values[5]
coordinates[3,0]=x_values[3]
coordinates[3,1]=y_values[7]
coordinates[4,0]=x_values[4]
coordinates[4,1]=y_values[8]
coordinates[5,0]=x_values[3]
coordinates[5,1]=y_values[6]
coordinates[6,0]=x_values[2]
coordinates[6,1]=y_values[4]
coordinates[7,0]=x_values[1]
coordinates[7,1]=y_values[2]
coordinates[8,0]=x_values[0]
coordinates[8,1]=y_values[1]
coordinates[9,0]=-x_values[1]
coordinates[9,1]=y_values[2]
coordinates[10,0]=-x_values[2]
coordinates[10,1]=y_values[4]
coordinates[11,0]=-x_values[3]
coordinates[11,1]=y_values[6]
coordinates[12,0]=-x_values[4]
coordinates[12,1]=y_values[8]
coordinates[13,0]=-x_values[3]
coordinates[13,1]=y_values[7]
coordinates[14,0]=-x_values[2]
coordinates[14,1]=y_values[5]
coordinates[15,0]=-x_values[1]
coordinates[15,1]=y_values[3]

var start_x,start_y,heartpoint,heartspeed,heartcolour,heartdecay;

start_x=argument0
start_y=argument1
heartpoint=argument2
heartspeed=argument3
heartcolour=argument4
heartdecay=argument5

var iter,zero_dir,speed_mod,this_dir,apple;

//zero_dir=point_direction(0,0,coordinates[0,0],coordinates[0,1])
zero_dir=90 // turned around by default! (math coords vs GML coords)

for(iter=0;iter<16;iter+=1)
{
    speed_mod=point_distance(0,0,coordinates[iter,0],coordinates[iter,1])
    this_dir=point_direction(0,0,coordinates[iter,0],coordinates[iter,1])-90
    apple=instance_create(start_x,start_y,heartcolour)
    //apple.bulSpd=heartspeed*speed_mod; apple.direction=heartpoint+this_dir; apple.decay=heartdecay; apple.type=0
    apple.bulSpd=heartspeed*speed_mod; apple._direction=heartpoint+this_dir; apple.decay=heartdecay; apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
}

/*speed_mod=point_distance(0,0,coordinates[0,0],coordinates[0,1])
apple=instance_create(start_x,start_y,heartcolour)
apple.bulSpd=heartspeed*speed_mod; apple.direction=heartpoint; apple.decay=heartdecay; apple.type=0*/
