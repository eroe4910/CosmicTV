float[]vectorAdd(float[]v1,float[]v2,float mod)
{
  float[] results=new float[v1.length];
  if(v1.length==v2.length)
  {
    for(int i=0; i<v1.length; i++)
    {
      results[i]=v1[i]+v2[i]*mod;
    }
  }
  return results;
}
float[]vectorAdd(float[]v1,float[]v2)
{
  return vectorAdd(v1,v2,1.);
}
float[]vectorSubtract(float[]v1,float[]v2)
{
  return vectorAdd(v1,v2,-1.);
}


float[][]matrixAdd(float[][]m1,float[][]m2,float mod)
{
  float[][] results=new float[m1.length][];
  if(m1.length==m2.length && m1.length>0)
  {
    for(int i=0; i<m1.length; i++)
    {
      results[i]=new float[m1[i].length];
      if(m1[i].length==m2[i].length)
      {
        for(int j=0; j<m1[i].length; j++)
        {
          results[i][j]=m1[i][j]+m2[i][j]*mod;
        }
      }
    }
  }
  return results;
}

float[][] matrixAdd(float[][]m1,float[][]m2)
{
  return matrixAdd(m1,m2,1.);
}
float[][] matrixSubtract(float[][]m1, float[][]m2)
{
  return matrixAdd(m1,m2,-1.);
}

float[][] matrixMult(float[][]m1,float[][]m2)
{
  //the 2d arrays must be matrices or we will have problems! m1[0].length must equal m1[n].length!
  if(m1[0].length==m2.length)
  {
    float[][] results=new float[m1.length][m2[0].length];
    for(int i=0; i<m1.length; i++)
    {
      for(int j=0; j<m2[0].length; j++)
      {
        float product=0.;
        for(int k=0; k<m2.length; k++)
        {
          product+=m1[i][k]*m2[k][j];
        }
        results[i][j]=product;
      }
    }
    return results;
  }
  else
  {
    println("invalid matrix mult");
    return m1;
  }
}

float[] matrixMult(float[][]m1,float[]vector)
{
  float[] results=new float[m1.length];
  for(int i=0; i<m1.length; i++)
  {
    float product=0.;
    for(int j=0; j<m1[0].length; j++)
    {
      product+=m1[i][j]*vector[j];
    }
    results[i]=product;
  }
  return results;
}

float[] rotate3D(float[] position, float[] theta)
{
  /*float[][] rX={{1.,0.,0.},
                {0.,cosLookup(theta[0]),-sinLookup(theta[0])},
                {0.,sinLookup(theta[0]),cosLookup(theta[0])}};
  float[][] rY={{cosLookup(theta[1]),0.,sinLookup(theta[1])},
                {0.,1.,0.},
                {-sinLookup(theta[1]),0.,cosLookup(theta[1])}};
  float[][] rZ={{cosLookup(theta[2]),-sinLookup(theta[2]),0.},
                {sinLookup(theta[2]),cosLookup(theta[2]),0.},
                {0.,0.,1.}};*/
  float[] c={cosLookup(theta[0]),cosLookup(theta[1]),cosLookup(theta[2])};
  float[] s={sinLookup(theta[0]),sinLookup(theta[1]),sinLookup(theta[2])};
  float[][] rotation={{c[1]*c[2],-s[1],c[1]*s[2]},
                      {s[0]*s[2]+c[0]*c[2]*s[1],c[0]*c[1],c[0]*s[1]*s[2]-c[2]*s[0]},
                      {c[2]*s[0]*s[1]-c[0]*s[2],c[1]*s[0],c[0]*c[2]+s[0]*s[1]*s[2]}};
  float[] newPos={position[0],position[1],position[2]};
  newPos=matrixMult(rotation,newPos);
  //newPos=matrixMult(rY,newPos);
  //newPos=matrixMult(rX,newPos);
  return newPos;
}
