class Simulator {
  Car[] carArray;
  int carIndex;
  
  Simulator(){
    carArray = new Car[1000];
    carIndex = 0;
  }
  
  void createCar(){
    carArray[carIndex] = new Car(width/2, height - 100, 30, 20, 0, 1.5, 0, 0.01, 270);
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
