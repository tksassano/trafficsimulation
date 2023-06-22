class StopSign implements RoadObj {
  Road parent;
  float pos;
  String state;
  StopSign(Road parent, float pos){
    this.parent = parent;
    this.pos = pos;
    this.state = "active";
  }
  
  String getState(){
    return state; 
  }
  String getType(){
    return "StopSign";
  }
  
  float getPos(){
   return pos; 
  }
  
  void update(){
    //no logic needed for a stopsign
  }
  
  void display(){
   fill(255,50,50);
   stroke(255,50,50);
   line(parent.x - 17.5, pos, parent.x - 17.5 + 50 * parent.lanes.size(),pos); 
   textSize(25);
   text("STOP", parent.x + 50 * parent.lanes.size(),pos);
  }
}
