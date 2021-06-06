class Timer
{
  float recentTime;
  float[] timeCounts;
  
  Timer(int count)
  {
    recentTime=millis();
    timeCounts=new float[count];
    for(int i=0; i<count; i++)
    {
      timeCounts[i]=0.;
    }
  }
  
  void note()
  {
    recentTime=millis();
  }
  
  void note(int count)
  {
    timeCounts[count]+=millis()-recentTime;
    note();
  }
  
  void print()
  {
    for(int i=0; i<timeCounts.length; i++)
    {
      if(timeCounts[i]!=0){println(i+": "+(int)(timeCounts[i]/frameCount));}
    }
  }
}
