//1m = 4000p
//1h = fps * 3600s
//1mph = (800p / (fps * 3600s)) ppf
int PIXELS_PER_MILE = 4000;

Simulator sim;
float timelapse = 1;
int fps = 60;

void setup() {
  frameRate = fps;
  size(800, 800);
  background(0);
  imageMode(CENTER);
  sim = new Simulator(3600, timelapse, 1.5, 0.02);
}

void draw() {
  background(0);
  sim.display();
  sim.inflow();
  sim.update();
}

float mphToPpf(float speedInMph) {
  float conversionFactor = PIXELS_PER_MILE / (fps * 60.0 * 60.0);
  float speedInPpf = speedInMph * conversionFactor * timelapse;
  return speedInPpf;
}

float ppfToMph(float speedInPpf) {
  float conversionFactor = (fps * 60.0 * 60.0) / PIXELS_PER_MILE;
  float speedInMph = speedInPpf * conversionFactor / timelapse;
  return speedInMph;
}

float mphPerSecToPpfPerFrame(float accelerationInMphPerSec) {
  float conversionFactor = PIXELS_PER_MILE / (fps * fps * 60.0 * 60.0);
  float accelerationInPpfPerFrame = accelerationInMphPerSec * conversionFactor * timelapse;
  return accelerationInPpfPerFrame;
}

float ppfPerFrameToMphPerSec(float accelerationInPpfPerFrame) {
  float conversionFactor = (fps  * fps * 60.0 * 60.0) / PIXELS_PER_MILE;
  float accelerationInMphPerSec = accelerationInPpfPerFrame * conversionFactor / timelapse;
  return accelerationInMphPerSec;
}
