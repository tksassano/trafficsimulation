class Road {
 ArrayList<Lane>lanes = new ArrayList<Lane>(); 
 int inflow;
 int x;
 int carIndex;
 float timelapse;
 float speedLimit;
 
 Road(int x, int numLanes,int vph, float timelapse, int speedLimit){
   carIndex = 0;
   inflow = round(1. / (float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse));
   this.timelapse = timelapse;
   this.speedLimit = mphToPpf(speedLimit);
   Lane lastLane = null;
   for(int i = 0; i < numLanes; i++){
     Lane newLane = new Lane(this,x+50*i,lastLane,null);
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
     lane.behavior();
     lane.display();
   }
 }
  
  
}
