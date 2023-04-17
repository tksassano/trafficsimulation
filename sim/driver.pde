//1m = 4000p
//1h = fps * 3600s
//1mph = (800p / (fps * 3600s)) ppf
int PIXELS_PER_MILE = 8000;

float dispRadius = 100;
boolean mouseHeld = false;

Simulator sim;
float timelapse = 1;
int fps = 60;

void setup() {
  frameRate(fps);
  size(1000, 900);
  background(0);
  imageMode(CENTER);
  sim = new Simulator(4, 1800, timelapse, 80);
}

void draw() {
  background(255);
  sim.run();
  fill(255,0,0,10);
  circle(mouseX,mouseY, dispRadius);
  
}

void mousePressed() {
  mouseHeld = true;
}

void mouseReleased(){
  mouseHeld = false;
}


ArrayList<Car> CarsNearMouse(float radius){
 ArrayList<Car> CarList = new ArrayList<Car>();
 for(int i = 0; i < sim.lanes.size(); i++){
    ArrayList<Car> cArr = sim.lanes.get(i).carArray;
    for(int u = 0; u < cArr.size(); u++){
      if (cArr.get(u).position.dist(new PVector(mouseX,mouseY)) < radius) {
        CarList.add(cArr.get(u));
      }
    }
 }
 return CarList;
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

int feetToPixels(float distanceInFeet) {
  float distanceInMiles = distanceInFeet / 5280.0;
  int distanceInPixels = int(distanceInMiles * PIXELS_PER_MILE);
  return distanceInPixels;
}

float pixelsToFeet(int distanceInPixels) {
  float distanceInMiles = distanceInPixels / PIXELS_PER_MILE;
  float distanceInFeet = distanceInMiles * 5280.0;
  return distanceInFeet;
}

float roundToNearestDecimal(float num, int decimalPlace) {
  float multiplier = pow(10, decimalPlace);
  return round(num * multiplier) / multiplier;
}
