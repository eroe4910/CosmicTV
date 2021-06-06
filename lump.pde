
class Lump
{
  float [] radii;
  
  Lump()
  {
    makeLump(2000);
  }
  
  
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  void makeLump(int num)
  {
    float[] myLump=new float[num];
    Meter[] curvatureMeters = new Meter[6];
    for(int i=0; i<curvatureMeters.length; i++)
    {
      curvatureMeters[i]=new Meter();
    }
    float mod=random(2000);
    float[] maxDifference={random(0.2),random(0.2)};
    myLump[0]=1;
    int i=1;
    boolean notFinished=true;
    while(notFinished)
    {
      float sum=0;
      for(int j=0; j<curvatureMeters.length; j++)
      {
         curvatureMeters[j].update();    
         sum+=curvatureMeters[j].getVelocity();
      }
      sum/=mod;
      if(i>=myLump.length && abs(myLump[i%myLump.length]-myLump[(i-1)%myLump.length])<sum){notFinished=false;}
      else
      {
        myLump[i%myLump.length]=myLump[(i-1)%myLump.length]+sum;
        if(myLump[i%myLump.length]>0.8){curvatureMeters[0].adjustVelocity(-maxDifference[0]);}
        if(myLump[i%myLump.length]<0.2){curvatureMeters[0].adjustVelocity(maxDifference[1]);}
        if(myLump[i%myLump.length]<0.1)
        {
          myLump[i%myLump.length]=0.1;
          for(int j=0; j<curvatureMeters.length; j++)
          {
            curvatureMeters[j]=new Meter();
          }
        }
        else if(myLump[i%myLump.length]>1)
        {
          myLump[i%myLump.length]=1.;
          for(int j=0; j<curvatureMeters.length; j++)
          {
            curvatureMeters[j]=new Meter();
          }
        }
        i++;
      }
    }
  radii=myLump;
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  float getRad (int num)
  {
    return radii[intBounds(num,0,radii.length)];
  }
  float getRadius (int num, float angle)
  {
    return getRad(num+(int)((float)radii.length*angle/TWO_PI));
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  float getRadius (float angle)
  {
    int num=(int)((float)radii.length*angle/TWO_PI);
    return getRad(num);
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  int getLength()
  {
    return radii.length;
  }
    
  float getLimit (int num)
  {
    return power10(num+2)*(sq(getRad(num))+getRad(num+1));
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  float stratify (float val, int stratum)
  {
    if(val<0){val=-val;}
    boolean working=true;
    while(working)
    {
      float limit=getLimit(stratum);
      if(val<=limit)
      {
        val/=limit;
        if(stratum%2==1){val=1.-val;}
        working=false;
      }
      else{val-=limit;}
      stratum++;
    }
    return val;
  }
  
}
