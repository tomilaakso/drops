
// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float timer;
  color particleColor;
  int particleWidth = 30;
  int particleHeight = 30;  
  float startX;
  float startY;
  
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
    startX = (float) generator.nextGaussian() *0.1f;
    startY = (float) generator.nextGaussian() *0.1f;
    particleColor = _particleColor;
    vel = new PVector(startX,startY,0);
    loc = l.get();
    timer = 300.0;
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
    
    PVector movement;
    float factor = 4;
    
    
    float xMin = startX < 0 ? -1 : -0.7;
    float xMax = startX > 0 ? 1 : 0.7;
    float yMin = startY < 0 ? -1 : -0.7;
    float yMax = startY > 0 ? 1 : 0.7;
    xMin = loc.x > 0 ? xMin : 0;
    xMax = loc.x < width ? xMax : 0;
    yMin = loc.y > 0 ? yMin : 0;
    yMax = loc.y < height ? yMax : 0;
    
    float chance = random(0,1);
    startX = (chance < 0.02 || xMin == 0 || xMax == 0) ? startX*-1 : startX;
    startY = (chance > 0.98 || yMin == 0 || yMax == 0) ? startY*-1 : startY;
    /*
    Ei toimi kun mask päällä. Löytyy render():n lopusta.
    
    if (chance > 0.1 && chance < 0.2) {
      particleWidth++;
      particleHeight++;
    }
    */
    
    movement = new PVector(factor * random(xMin,xMax),factor * random(yMin,yMax));

    loc.add(movement);
    
    /*
    PVector brownian;
    float xMin = loc.x > 0 ? -1 : 0;
    float xMax = loc.x < width ? 1 : 0;
    float yMin = loc.y > 0 ? -1 : 0;
    float yMax = loc.y < height ? 1 : 0;
    brownian = new PVector(factor * random(xMin,xMax),factor * random(yMin,yMax),0.0);

    loc.add(brownian);
    */
    
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
      scope = get((int) loc.x,(int) loc.y, particleWidth, particleHeight);
    }
    catch (Exception e)
    {
      scope = createImage(particleWidth,particleHeight,RGB);
      scope.loadPixels();
      for (int i = 0; i < scope.pixels.length; i++) 
      {
        scope.pixels[i] = color(255); 
      }
      scope.updatePixels();
    }
    PImage img = createImage(particleWidth,particleHeight,RGB);
    img.loadPixels();
      for (int i = 0; i < img.pixels.length; i++) 
      {
        try
        {
          float mixRate;
          float scopeBrightness = brightness(scope.pixels[i]);
          if (scopeBrightness < 10) scopeBrightness = 10;

          mixRate = 0.8 + 1 / scopeBrightness;
          if (color(scope.pixels[i]) == 255) {
            mixRate = 0.2 + 1 /scopeBrightness;
          }

          img.pixels[i] = lerpColor(particleColor, scope.pixels[i], mixRate); 
        }
        catch (Exception e)
        {
          img.pixels[i] = color(255);    
        }
      }
    
    PImage msk = loadImage("texture.gif");
    
    img.mask(msk);
    img.updatePixels();
    image(img,loc.x,loc.y);
  }

  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0){ //|| loc.x <= 0 || loc.y <= 0 || loc.x >= screen.width + width || loc.y >= screen.height + height ) {
      return true;
    } else {
      return false;
    }
  }
}




