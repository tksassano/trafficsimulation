class TrafficLight implements RoadObj {
  Road parent;
  float pos;
  String state;
  
  int timeGreen, timeRed, framesPassed;
  TrafficLight(Road parent, float pos, int timeGreen, int timeRed, String state, int framesPassed){
    this.parent = parent;
    this.pos = pos;
    this.state = state;
    this.framesPassed = framesPassed;
    this.timeGreen = timeGreen;
    this.timeRed = timeRed;
  }
  
  String getState(){
    return state; 
  }
  String getType(){
    return "TrafficLight";
  }
  
  float getPos(){
   return pos; 
  }
  
  void update(){
    framesPassed++;
    if(state == "green" && framesPassed > timeGreen){
     state = "yellow";
     framesPassed = 0;
    } else if(state == "yellow" && framesPassed > 180){
      state = "red";
      framesPassed = 0;
    } else if(state == "red" && framesPassed > timeRed){
     state = "green";
     framesPassed = 0;
    }
  }
  
  void display(){
   fill(255,150,150);
   stroke(255,50,50);
   if(state == "green") {
     fill(150,255,150);
     stroke(150,255,150);
   } else if(state == "yellow"){
     fill(255,255,150);
     stroke(255,255,150);
   }
   line(parent.x - 17.5, pos, parent.x - 17.5 + 50 * parent.lanes.size(),pos); 
   textSize(25);
   text("TR. LIGHT", parent.x + 50 * parent.lanes.size(),pos);
  }
}
