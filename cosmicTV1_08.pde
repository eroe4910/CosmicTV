
import com.hamoid.*;
int frameCounter=0;
//------------------------------------------------------------------------
float hueDisp;
PImage output;

VideoExport vOut;
//------------------------------------------------------------------------

void settings()
{
  size(vW,vH);
}

void setup()
{
  initializeTrigLookup();
  
  colorMode(HSB,1,1,1);
  output=createImage(vW,vH,ARGB); 
  
  if(vidOut)
  {
    vOut=new VideoExport(this,targetFolder+".mp4"); 
    vOut.setFrameRate(12); 
    vOut.startMovie();
  }
  
  mNum=mNumI(mNum.length,mNum[0].length);
  
  noStroke();
  fill(0,100,90);
  background(255);
  
  for(int i=0; i<myMeters.length; i++)
  {
    myMeters[i]=new Meter();
  }
  for(int i=0; i<myLumps.length; i++)
  {
    myLumps[i]=new Lump();
  }
  for(int i=0; i<myPainters.length; i++)
  {
    myPainters[i]=new Painter();
  }
  for(int i=0; i<myMasks.length; i++)
  {
    myMasks[i]=new Mask();
  }
  for(int i=0; i<mySystems.length; i++)
  {
    mySystems[i]=new LumpSystem();
  }
  myView=new Viewfinder();
  println("all set");
}

//------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------


void draw()
{
  background(0.,0.,0.);
  if(alternateBlackFrames==false||frameCounter%2==0)
  {  
    myView.update();  
    for(int j=0; j<rate; j++)
    {
      if(j==0 && prior>0){j--; prior--;println(prior);}
      if(rate>9 && (rate-j)%5==0){println("--"+(rate-j)+"--");}
      for(int i=0; i<myPainters.length; i++){myPainters[i].update();}
      for(int i=0; i<myMeters.length; i++){myMeters[i].update();}
      time.note();
      for(int i=0; i<myMasks.length; i++){myMasks[i].update();}
      time.note(12);
      for(int i=0; i<mySystems.length; i++){mySystems[i].update();}
    }
  alga();
  image(output,0,0);
  }
  
  frameCounter++;
  println(frameCounter);
  time.print();
    
  if(vidOut){vOut.saveFrame();}
    
  if(frameCounter>=frames)
  {
    end();
  }
    
}


void keyPressed()
{
  if(key=='q'){end();}
}

void end()
{
  println("saving files and shutting down");
  if(vidOut)
  { 
    vOut.endMovie();
  }
  exit();
}
