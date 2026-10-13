eName=string("Lv.") +string(rpgLv) +string(" Prototype Lava Beast")
pointWorth=25+round(rpgLv/7)
if rpgLv<=9
{
  expValue=5+round(rpgLv*1.5)
  maxLife=300+round(rpgLv*6.25)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=10+(rpgLv*2)
  maxLife=340+round(rpgLv*7.5)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*3.25)
  maxLife=380+round(rpgLv*9.5)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=40+(rpgLv*5)
  maxLife=440+round(rpgLv*11.25)
}
else if rpgLv>=60
{
  expValue=50+(rpgLv*6)
  maxLife=540+round(rpgLv*12.75)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Lava Beast")
  eLevel+=1
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=6
  atkPower+=1
  baseColor=make_color_rgb(255,190,180)
  image_blend=baseColor
  jeremyText+=" This upgraded version simply has slightly higher base stats."
}
