void alga()
{ 
    int pixelCounter=0;
    
    output.loadPixels();
    
    for(int i=0; i<vH; i++)
    {
      for(int j=0; j<vW; j++)
      {
        if(alternateBlackFrames && frameCounter%2==1)
        {
          output.pixels[pixelCounter]=color(0,0,0);
        }
        else
        {
          float xN=(float)(j-vW/2)/((float)(vW/2));
          float yN=(float)(i-vH/2)/((float)(vH/2));
          float pitch=1.;//sq(myView.distortion(xN,yN))*myView.zoomFactor();
          //float angleMod=sin(myView.fov*atan(yN/xN)*2./PI);
          //float tilt=distance((float)j,(float)i,(float)vW/2.,(float)vH/2.)/distance((float)vW/2.,(float)vH/2.,0,0)
          //float otherAngle=atan2(yN,xN);
          float tilt=distance(xN,yN,0,0);
          float angleMod=cos(myView.fov*atan(tilt)*2./PI);
          
          time.note();
          color myC=bFilter(xN*pitch,yN*pitch,angleMod);
       
          output.pixels[pixelCounter]=myC;
        }
        pixelCounter++;
      }
    }
    output.updatePixels();
    if(vidOut==false)
    {    
      output.save(targetFolder+"/"+disp(frameCounter+1)+(frameCounter+1)+".png");
    }
}
