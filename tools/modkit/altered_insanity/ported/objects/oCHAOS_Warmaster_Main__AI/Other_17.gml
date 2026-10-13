///SET CHANGE ORDER
var tMakeOrder;
tMakeOrder=1
if oPlayer1.x<=xCenter {tMakeOrder=1}
if oPlayer1.x<=xCenter-(roomSpan/2) {tMakeOrder=2}
if oPlayer1.x>=xCenter {tMakeOrder=3}
if oPlayer1.x>=xCenter+(roomSpan/2) {tMakeOrder=4}

if tMakeOrder=1
{
  orderSet[0]=1
  orderSet[1]=2
  orderSet[2]=3
  orderSet[3]=4
}
else if tMakeOrder=2
{
  orderSet[0]=1
  orderSet[1]=4
  orderSet[2]=3
  orderSet[3]=2
}
else if tMakeOrder=3
{
  orderSet[0]=1
  orderSet[1]=3
  orderSet[2]=2
  orderSet[3]=4
}
else if tMakeOrder=4
{
  orderSet[0]=1
  orderSet[1]=4
  orderSet[2]=2
  orderSet[3]=3
}
