final int[] powersTen=new int[]{1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000};
//----------------------------------------------------------------------------------------------------------------------------------------------------------
float power10(int a)
{
  if(a<10){return (float)powersTen[a];}
  else{return (float)powersTen[9]*power10(a-9);}
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
String disp(int num)
{
  if(num<10){return "0000";}
  else if(num<100){return "000";}
  else if(num<1000){return "00";}
  else if(num<10000){return "0";}
  else{return "";}
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
float distance(float x1, float y1, float x2, float y2)
{
  return sqrt(sq(x2-x1)+sq(y2-y1));
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
int lib()
{
  //some preset strings to put in fields at start
  return (int)(random(1e9)+random(1e9)+1e6);
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------
Meter randomMeter()
{
  return myMeters[(int)random(myMeters.length)];
}

Painter randomPainter()
{
  return myPainters[(int)random(myPainters.length)];
}

Mask randomMask()
{
  return myMasks[(int)random(myMasks.length)];
}

Lump randomLump()
{
  return myLumps[(int)random(myLumps.length)];
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
int intBounds(int val, int min, int max)
{
  //if(val<min && min-val<max-min){val+=max-min;}
  if(val<min){val+=(max-min)*(1+(min-val)/(max-min));}
  if(val>=max){val=val%(max-min)+min;}
  return val;
}
float inBounds(float val, float min, float max)
{
  //if(val<min && min-val<max-min){val+=max-min;}
  if(val<min){val+=(max-min)*(float)(1+(int)((min-val)/(max-min)));}
  if(val>=max){val=val%(max-min)+min;}
  return val;
}
