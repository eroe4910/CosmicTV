
class LumpForm
{
  RotLump[][] lumps;//first two for shape, third through fifth as stratification filters for our masks
  
  Mask[] masks;
  MeteredFloat[][] maskDisplacement;
  
  
  LumpForm()
  {
    lumps=new RotLump[][]{{new RotLump(),new RotLump(),new RotLump()},
                          {new RotLump(),new RotLump(),new RotLump(),new RotLump()},
                          {new RotLump(),new RotLump(),new RotLump(),new RotLump()}};
    
    masks=new Mask[]{randomMask(),randomMask(),randomMask(),randomMask()};
    maskDisplacement=new MeteredFloat[4][2];
    for(int i=0; i<4; i++)
    {
      for(int j=0; j<2; j++){maskDisplacement[i][j]=new MeteredFloat(random(-100,100),random(1));}
    }
  }
  
 //---------------------------------------------------------------------------------------------------------------------------------------------------------
 
  void update()
  {
    for(int i=0; i<lumps.length; i++)
    {
      for(int j=0; j<lumps[i].length; j++)
      {
        lumps[i][j].update();
      }
    }
    for(int i=0; i<4; i++)
    {
      //for(int j=0; j<2; j++){maskDisplacement[i][j].update(0.,masks[i].getLimit());}
    }
  }
 //---------------------------------------------------------------------------------------------------------------------------------------------------------
 
  float rangeF(float ang)
  {
    //ang=inBounds(ang,0.,TWO_PI);
    return .5*(lumps[0][0].getRadius(ang)+lumps[0][1].getRadius(ang));
  }
  float range3D(float[] ang)
  {
    return 1.*(lumps[0][0].getRadius(ang[0])+lumps[0][1].getRadius(ang[1])+lumps[0][2].getRadius(ang[2]));
  }
  
  /*float texture3D(float[] ang, float distance)
  {
    for(int i=0; i<lumps[0][0].getLength()/2; i++)
    {
      //okay so I need to go step by step, use the sin to get the z-distance, then cos for the range (we've isolated one angle, and loop through the other two simultaneously?
      //for each step that is unsuccessful (range<distance) we add the distance between that layer and the next to our texture vector. 
    }
    
  }*/
 //---------------------------------------------------------------------------------------------------------------------------------------------------------
  
  float[] dEX(float[] myPosition, float[] myAngle, float range, float zMod, float xN,float yN)
  {
    
    //ang=inBounds(ang,0.,TWO_PI);
    float[]results={0.,0.,0.,0.};
    
    float[]lumpPosition=rotate3D(new float[]{0.,range,0.},myAngle);//not sure if using myAngle here is right...
    float zTemp=zMod*(10.+abs(myPosition[2]+lumpPosition[2]));
    float x2N=myPosition[0]-xN*zTemp;
    float y2N=myPosition[1]-yN*zTemp;
    float tempAngle=myAngle[1]-atanLookup(x2N-lumpPosition[0],y2N-lumpPosition[1]);
    float distance=distance(lumpPosition[0],lumpPosition[1],x2N,y2N);
    
    float xRatio=(x2N-lumpPosition[0])/distance;
    float yRatio=(y2N-lumpPosition[1])/distance;
    
    
    float myRange=range*range3D(new float[]{myAngle[0],tempAngle,myAngle[2]});//not sure what is quite the right way to get what I'm looking for, but this is worth a try
    time.note(4);
    if(distance<myRange)
    {
      //zTemp=zMod*(10.+abs(abs(myPosition[2]+lumpPosition[2])-sqrt(sq(myRange)-sq(distance))/myRange*range/8.*range3D(new float[]{myAngle[0]+(xRatio*.5*PI*(myRange-distance)/myRange),tempAngle,myAngle[2]+(yRatio*.5*PI*(myRange-distance)/myRange)})))/zTemp;
      zTemp=zMod*(10.+abs(abs(myPosition[2]+lumpPosition[2])-sqrt(sq(myRange)-sq(distance))/myRange*range/8.*range3D(new float[]{myAngle[0]+(xRatio*.5*PI),tempAngle,myAngle[2]+(yRatio*.5*PI)})))/zTemp;
      
      //float distance2=distance*zTemp;
      //now we find the location of our point relative to our lumpform
      x2N=(cosLookup(tempAngle)*distance);
      y2N=(sinLookup(tempAngle)*distance);
      time.note(5);
      for(int i=0; i<4; i++)
      {
        //for each of our four masks(hue, saturation, brightness and opacity) we rotate and stretch the point we previously calculated.
        float cosTemp=cosLookup(lumps[2][i].getRotation()-tempAngle);
        float sinTemp=sinLookup(lumps[2][i].getRotation()-tempAngle);
        time.note(6);
        float stretch=lumps[1][(i+1)%4].getRadius(myAngle[1]);
        x2N=(x2N*cosTemp-y2N*sinTemp)*stretch;
        y2N=(y2N*cosTemp+x2N*sinTemp)*stretch;
        time.note(7);
        stretch=sq(lumps[1][i].distortion(x2N,y2N))/zTemp;
        x2N*=stretch;
        y2N*=stretch;
        time.note(8);
        //using our new location, we take the value at that location on our hexagonal grid mask and "stratify" it; this striates the values into bands of values between 0 and 1.
        results[i]=lumps[2][i].stratify(masks[i].getValue(x2N+maskDisplacement[i][0].getVal(),y2N+maskDisplacement[i][1].getVal()));
        time.note(9);
      }
      //results[2]*=sq((myRange-distance)/myRange);
    }
    return results;
  }
}
