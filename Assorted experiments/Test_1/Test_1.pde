void setup () {
  size(400, 400);
  i = 0;
}

int i;

float[] v1 = {1, 2, 3};
float[] n = {1, 0, 0};
int[] un = {1,0,0};
float[] dv = {0, 0, 0};


static float d2r(float deg) {
  return deg*PI/180;
}

static float r2d(float rad) {
  return rad*180/PI;
}



void draw() {
  background(255, 255, 255);

  //println(d2r(30));

  //http://home.scarlet.be/math/rmk.htm#Projection-of-a-vect

  //Project vector onto plane
  float dotp = v1[0]*n[0]+v1[1]*n[1]+v1[2]*n[2];
  float lenf = sqrt(pow(n[0], 2)+pow(n[1], 2)+pow(n[2], 2));
  float[] p = {dotp/pow(lenf, 2)*n[0], 
               dotp/pow(lenf, 2)*n[1], 
               dotp/pow(lenf, 2)*n[2]  };
  
  float[] dv = {v1[0]-p[0], 
                v1[1]-p[1], 
                v1[2]-p[2], };
    
  //Rotate camera
  n[0] = sin(d2r(i));
  n[1] = cos(d2r(i));
  

  //Rotate vectors to unit
  float rz = 0;
  float ry = 0;
  float nx;
  float vx;
  float vy;
  float vx2;
  float vz;

  //Calculate Y rotation
  if (n[0]+n[1] != 0) {
    rz= -asin(n[1]/sqrt(pow(n[0], 2)+pow(n[1], 2)));
  }

  nx = n[0]*cos(rz)-n[1]*sin(rz);

  //Calculate Y rotation
  if (n[0]+n[2] != 0) {
    ry= -asin(n[2]/sqrt(pow(nx, 2)+pow(n[2], 2)));
  }
  
  //Rotate vectors
  //Rotate on Z-axis
  vx = dv[0]*cos(rz)-dv[1]*sin(rz);
  vy = dv[0]*sin(rz)+dv[1]*cos(rz);
  
  //Rotate on Y-axis
  vx2 = vx*cos(ry)-dv[2]*sin(ry);
  vz = vx*sin(ry)+dv[2]*cos(ry);
  
 
  //Draw lines
  for (int i = 0; i < 5; i++) {
    line( width/2, 
      height/2, 
      vy*-10+width/2, 
      vz*-10+height/2 );
  }
  i++;
  
  
}