/**
 * Smoke Particle System
 * by Daniel Shiffman.  
 * 
 * A basic smoke effect using a particle system. 
 * Each particle is rendered as an alpha masked image. 
 */

ParticleSystem ps, ps2, ps3;

int stackSize = 0;
Random generator;
ArrayList stack = new ArrayList();
/********/
Gui gui;
/**********/

void setup() {
  background(255);
  size(500, 500);

  colorMode(RGB);


  // Using a Java random number generator for Gaussian random numbers
  generator = new Random();

  // Create an alpha masked image to be applied as the particle's texture
  ps = new ParticleSystem(2000, new PVector(100, 100));

  ps2 = new ParticleSystem(2000, new PVector(225, 125));

  ps3 = new ParticleSystem(2000, new PVector(275, 145));

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

  // Calculate a "wind" force based on mouse horizontal position
  //float dx = (mouseX - width/2) / 10000.0;
  //float dy = (mouseY - width/2) / 10000.0;
  //PVector wind = new PVector(dx,dy,0);

  //ps.add_force(wind);
  ps.run();
  //ps.addParticle();

  ps2.run();
  //ps2.addParticle();

  ps3.run();


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
}
/******/

void mousePressed()
{
  if (!this.gui.active()) {
    stack.add(new ParticleSystem(200, new PVector(mouseX, mouseY)));
  }
}

