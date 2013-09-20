class Particle {
  PVector position; //(x, y)
  PVector velocity; //(vx, vy)
  PVector acceleration; //(ax, ay)
  PVector colour; //(r,g,b)
  int life; //milliseconds
  int maxLife;
  PVector origin;
  int size;
  int opacity;

  Particle() {
    switch (mode) {
    case 0:
      maxLife = 500;
      acceleration = new PVector(0, 0.04);
      velocity = new PVector(random(-1.5, 1.5), random(-4, -3));
      origin = new PVector(width/2, 3*height/5);
      position = origin.get();
      break;
    case 1:
      maxLife = 100;
      acceleration = new PVector(0, random(0, 0.1));
      velocity = new PVector(0.6*random(-1, 1), -3 + 0.03*random(0, 1));
      origin = new PVector(width/2, 3*height/5);
      position = origin.get();
      position.add(randomPointOnDisk());
      break;
    case 2:
      maxLife = 700;
      acceleration = new PVector(0, random(0, -0.1));
      velocity = new PVector(random(-0.7, 0.7), random(-2, 2));
      origin = new PVector(width/2, height/2);
      position = origin.get();
      position.add(randomPointOnDisk());
      size = (int)random(0, 15);
      break;
    case 3: 
    case 4:
      maxLife = 500;
      acceleration = new PVector(0, 0.05);
      velocity = new PVector(2, -2);
      origin = new PVector(width/4, height/5);
      position = origin.get();
      position.add(randomPointOnDisk());
      break;
    case 5:
      maxLife = 1000;
      size = (int)random(1, 10);
      acceleration = new PVector(0, map(size, 1, 10, 0.0005, 0.002));
      velocity = new PVector(0, random(1, 0.5));
      origin = new PVector(width/2, -5);
      position = origin.get();
      position.x += random(-800, 800);
      break;
    }
    life = 0;
  }

  void run() {
    update();
    display();
  }

  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    switch (mode) {
    case 2:
      acceleration.add(new PVector(map(position.x - origin.x, -40, 40, 0.0005, -0.0005), 0));
      break;
    case 4:
      if (position.y > 2*height/3) {
        position.y = 2*height/3;
        velocity.y *= -0.4;
      }
      break;
    case 5:
      velocity.x += random(-0.02, 0.02);
      if (position.y > 750) {
        position.y = 750;
        velocity.x = 0;
        velocity.y = 0;
      } 
      break;
    }

    if (position.x > objPosition.x && position.x < (objPosition.x + objSize.x) && position.y > objPosition.y && position.y < (objPosition.y + objSize.y)) {
      position.y = objPosition.y;
      switch(mode) {
      case 0:
      case 1:
      case 3: 
      case 4:
        velocity.y *= -0.4;
        break;
      case 2:
        velocity.y *= random(-0.4, 0.4);
        break;
      case 5:
        velocity.y = 0;
        velocity.x = 0;
        break;
      }
    }
    life += 1.0;
  }

  void display() {
    switch (mode) {
    case 0:
      fill(255, 10000/life); 
      ellipse(position.x, position.y, 3, 3);
      break;
    case 1:
      size = (int)map(life, 0, 100, 20, 2);
      opacity = (int)map(life, 0, 70, 200, 0);
      fill(255, map(dist(position.x, position.y, origin.x, origin.y), 50, 0, 0, 200), 0, opacity);
      ellipse(position.x, position.y, size, size);
      break;
    case 2:
      opacity = (int)map(life, 0, 200, 70, 30);
      int red = (int)map(life, 0, 300, 0, 255);
      int green = (int)map(velocity.y, 3, -3, 0, 255);
      int blue= (int)map(acceleration.y, -0.1, 0.1, 0, 255);
      fill(red, green, blue, opacity);
      ellipse(position.x, position.y, size, size);
      break;
    case 3: 
    case 4:
      fill(255, 255, 255);
      ellipse(position.x, position.y, 5, 5);
      break;
    case 5:
      fill(255, 255, 255, 30);
      ellipse(position.x, position.y, size, size);
      break;
    }
  }

  boolean isDead() {
    if (life > maxLife) {
      return true;
    } 
    else if (mode == 1 && velocity.y > -1.3) {
      return true;
    }
    else {
      return false;
    }
  }

  //Utils
  PVector randomPointOnDisk() {
    int R = 0;
    switch(mode) {
    case 1: 
    case 3:
    case 4:
      R = 50;
      break;
    case 2:
      R = 70;
      break;
    case 5:
      R = 400;
      break;
    }
    float theta= random(0, 2 * 3.1415926);
    float r = R * sqrt(random(0, 1));
    return new PVector((int)r*sin(theta), (int)r*cos(theta));
  }
}

