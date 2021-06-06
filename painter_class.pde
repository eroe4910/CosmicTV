
//----------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------
class Painter
{
  //location of Painter
  float xPos;
  float yPos;
  
  //how much the Painter affects the values it "paints"
  MeteredFloat magnitude;
  MeteredFloat size;
  //how far the Painter travels each time it moves
  MeteredFloat speed;
  
  RotLump shape; //used to determine shape of stamp
  
  //array of probabilities for different moves, based on history of prior moves
  float[][][] mArray;
  
  //history of prior moves
  float[] moveList;
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  Painter()
  {
    refresh();
  }
  
  void refresh()
  {
    int history=(int)random(10);
    moveList=new float[history];
    if(history>0){for(int i=0; i<history; i++){moveList[i]=-1;}}
    
    moveArray();
    xPos=random(-totalR,totalR);
    yPos=random(-totalR,totalR);
    magnitude=new MeteredFloat(random(-opLim,opLim),(1e-2)+random(4e-2));
    size=new MeteredFloat(random(dotLim),(1e-2)+random(4e-2));
    speed=new MeteredFloat(random(-speedLim,speedLim),(1e-2)+random(4e-2));
    shape=new RotLump();
  }
  
  void update()
  {
    shape.update();
    magnitude.update();
    size.update();
    speed.update();
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  float getX()
  {
    return xPos;
  }
  float getY()
  {
    return yPos;
  }
  float getMagnitude()
  {
    return magnitude.getVal();
  }
  float getSize()
  {
    return abs(size.getVal())%dotLim;
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  void move(float dir)
  {
    //records the movement in the record, swapPIng out a value because the record only contains 5 values
    if(moveList.length>0)
    {
      if(moveList[moveList.length-1]!=-1)
      {
        for(int i=0; i<moveList.length-1; i++){moveList[i]=moveList[i+1];}
        moveList[moveList.length-1]=dir;
      }
      else
      {
        boolean done=false;
        for(int i=0; i<moveList.length; i++)
        {
          if(done==false && moveList[i]==-1){moveList[i]=dir; done=true;}
        }
      }
    }
    xPos+=(int)(speed.getVal()*cosLookup(dir));
    yPos+=(int)(speed.getVal()*sinLookup(dir));
  }
  
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  void moveController()
  {
    float randF=random(1);
    float lBar=0;
    int mType=-1;
    int m2Type=-1;
    
    if(moveList.length>0)
    {
      if(moveList[moveList.length-1]==-1){mType=1;}
      else
      {
        for(int i=0; i<mArray[0].length; i++)
        {
          lBar+=mArray[0][i][0];
          if(randF<=lBar &&mType==-1){mType=i+1;}
        }
      }
    }
    else
    {
      mType=1;
    }
    
    randF=random(1);
    lBar=0;
    
    if(mType>0)
    {
      for(int i=0; i<mArray[mType].length; i++)
      {
        lBar+=mArray[mType][i][0];
        if(randF<=lBar &&m2Type==-1){m2Type=i;}
      }
      if(mType==1 && m2Type>=0){move(mArray[mType][m2Type][1]);}
      else if(mType>1 && m2Type>=0){move(mArray[mType][m2Type][1]+moveList[m2Type%moveList.length]);}
    }
    else
    {
      println("error: freeze");
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------------
//moveArray takes the name string, sends it to mRandom to get a set of probabilities, then shrinks the probabilities so they all add up to 1.
  void moveArray()
  {
    int name=lib();
    float[][][] myArray=new float[2+name%historyMax][][];
    for(int i=0; i<myArray.length; i++)
    {
      if(i>1)
      {  
        myArray[i]=new float[1+(name%mNum[i][0])%anglesMax][2];
      }
      else if(i>0)
      {
        myArray[i]=new float[1+name%anglesMax][2];
      }
      else
      {
        myArray[i]=new float[myArray.length-1][2];
      }
      int maxFill=(int)1e5;
      for(int j=0; j<myArray[i].length; j++)
      {
        if(j<myArray[i].length-1)
        {
          myArray[i][j][0]=(name%mNum[i][j]%maxFill); 
          maxFill-=myArray[i][j][0];
        }
        else
        {
          myArray[i][j][0]=maxFill;
        }
        myArray[i][j][0]/=(int)1e5;
        myArray[i][j][1]=(name%mNum[i][j]%(int)(2000*PI))*1e-3;
      }
    }
    mArray=myArray;
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------------------------------------------------------------------

  //given a Painter's coordinates, and the grid's dimensions, the Painter is drawn as an ellipse

  
  boolean stamp(float x, float y)
  {
    float pTest=distance(x,y,0,0); 
    float lumpRadius=abs(size.getVal()*shape.getRadius(atanLookup(x-xPos,y-yPos)));
    if(pTest<=lumpRadius)
    {
      return true;
    }
    else{return false;}
  }
}
