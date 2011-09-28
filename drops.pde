/**
 * Smoke Particle System
 * by Daniel Shiffman.  
 * 
 * A basic smoke effect using a particle system. 
 * Each particle is rendered as an alpha masked image. 
 */

int stackSize = 0;
Random generator;
ArrayList stack = new ArrayList();
boolean randomMode;
double dropSize;
/********/
Gui gui;
/**********/

void setup() {
  background(255);
  size(500, 500);

  colorMode(RGB);
  this.randomMode = true;
  this.dropSize = 0.5;


  // Using a Java random number generator for Gaussian random numbers
  generator = new Random();

  smooth();
  /***********/
  this.gui = new Gui();
  /***********/
}

void draw() {
  /***/
  fill(255);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, this.gui.getStartY());
  update();
  /***/

  for (int i = 0; i < stack.size(); i++) 
  {
    ((ParticleSystem) stack.get(i)).run();
  }
}

/*********/
void update() {
  if (mouseY > this.gui.getStartY()) {
    if (!this.gui.active()) {
      this.gui.activate(true);
    }
    this.gui.update();
  } 
  else if (this.gui.active()) {
    this.gui.update();
    this.gui.activate(false);
  }
  
  if (millis() % 10 == 0 && stack.size() < 5 && this.randomMode){
    stack.add(new ParticleSystem(20, new PVector(random(20, width-20),
    random(20, gui.getStartY()-20))));
  }
  
  
  for (int i = stack.size()-1; i >= 0; i--) 
  {
    ParticleSystem sys = (ParticleSystem) stack.get(i);
    if (sys.dead()){
      stack.remove(i);
    }
  }
}
/******/

void setRandomMode(boolean on) {
  this.randomMode = on;
}

void mousePressed()
{
  if (!this.gui.active()) {
    stack.add(new ParticleSystem(20, new PVector(mouseX, mouseY)));
  } else {
    this.gui.update();
  }
}

