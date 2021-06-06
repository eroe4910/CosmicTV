class Viewfinder
{
  Explorer location;
  RotLump lens;
  MeteredFloat zoom;
  MeteredFloat tilt;
  float fov;
  
  Viewfinder()
  {
    location=new Explorer();
    lens=new RotLump();
    zoom=new MeteredFloat(1.+random(5.),1e-2+random(4e-2));
    tilt=new MeteredFloat(random(TWO_PI),1e-2+random(4e-2));
    fov=PI/3.;
  }
  
  void update()
  {
    location.update();
    lens.update();
    zoom.update();
  }
  
  float centerX()
  {
    return location.getX();
  }
  float centerY()
  {
    return location.getY();
  }
  float getZ()
  {
    return location.getZ();
  }
  float[] getPosition()
  {
    return location.getPosition();
  }
  float[] getOrientation()
  {
    return location.getOrientation();
  }
  float distortion(float x, float y)
  {
    return lens.distortion(x,y);
  }
  
  float aperture()
  {
    return fov/2.;
  }
  float zoomFactor()
  {
    return (.1+abs(zoom.getVal()));
  }
}
