///Dick bullet pattern
for(i=0;i<20;i+=1)
{
  //var tAtk; tAtk=instance_create(800+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+180
  var tAtk; tAtk=instance_create(800+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk._direction=(18*i)+180 //60fps change: DT3+'s Executive bullets move by their own _direction
  //var tAtk; tAtk=instance_create(928+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+180
  var tAtk; tAtk=instance_create(928+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk._direction=(18*i)+180 //60fps change: DT3+'s Executive bullets move by their own _direction
}
for(i=0;i<10;i+=1)
{
  //var tAtk; tAtk=instance_create(864+lengthdir_x(640,9+(18*i)),112+lengthdir_y(640,9+(18*i)),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+189
  var tAtk; tAtk=instance_create(864+lengthdir_x(640,9+(18*i)),112+lengthdir_y(640,9+(18*i)),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2.5; tAtk._direction=(18*i)+189 //60fps change: DT3+'s Executive bullets move by their own _direction
}
for(i=0;i<8;i+=1)
{
  //var tAtk; tAtk=instance_create(224,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=0
  var tAtk; tAtk=instance_create(224,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk._direction=0 //60fps change: DT3+'s Executive bullets move by their own _direction
  //var tAtk; tAtk=instance_create(1504,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=180
  var tAtk; tAtk=instance_create(1504,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk._direction=180 //60fps change: DT3+'s Executive bullets move by their own _direction
}


//bounce values
//y: 64, 727
//x: 704, 1024
