
float[]arcTanLookupTable=new float[8192];
float[]sinLookupTable=new float[4096];
float[]cosLookupTable=new float[4096];
final float lookupMod=4096./TWO_PI;

void initializeTrigLookup()
{
  for(int i=0; i<sinLookupTable.length; i++)
  {
    sinLookupTable[i]=sin(((float)i)/lookupMod);
    cosLookupTable[i]=cos(((float)i)/lookupMod);
  }
  for(int i=0; i<arcTanLookupTable.length; i++)
  {
    arcTanLookupTable[i]=atan(((float)i)/((float)arcTanLookupTable.length));
  }
}

float sinLookup(float theta)
{
  int index=(int)(lookupMod*theta);
  //float interpolate=(lookupMod*theta)-(float)index;
  return sinLookupTable[intBounds(index,0,sinLookupTable.length)];//*(1.-interpolate)+sinLookupTable[intBounds(index+1,0,sinLookupTable.length)]*interpolate;
}

float cosLookup(float theta)
{
  int index=(int)(lookupMod*theta);
  //float interpolate=(lookupMod*theta)-(float)((int)index);
  return cosLookupTable[intBounds(index,0,cosLookupTable.length)];//*(1.-interpolate)+cosLookupTable[intBounds(index+1,0,cosLookupTable.length)]*interpolate;
}

float atanLookup(float x,float y)
{
  time.note();
  if(x==0 && y==0){return 0.;}
  
  float theta=0.;//we're going to do some transformations to get our angle into the first octant of the unit circle. We record our transformations here so that we can negate them later. 
  if(y<0)
  {
    //rotate from third or fourth quadrants into first or second, respectively
    theta+=PI;
    x=-x;
    y=-y;
  }
  if(x<=0)
  {
    //rotate from second quadrant to first. Remember, this works because we already eliminated the possibility of our angle being in the third or fourth quadrants!
    theta+=0.5*PI;
    float temp=x;
    x=y;
    y=-temp;
  }
  if(x<=y)
  {
    //rotate from second to first octant
    theta+=0.25*PI;
    float temp=y-x;
    x+=y;
    y=temp;
    //this is cool: normally, the conversion would have us divide both terms by sqrt(2), but since we're dealing with a tangent, the coefficient doesn't matter!
  }
  //theta+=binarySearchPlus(atanLookupTable,y/x,1,1)*atanMod;
  float lookupIndex=y/x*(float)arcTanLookupTable.length;
  float lookupInterpolate=lookupIndex-(float)((int)lookupIndex);
  if((int)lookupIndex==arcTanLookupTable.length-1){theta+=arcTanLookupTable[(int)lookupIndex]*(1.-lookupInterpolate)+(PI*.25*lookupInterpolate);}
  else
  {
    theta+=arcTanLookupTable[(int)lookupIndex%arcTanLookupTable.length]*(1.-lookupInterpolate)+arcTanLookupTable[(int)(lookupIndex+1)%arcTanLookupTable.length]*lookupInterpolate;
  }
  return theta;
}
