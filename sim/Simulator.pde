class Simulator {
  Car[] carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float maxSpeed;
  float maxAcceleration;
  
  Simulator(int inflow_, float timelapse_, float maxSpeed_, float maxAcceleration_){
    carArray = new Car[1000];
    carIndex = 0;
    inflow = round(1. / hoursToFrames(inflow_));
    println(inflow);
    timelapse = timelapse_;
    maxSpeed = maxSpeed_;
    maxAcceleration = maxAcceleration_;
  }
  
  void inflow(){
    if (frameCount % inflow == 0){
      createCar();
    }
  }
  
  void createCar(){
    carArray[carIndex] = new Car(width/2, height+40, 30, 20, 1, 1.5, 0.01, 0.02, 270);
    carIndex ++;
  }
  
  void display(){
    for (int i = 0; i < carIndex; i++){
      carArray[i].display();
    }
  }
  
  void update(){
    for (int i = 0; i < carIndex; i++){
      carArray[i].update();
    }    
  }
}
