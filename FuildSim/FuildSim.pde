int iter = 16;
int N = 128;
int SCALE = 4;
float t = 0;

Fluid fluid;

boolean centerStream = true;

void settings() {
  size(N*SCALE, N*SCALE);
}

void setup() {
  fluid = new Fluid(0.2, 0, 0.0000001);
  fluid.colourFlow = false;
}

void randomFluid(float x, float y) {
  int cx = int(x / SCALE);
  int cy = int(y / SCALE);
  
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      fluid.addDensity(cx+i, cy+j, random(50, 150));
    }
  }
  
  for (int i = 0; i < 2; i++) {
    float angle = noise(t) * TWO_PI * 2;
    PVector v = PVector.fromAngle(angle);
    v.mult(0.2);
    t += 0.01;
    fluid.addVelocity(cx, cy, v.x, v.y);
  }
}

void mouseDragged() {
  randomFluid(mouseX, mouseY);
}

void draw() {
  background(0);
  
  if (centerStream)
    randomFluid(0.5 * width, 0.5 * height);

  fluid.step();
  fluid.renderD();
}
