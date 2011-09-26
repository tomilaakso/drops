import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class drops extends PApplet {

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

public void setup() {

  size(500, 500);
  
  colorMode(RGB);

  // Using a Java random number generator for Gaussian random numbers
  generator = new Random();

  // Create an alpha masked image to be applied as the particle's texture
  ps = new ParticleSystem(2000, new PVector(100,100));

  ps2 = new ParticleSystem(2000, new PVector(225,125));

  ps3 = new ParticleSystem(2000, new PVector(275,145));
  
  smooth();
}

public void draw() {
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
  
  ps3.run();
  
  for (int i = 0; i < stackSize; i++) 
  {
    //new ParticleStack();  
  }

}

public void mousePressed()
{
  stackSize++;
}


// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float timer;
  int particleColor;
  int width = 15;
  int height = 15;
  
  // One constructor
  Particle(PVector a, PVector v, PVector l) {
    acc = a.get();
    vel = v.get();
    loc = l.get();
    timer = 200.0f;
  }

  // Another constructor (the one we are using here)
  Particle(PVector l, int _particleColor) {
    acc = new PVector(0.0f,0.0f,0.0f);
    float x = (float) generator.nextGaussian()*0.3f;
    float y = (float) generator.nextGaussian()*0.3f;
    particleColor = _particleColor;
    vel = new PVector(x,y,0);
    loc = l.get();
    timer = 500.0f;
  }

  public void run() {
    update();
    render();
  }
  
  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  public void add_force(PVector f) {
    acc.add(f);
  }  

  // Method to update location
  public void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 1;
    acc.mult(0);
  }

  // Method to display
  public void render() {
    imageMode(CORNER);
    //tint(155,timer);
    //System.out.println(loc.x + " " + loc.y);
 
    int endColor = color(255);
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
          img.pixels[i] = lerpColor(particleColor, scope.pixels[i], 0.99f); 
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
  public boolean dead() {
    if (timer <= 0.0f || loc.x <= width || loc.y <= height || loc.x + width >= screen.width - 1 || loc.y + width >= screen.height - 1 ) {
      return true;
    } else {
      return false;
    }
  }
}





// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed

  int particleColor = color(random(100,255),random(100,255),random(100,255));
  
  ParticleSystem(int num, PVector v) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, particleColor));    // Add "num" amount of particles to the arraylist
    }
  }

  public void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.run();
      if (p.dead()) {
        particles.remove(i);
      }
    }
  }
  
  // Method to add a force vector to all particles currently in the system
  public void add_force(PVector dir) {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.add_force(dir);
    }
  
  }  

  public void addParticle() {
    particles.add(new Particle(origin, particleColor));
  }

  public void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  public boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#D4D0C8", "drops" });
  }
}
