class Particle {
  PVector position; //(x, y)
  PVector velocity; //(vx, vy)
  PVector acceleration; //(ax, ay)
  PVector colour; //(r,g,b)
  int life; //milliseconds
  int maxLife;
  PVector origin;
  int size2;

  Particle() {
    switch (mode) {
    case 0:
      maxLife = 250;
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
      maxLife = 300;
      acceleration = new PVector(0, random(0, 0.05));
      velocity = new PVector(random(-0.7, 0.7), random(-2, -1));
      origin = new PVector(width/2, height/2);
      position = origin.get();
      position.add(randomPointOnDisk());
      size2 = (int)random(0, 15);
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
    switch (mode) {
    case 0:
      velocity.add(acceleration);
      break;
    case 1:
      velocity.add(acceleration);
      break;
    case 2:
      velocity.add(acceleration);
      acceleration.add(new PVector(map(position.x - origin.x, -40, 40, 0.0005, -0.0005), 0));
      break;
    }

    life += 1.0;
  }

  void display() {
    switch (mode) {
    case 0:
      fill(255, 10000/life); 
      ellipse(position.x, position.y, 3, 3);
      line(position.x, position.y, position.x-velocity.x, position.y-velocity.y);
      break;
    case 1:
      int size = (int)map(life, 0, 100, 20, 2);
      int opacity = (int)map(life, 0, 70, 200, 0);
      fill(255, map(dist(position.x, position.y, origin.x, origin.y), 50, 0, 0, 200), 0, opacity);
      ellipse(position.x, position.y, size, size);
      break;
    case 2:
      int opacity2 = (int)map(life, 0, 200, 30, 70);
      int red = (int)map(life, 0, 300, 0, 200);
      int green = (int)map(velocity.y, 3, -3, 0, 255);
      int blue= (int)map(acceleration.y, -0.1, 0.1, 0, 255);
      fill(red, green, blue, opacity2);
      ellipse(position.x, position.y, size2, size2);
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
      R = 50;
      break;
    case 2:
      R = 70;
      break;
    }
    float theta= random(0, 2 * 3.1415926);
    float r = R * sqrt(random(0, 1));
    return new PVector((int)r*sin(theta), (int)r*cos(theta));
  }
}

