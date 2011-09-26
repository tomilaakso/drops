
// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float timer;
  color particleColor;
  int width = 15;
  int height = 15;
  
  // One constructor
  Particle(PVector a, PVector v, PVector l) {
    acc = a.get();
    vel = v.get();
    loc = l.get();
    timer = 100.0;
  }

  // Another constructor (the one we are using here)
  Particle(PVector l, color _particleColor) {
    acc = new PVector(0.0,0.0,0.0);
    float x = (float) generator.nextGaussian()*0.6f;
    float y = (float) generator.nextGaussian()*0.6f;
    particleColor = _particleColor;
    vel = new PVector(x,y,0);
    loc = l.get();
    timer = 200.0;
  }

  void run() {
    update();
    render();
  }
  
  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void add_force(PVector f) {
    acc.add(f);
  }  

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 1;
    acc.mult(0);
  }

  // Method to display
  void render() {
    imageMode(CORNER);
    //tint(155,timer);
    //System.out.println(loc.x + " " + loc.y);
 
    color endColor = color(255);
    PImage previousColor;

    
    //color fillColor = lerpColor(particleColor, (color) previousColor.pixels[], 0.50);
    //fill(fillColor);
    noStroke();
    rectMode(CENTER);
    PImage scope;

    try
    {
      scope = get((int) loc.x,(int) loc.y, width, height);
    }
    catch (Exception e)
    {
      scope = createImage(width,height,RGB);
      scope.loadPixels();
      for (int i = 0; i < scope.pixels.length; i++) 
      {
        scope.pixels[i] = color(255); 
      }
      scope.updatePixels();
    }
    PImage img = createImage(width,height,RGB);
    img.loadPixels();
      for (int i = 0; i < img.pixels.length; i++) 
      {
        try
        {
          img.pixels[i] = lerpColor(particleColor, scope.pixels[i], 0.999); 
        }
        catch (Exception e)
        {
          img.pixels[i] = color(255);    
        }
      }
 
    img.updatePixels();

    image(img,loc.x,loc.y);
  }

  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0 || loc.x <= 0 || loc.y <= 0 || loc.x >= screen.width + width || loc.y >= screen.height + height ) {
      return true;
    } else {
      return false;
    }
  }
}




