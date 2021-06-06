
class LumpSystem
{
  MeteredFloat range;
  MeteredFloat scale;
  RotLump stretch;
  Explorer location;
  LumpForm[] lumpFormsInSystem;
  float colorShift;
  float colorRange;
  
  LumpSystem()
  {
    range=new MeteredFloat(200.+random(400),(5e-2)+random(2e-1));
    scale=new MeteredFloat(random(0,5),(1e-3)+random(4e-3));
    stretch=new RotLump();
    location=new Explorer();
    lumpFormsInSystem=new LumpForm[3];
    for(int i=0; i<lumpFormsInSystem.length; i++)
    {
      lumpFormsInSystem[i]=new LumpForm();
    }
    colorShift=random(1.);
    colorRange=random(1.);
  }
//----------------------------------------------------------------------------------------------------------------------------------------------------------
  void update()
  {
    //range.update();
    scale.update();
    stretch.update();
    location.update();
    for(int i=0; i<lumpFormsInSystem.length; i++)
    {
      lumpFormsInSystem[i].update();
    }
  }
  
//----------------------------------------------------------------------------------------------------------------------------------------------------------
  float[] dEX(float[] camera, float[] rotation,float xN,float yN,float angleMod)
  {
    float[]results={0.,0.,0.,0.};
    float[] myPosition=location.getPosition();
    myPosition=vectorSubtract(myPosition,camera);
    myPosition=rotate3D(myPosition,rotation);
    int overlaps=0;
    //if(myPosition[2]>0)
    //{
    float[] myAngle=vectorSubtract(location.getOrientation(),rotation);
    
    for(int i=0; i<lumpFormsInSystem.length; i++)
    {
      if(results[3]!=-1.){
      //float zMod=angleMod*(10.+myPosition[2]);
      //float x2N=myPosition[0]-xN*zMod;
      //float y2N=myPosition[1]-yN*zMod;
      float dis=(float)i+1.;//sq(stretch.distortion(x2N,y2N));//make sure this can't ever be 0
      float[] tempResult=lumpFormsInSystem[i].dEX(myPosition,myAngle,range.getVal()*dis,angleMod,xN,yN);
      if(tempResult[3]>0){results=resultCombine(results,tempResult); overlaps++;}
      myAngle=vectorAdd(myAngle,new float[]{0.,TWO_PI/lumpFormsInSystem.length,0.});
      time.note(10);
      }
    }
    //}
    if(results[3]>0 && overlaps>0.)
    {
      results[0]/=results[3];
      results[0]=inBounds(results[0]*colorRange+colorShift,colorShift,colorShift+colorRange);
      results[1]/=results[3];
      results[2]/=results[3];
      //if(abs(myPosition[2])/totalR<0.1){results[3]*=10.*myPosition[2]/totalR;}
    }
    else{results[3]=-1;}
    return results;
  }
 
 
//----------------------------------------------------------------------------------------------------------------------------------------------------------
  float[] resultCombine(float[] resultA,float[] resultB)
  {
    resultA[0]+=resultB[0]*resultB[3];
    resultA[1]+=resultB[1]*resultB[3];
    resultA[2]+=resultB[2]*resultB[3];
    resultA[3]+=resultB[3];
    return resultA;
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------
  float[] getPosition()
  {
    return location.getPosition();
  }

}
