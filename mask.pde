
class Mask
{
  Hexgrid map;
  Painter [] myPainters;
  
  Mask()
  {
    map=new Hexgrid();
    myPainters=new Painter[20+(int)random(20)];
    for(int i=0; i<myPainters.length; i++)
    {
      myPainters[i]=randomPainter();
    }
  }
  
  void update()
  {
    for(int i=0; i<myPainters.length; i++)
    {
      myPainters[i].moveController();
      plot(i);
    }
  }
  
  void plot(int choice)
  {
    for(float i=-myPainters[choice].getSize()/2.; i<=myPainters[choice].getSize()/2.; i+=1.)
    {
      for(float j=-myPainters[choice].getSize()/2.; j<=myPainters[choice].getSize()/2.; j+=1.)
      {
        if(myPainters[choice].stamp(i,j))
        {
          map.adjustValue((int)(i+myPainters[choice].getX()),(int)(j+myPainters[choice].getY()),myPainters[choice].getMagnitude());
        }
      }
    }
  }
  
  float getValue(float X, float Y)
  {
    return map.valForPoint(X,Y);
  }
  
  float getLimit()
  {
    return map.getLimit();
  }
 
}
