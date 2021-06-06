color bFilter(float xN,float yN,float angleMod)
{
  float xLoc=0.;
  float yLoc=0.;
  float satMax=0.;
  float stratow=0.;
  float sumOpacity=1.;//could be.1 for blending
  for(int k=0; k<mySystems.length; k++)
  {
    //so I want to rotate both positions by the camera angle for that pixel, which is modified by fov and distortion
    //then I use the relative position just as I'm using it now, more or less. But I get a relative position for each lumpform. the angle from the camera to the pixel remains constant (that's the ray cast)
    //so for each form, I find the XY distance between the relative position and the ray cast to that depth. so XYZ,theta -> XY,Z*theta
    float[] index=mySystems[k].dEX(myView.getPosition(),myView.getOrientation(),xN,yN,angleMod);
    if(index[3]!=-1.)
    {  
      /*float thisH;
      
      thisH=TWO_PI*index[0];
      xLoc+=index[3]*cosLookup(thisH);
      yLoc+=index[3]*sinLookup(thisH);*/
      satMax=index[1];//+=index[3]*index[1];
      stratow=index[2];//*index[3];//+=index[3]*index[2];
      xLoc=index[0];
      //sumOpacity+=index[3];
      
    }
  
  }
  satMax/=sumOpacity;
  stratow/=sumOpacity;
  float myNewHue=atanLookup(xLoc,yLoc)/TWO_PI;
  
  color myC=color(xLoc,satMax,stratow);
  //color myC=color(myNewHue,satMax,stratow);
  
  return myC;
}
