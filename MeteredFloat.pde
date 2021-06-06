class MeteredFloat
{
  float myVal;
  float changeCoefficient;
  float decay;
  Meter myMeter;
  
  MeteredFloat(float val, float coefficient)
  {
    myVal=val;
    changeCoefficient=coefficient;
    myMeter=randomMeter();
    decay=1.;
  }
  
  MeteredFloat(float val, float coefficient, float dCoefficient)
  {
    myVal=val;
    changeCoefficient=coefficient;
    myMeter=randomMeter();
    decay=dCoefficient;
  }
  
  void update()
  {
    myVal+=myMeter.getVelocity()*changeCoefficient;
    myVal*=decay;
  }
  
  void update(float min, float max)
  {
    update();
    //myVal=inBounds(myVal,min,max);
  }
  
  float getVal()
  {
    return myVal;
  }
  
}
