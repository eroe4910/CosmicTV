class RotLump
{
  Lump myLump;
  MeteredFloat myRotation;
  
  float[] lensData;
  MeteredFloat lensDisGranularity;
  
  RotLump()
  {
    myLump=randomLump();
    myRotation=new MeteredFloat(random(TWO_PI),(1e-4)+random(4e-4));
    lensData=new float[100];
    lensDisGranularity=new MeteredFloat(random(10),(1e-3)+random(4e-3));
    distortionPrep();//if you never run this to initialize lensData, for some reason the program still runs and you get a really cool-looking error. No idea how it works, though. 
  }
  
  void update()
  {
    myRotation.update(0.,TWO_PI);
    lensDisGranularity.update();
    distortionPrep();
  }
  
  int getLength()
  {
    return myLump.getLength();
  }
  
  float getRadius(float ang)
  {
    return myLump.getRadius(ang+myRotation.getVal());
  }
  float getRadiusAt(int spot)
  {
    return myLump.getRadius(spot,myRotation.getVal());
  }
  
  float getRotation()
  {
    return myRotation.getVal();
  }
  
  float stratify(float val)
  {
    return myLump.stratify(abs(val),0);
  }
  
  void distortionPrep()
  {
    lensData[0]=0.;
    for(int i=1; i<lensData.length; i++)
    {
      lensData[i]=lensData[i-1]+getRadiusAt(i-1)+getRadiusAt(i);
    }
  }
  
  float distortion(float x, float y)
  {
    float hypo=distance(x,y,0,0)/(1+abs(lensDisGranularity.getVal()));
    int distortionLayers=(int)hypo;
    float dis=0.;
    if(distortionLayers>=lensData.length)
    {
      dis+=lensData[lensData.length-1]*(distortionLayers-distortionLayers%lensData.length)/lensData.length;
      distortionLayers%=lensData.length;
    }
    dis+=lensData[distortionLayers]+(hypo-(float)((int)hypo))*(getRadiusAt(distortionLayers)+getRadiusAt(distortionLayers+1));
    if(hypo>0.){dis/=hypo;}
    return dis;
  }
}
