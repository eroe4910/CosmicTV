class Explorer
{
  MeteredFloat velocity;
  MeteredFloat oVel;
  MeteredFloat[]theta;
  MeteredFloat[]orientation;
  float[] position;
  float[] oPosition;
  
  Explorer()
  {
    position=new float[]{random(-totalR,totalR),random(-totalR,totalR),random(-totalR,totalR)};
    oPosition=new float[]{random(TWO_PI),random(TWO_PI),random(TWO_PI)};
    velocity=new MeteredFloat(random(-4,4),1.,.7);
    oVel=new MeteredFloat(random(-.4,.4),.01,.7);
    theta=new MeteredFloat[]{new MeteredFloat(random(TWO_PI),.01),new MeteredFloat(random(TWO_PI),.01),new MeteredFloat(random(TWO_PI),.01)};
    orientation=new MeteredFloat[]{new MeteredFloat(random(TWO_PI),.01),new MeteredFloat(random(TWO_PI),.01),new MeteredFloat(random(TWO_PI),.01)};
  }
  
  void update()
  {
    velocity.update();
    println(velocity.getVal());
    oVel.update();
    for(int i=0; i<3; i++)
    {
      theta[i].update(0.,TWO_PI);
      orientation[i].update(0.,TWO_PI);
    }
    float[]vVector={0.,velocity.getVal(),0.};
    float[]angVector={theta[0].getVal(),theta[1].getVal(),theta[2].getVal()};
    position=vectorAdd(position,rotate3D(vVector,angVector));
    for(int i=0; i<3; i++){position[i]*=.9999;}
    
    vVector[1]=oVel.getVal();
    angVector=new float[]{orientation[0].getVal(),orientation[1].getVal(),orientation[2].getVal()};
    oPosition=vectorAdd(oPosition,rotate3D(vVector,angVector));
    
  }
  
  float getX()
  {
    return position[0];
  }
  float getY()
  {
    return position[1];
  }
  float getZ()
  {
    return position[2];
  }
  float[] getPosition()
  {
    return new float[]{position[0],position[1],position[2]};
  }
  float[] getOrientation()
  {
    return new float[]{oPosition[0],oPosition[1],oPosition[2]};
    //return new float[]{orientation[0].getVal(),orientation[1].getVal(),orientation[2].getVal()};
  }
}
