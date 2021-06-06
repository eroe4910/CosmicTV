class Meter
{
int chanceToChange;
float[] rateOfDecay;
float velocity;
float acceleration;
float accelerationBoostMagnitude;

Meter()
{
  rateOfDecay=new float[2];
  refresh();
  velocity=0;
  acceleration=0;
}

void refresh()
{
  chanceToChange=5+(int)(random(76));
  accelerationBoostMagnitude=0.01+random(.19);
  for(int i=0; i<2; i++)
  {
    rateOfDecay[i]=1+random(0.1);
  }
}

void update()
{
  if(random(chanceToChange)<1){acceleration+=random(2*accelerationBoostMagnitude)-accelerationBoostMagnitude;}
  velocity+=acceleration;
  acceleration/=rateOfDecay[0];
  velocity/=rateOfDecay[1];
}

float getVelocity()
{
  return velocity;
}

float getAcceleration()
{
  return acceleration;
}

void adjustVelocity(float amount)
{
  velocity+=amount;
}

}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
