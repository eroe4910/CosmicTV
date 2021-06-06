
//OPTIONS

//------------------------------------------------------------------------------------------------------------------------------------------
Painter[] myPainters=new Painter[50];
Meter[] myMeters=new Meter[20];
Mask[] myMasks=new Mask[50];
Lump[] myLumps=new Lump[50];
Viewfinder myView;
LumpSystem[] mySystems=new LumpSystem[8];
Timer time=new Timer(100);

final String targetFolder = "108sample155";
boolean alternateBlackFrames=false;

final int maxStrat = 10+(int)(random(90));
final float maxValue=32768;

 int historyMax=10;
 int anglesMax=10;
//------------------------------------------------------------------------------------------------------------------------------------------

boolean vidOut=true;
//------------------------------------------------------------------------------------------------------------------------------------------
//these arrays are used for modulation.
int[][]mNum=new int[2+historyMax][anglesMax];
//------------------------------------------------------------------------------------------------------------------------------------------

float totalR=6e3;
int vW=640;//1280;
int vH=480;//960;
//------------------------------------------------------------------------------------------------------------------------------------------
final int frames=(int)1e6;
int rate=1;
int prior=0;
float mSpeed=0.01;
//------------------------------------------------------------------------------------------------------------------------------------------
//grid options

float opLim=10.+(random(51));
float shLim=10.+(random(51));
float speedLim=10.+(random(51));
float dotLim=10.+(random(51));
 
//----------------------------------------------------------------------------------------------------------------------------------------------------------
//polynomial options
int polyInitial = 10+(int)(random(100));
int polyInitialPowerScale = (int)(random(3));
int polyDegreeLimit = 1+(int)(random(10));
