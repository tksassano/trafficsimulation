class Car {
  int w, h;
  PVector position, velocity;
  float speed, maxSpeed, angle, acceleration, maxAcceleration, accelerationTracker;
  color c;
  PVector prevPosition;
  Lane lane, transitionLane, laneToSwitch;
  Car(Lane lane, int x, int y, int w_, int h_, float mph, float maxmph, float maxAcceleration_, float angle_) {
    w = feetToPixels(w_);
    h = feetToPixels(h_);
    this.lane = lane;
    position = new PVector(x, y);
    speed = mphToPpf(mph);
    maxSpeed = mphToPpf(maxmph);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    acceleration = 0;
    maxAcceleration = mphPerSecToPpfPerFrame(maxAcceleration_);
    c = color(random(255), random(255), random(255));
    prevPosition = new PVector(x, y);
  }

  void switchLane(Lane newLane) {
    lane.removeCar(this);
    position.x = newLane.x;
    newLane.addCar(this);
    lane = newLane;
    laneToSwitch = null;
  }

  Car getFrontCar(Lane checkLane) {
    Car frontCar = null;
    float closestDistance = Float.POSITIVE_INFINITY;
    for (Car car : checkLane.carArray) {
      if (car != this) {
        float distance = position.y - car.position.y;
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
      if (car != this) {
        float distance = position.y - car.position.y;
        if (distance < closestDistance && distance < 0) {
          closestDistance = distance;
          rearCar = car;
        }
      }
    }


    return rearCar;
  }
  float calculateSafeDistance(Car frontCar) {
    float reactionTime = 1.0;
    float followingDistance = speed * reactionTime;
    float bufferDistance = 10.0;

    float carLength = h;

    if (speed > 0 && frontCar.speed > 0) {
      float decelerationDistance = (speed * speed) / (2 * maxAcceleration) -
        (frontCar.speed * frontCar.speed) / (2 * frontCar.maxAcceleration);
      return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else if (speed > 0 && frontCar.speed == 0) {
      float decelerationDistance = (speed * speed) / (2 * maxAcceleration);
      return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else {
      return bufferDistance + carLength;
    }
  }

  boolean canSwitchLane(Lane laneToSwitch) {
    float tolerance = 2;
    if (laneToSwitch == null) {
      return false;
    }
    Car frontCarInTargetLane = getFrontCar(laneToSwitch);
    Car rearCarInTargetLane = getRearCar(laneToSwitch);

    if (frontCarInTargetLane != null) {
      float frontDistance = position.dist(frontCarInTargetLane.position);
      println(frontCarInTargetLane.speed);
      println(this.speed);
      if (frontDistance < calculateSafeDistance(frontCarInTargetLane) || Math.abs(frontCarInTargetLane.speed - this.speed) < tolerance) {
        return false;
      }
    }

    if (rearCarInTargetLane != null) {
      float rearDistance = position.dist(rearCarInTargetLane.position);
      if (rearDistance < calculateSafeDistance(rearCarInTargetLane) || Math.abs(rearCarInTargetLane.speed - this.speed) < tolerance) {
        return false;
      }
    }

    return true;
  }

  void think() {
    Car frontCar = getFrontCar(lane);
    if (frontCar == null) {
      applyForce(maxAcceleration);
    } else {
      float distance = position.dist(frontCar.position);
      float safeDistance = calculateSafeDistance(frontCar);
      if (distance < safeDistance) {
        //TRANSITION STATES
        if (transitionLane == null) {
          float diceRoll = random(1);
          if (diceRoll < 0.2) {
            if (canSwitchLane(lane.left)) {
              laneToSwitch = lane.left;
            } else if (canSwitchLane(lane.right)) {
              laneToSwitch = lane.right;
            }
          }
        }
        //CANNOT SWITCH LANES
        float P_d = 0.01;
        float A_d = min(-P_d * (safeDistance - distance), maxAcceleration);
        float speed_limit = lane.parent.speedLimit;
        float P_v = 0.01;
        float A_v = -P_v * (speed_limit - speed);
        float A = min(A_d, A_v, maxAcceleration);
        applyForce(A);
      } else {
        applyForce(maxAcceleration);
      }
    }
  }
  void move() {
    prevPosition = position.copy();
    if (mouseHeld && position.dist(new PVector(mouseX, mouseY)) < dispRadius) {
      acceleration = -maxAcceleration;
    }
    speed = constrain(speed + acceleration, 0, maxSpeed);
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
    accelerationTracker = acceleration;
    acceleration = 0;
  }

  void applyForce(float force) {
    acceleration = force;
  }

  void turn(float deg) {
    angle += deg;
  }

  Lane getLaneToSwitch() {
    return laneToSwitch;
  }

  void display() {
    fill(c);
    rect(position.x, position.y, w, h);
  }

  void displayInfo() {
    textSize(25);
    fill(0);
    text("S: " + roundToNearestDecimal(ppfToMph(speed), 1) + " / " + roundToNearestDecimal(ppfToMph(maxSpeed), 1), position.x + 20, position.y + 10);
    text("A: " + roundToNearestDecimal(ppfPerFrameToMphPerSec(accelerationTracker), 1) + " / " + roundToNearestDecimal(ppfPerFrameToMphPerSec(maxAcceleration), 1), position.x + 20, position.y + 30);
  }
}
