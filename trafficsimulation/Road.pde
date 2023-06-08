class Road {
 ArrayList<Lane>lanes = new ArrayList<Lane>(); 
 ArrayList<RoadObj> objs = new ArrayList<>();

 int inflow;
 int carIndex;
 float timelapse;
 float speedLimit;
 float dir;
 float roadLength;
 PVector roadStart;
 
 Road(int numLanes,int vph, float timelapse, float dir, float roadLength, PVector roadStart){
   carIndex = 0;
   inflow = round(1. / (float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse));

   this.timelapse = timelapse;
   this.speedLimit = mphToPpf(speedLimit);
   this.dir = dir;
   this.roadLength = roadLength;
   this.roadStart = roadStart;
   Lane lastLane = null;
   for(int i = 0; i < numLanes; i++){
     Lane newLane = new Lane(this,lastLane, null, 30 + 5 * i, dir, height, roadStart);
     if(lastLane != null) lastLane.right = newLane;
     addLane(newLane);
     lastLane = newLane;
   }
 }
 
  void inflow() {
    if (frameCount % inflow == 0) {
      lanes.get(int(random(0,lanes.size()))).createCar();
    }
  }
 
 void addLane(Lane lane){
   lanes.add(lane);
 }
 
 void run(){
   inflow();
   for (Lane lane: lanes) {
     lane.display();

     lane.behavior();
   }
   
   for (RoadObj obj:objs) {
    obj.update();
    obj.display(); 
   }
 }
  
  
}
