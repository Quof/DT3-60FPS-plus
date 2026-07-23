/*
This script encrypts/decrypts data.
argument0: variable to use
argument1: 0=encrypt, 1=decrypt
*/
var returnVal,bEncrypt;
returnVal=argument0
bEncrypt=argument1

if bEncrypt=0 //encrypt
{
  returnVal=returnVal*13
  returnVal=returnVal+6
}
else //decrypt
{
  returnVal=returnVal-6
  returnVal=returnVal/13
}

return returnVal
