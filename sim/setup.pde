Simulator sim;
float timelapse = 1;
int fps = 60;

void setup() {
  frameRate = fps;
  size(800, 800);
  background(0);
  imageMode(CENTER);
  sim = new Simulator(1800, timelapse, 1.5, 0.02);
}

void draw() {
  background(0);
  sim.display();
  sim.inflow();
  sim.update();
}
