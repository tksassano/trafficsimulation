class Driver {
  
  float lastSwitchTime;
  float switchCooldown;
  Car thisCar;
  Lane transitionLane, laneToSwitch;
  Driver(Car thisCar) {
    this.thisCar = thisCar;
    
    lastSwitchTime = 0;
    switchCooldown = 3.0;
  }

  Car getFrontCar(Lane checkLane) {
    Car frontCar = null;
    float closestDistance = Float.POSITIVE_INFINITY;
    for (Car car : checkLane.carArray) {
      if (car != thisCar) {
        float distance = thisCar.position.y - car.position.y;
        if (distance < closestDistance && distance > 0) {
          closestDistance = distance;
          frontCar = car;
        }
      }
    }

    return frontCar;
  }

  Car getRearCar(Lane checkLane) {
    Car rearCar = null;
    float closestDistance = Float.POSITIVE_INFINITY;

    for (Car car : checkLane.carArray) {
      if (car != thisCar) {
        float distance = thisCar.position.y - car.position.y;
        if (distance < closestDistance && distance < 0) {
          closestDistance = distance;
          rearCar = car;
        }
      }
    }


    return rearCar;
  }
  
  float calculateSafeDistance(float fSpeed,float carLength) {
     float reactionTime = 1.0;
    float followingDistance = thisCar.speed * reactionTime;
    float bufferDistance = 10.0;

    if (thisCar.speed > 0 && fSpeed > 0) {
        float decelerationDistance = (thisCar.speed * thisCar.speed) / (2 * thisCar.maxAcceleration) -
                                     (fSpeed * fSpeed) / (2 * thisCar.maxAcceleration);
        return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else if (thisCar.speed > 0 && fSpeed == 0) {
        float decelerationDistance = (thisCar.speed * thisCar.speed) / (2 * thisCar.maxAcceleration);
        return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else {
        return bufferDistance + carLength;
    }
  }
  
  float calculateSafeDistance(Car frontCar) {
    float dist = calculateSafeDistance(frontCar.speed,frontCar.h);

    return dist;
  }

  boolean canSwitchLane(Lane laneToSwitch) {
    float tolerance = 1;
    if (laneToSwitch == null) {
      return false;
    }
    Car frontCarInTargetLane = getFrontCar(laneToSwitch);
    Car rearCarInTargetLane = getRearCar(laneToSwitch);

    if (frontCarInTargetLane != null) {
      float frontDistance = thisCar.position.dist(frontCarInTargetLane.position);
      if (frontDistance < calculateSafeDistance(frontCarInTargetLane) * 2 || abs(frontCarInTargetLane.speed - thisCar.speed) < tolerance) {
        return false;
      }
    }

    if (rearCarInTargetLane != null) {
      float rearDistance = thisCar.position.dist(rearCarInTargetLane.position);
      if (rearDistance < calculateSafeDistance(rearCarInTargetLane) * 2 || abs(rearCarInTargetLane.speed - thisCar.speed) < tolerance) {
        return false;
      }
    }

    return true;
  }

  float getAccelPID(float safeDist, float dist) {
        float P_d = 0.01;
        float A_d = min(-P_d * (safeDist - dist), thisCar.maxAcceleration);
        float speed_limit = thisCar.lane.parent.speedLimit;
        float P_v = 0.01;
        float A_v = -P_v * (speed_limit - thisCar.speed);
        float A = min(A_d,  thisCar.maxAcceleration); 
        
        return A;
  }
  void think() {
    objActions();
    normActions();
  }
  
  void objActions(){
    for (RoadObj obj : thisCar.lane.parent.objs){
      float dist = thisCar.position.y - obj.getPos();
      switch(obj.getType()){
        case "StopSign":
          if(dist > 30) {
             thisCar.queueForce(getAccelPID(calculateSafeDistance(0,15),dist),1);
          }
          break;
        case "TrafficLight":
          if(obj.getState() == "red" && dist > 0) {
             thisCar.queueForce(getAccelPID(calculateSafeDistance(0,15),dist),1);
          } else if(obj.getState() == "yellow" && dist > thisCar.speed - thisCar.maxAcceleration) {
             thisCar.queueForce(getAccelPID(calculateSafeDistance(0,15),dist),1);
          }
          break;
      }
    }
  }
  
  
  void normActions() {
   Car frontCar = getFrontCar(thisCar.lane);
    if (frontCar == null) {
      thisCar.queueForce(thisCar.maxAcceleration,1);
    } else {
      float distance = thisCar.position.dist(frontCar.position);
      float safeDistance = calculateSafeDistance(frontCar);
      if (distance < safeDistance) {
        //TRANSITION STATES
        if (transitionLane == null) {
            if (canSwitchLane(thisCar.lane.left)) {
              laneToSwitch = thisCar.lane.left;
              lastSwitchTime = millis();
            } else if (canSwitchLane(thisCar.lane.right)) {
              laneToSwitch = thisCar.lane.right;
              lastSwitchTime = millis();
            }
        }
        //CANNOT SWITCH LANES

        thisCar.queueForce(getAccelPID(safeDistance,distance),1);
      } else {
        thisCar.queueForce(thisCar.maxAcceleration,1);
      }
    } 
    
  }




}
