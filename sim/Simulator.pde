class Simulator {
  Car[] carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float maxSpeed;
  float maxAcceleration;
  
  Simulator(int vph, float timelapse_, float maxSpeed_, float maxAcceleration_){
    carArray = new Car[1000];
    carIndex = 0;
    inflow = round(1/(float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse_));
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
    carArray[carIndex] = new Car(width/2, height+25, 40, 70, 30, 60, 4, 6, 270);
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
  
  void printInfo(){
    if (carIndex > 0){
      carArray[0].printInfo();
    }
  }
}
