final float qConvert=1./sqrt(3);
final int maxGridDimension=500;

class Hexgrid
{
  int radius;
  int rMod;
  
  float[] vals;
  
  Hexgrid()
  {
    radius=5+(int)random(500);
    rMod=3*radius+2;
    vals=new float[3*(radius*radius+radius)+1];
    for(int i=0; i<vals.length; i++)
    {
      vals[i]=0.;
    }
  }
  
  float valForPoint(float x, float y)
  {
    float q=qConvert*x+y/3.;
    float r=2.*y/3.;
    float s=-q-r;
    
    int qRound=round(q);
    int rRound=round(r);
    int sRound=round(s);
    
    float qDif=abs(q-(float)qRound);
    float rDif=abs(r-(float)rRound);
    float sDif=abs(s-(float)sRound);
    
    if(qDif>rDif && qDif>sDif)
    {
      qRound=-rRound-sRound;
    }
    else if(rDif>sDif)
    {
      rRound=-qRound-sRound;
    }
    return getValue(qRound,rRound);
  }
  
  float getValue(int q,int r)
  {
    return vals[intBounds(rMod*q+r,0,vals.length)];
  }
  
  void adjustValue(int q,int r,float amount)
  {
    int index=intBounds(rMod*q+r,0,vals.length);
    vals[index]+=amount;
    if(abs(vals[index])>maxValue){vals[index]=0.;}
  }
  
  float getLimit()
  {
    return (float)vals.length;
  }
}
