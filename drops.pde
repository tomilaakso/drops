/**
 * Smoke Particle System
 * by Daniel Shiffman.  
 * 
 * A basic smoke effect using a particle system. 
 * Each particle is rendered as an alpha masked image. 
 */

ParticleSystem ps,ps2,ps3;

int stackSize = 0;
Random generator;
ArrayList stack = new ArrayList();

void setup() {
  background(255);
  size(300, 300);
  frameRate(10);
  colorMode(RGB);


  // Using a Java random number generator for Gaussian random numbers
  generator = new Random();

  // Create an alpha masked image to be applied as the particle's texture
  ps = new ParticleSystem(200, new PVector(100,100));

  ps2 = new ParticleSystem(200, new PVector(145,135));

  smooth();
}

void draw() {
  background(255);

  // Calculate a "wind" force based on mouse horizontal position
  //float dx = (mouseX - width/2) / 10000.0;
  //float dy = (mouseY - width/2) / 10000.0;
  //PVector wind = new PVector(dx,dy,0);

  //ps.add_force(wind);
  ps.run();
  //ps.addParticle();

  ps2.run();
  //ps2.addParticle();
 
  

  for (int i = 0; i < stack.size(); i++) 
  {
    ((ParticleSystem) stack.get(i)).run(); 
  }

}

void mousePressed()
{
  stack.add(new ParticleSystem(200, new PVector(mouseX,mouseY))); 
}
