class Sizebar {
  int swidth, sheight;    
  int xpos, ypos;         
  float slidepos, newslidepos;    
  int slideposMin, slideposMax;   
  int loose;              
  boolean over;           
  boolean locked;

  Sizebar (int xp, int yp, int sw, int sh, int lose) {
    this.swidth = sw;
    this.sheight = sh;
    this.xpos = xp;
    this.ypos = yp-this.sheight/2;
    this.slidepos = this.xpos + this.swidth/2 - this.sheight/2;
    this.newslidepos = this.slidepos;
    this.slideposMin = this.xpos;
    this.slideposMax = this.xpos + this.swidth+1;
    this.loose = lose;
    this.display();
  }

  void update() {
    if(mouseX > this.slidepos && mouseX < this.slidepos+this.sheight*2 &&
    mouseY > this.ypos-this.sheight*4 && mouseY < this.ypos+this.sheight*4) {
      this.over = true;
    } else {
      this.over = false;
    }
    if(mousePressed && this.over) {
      this.locked = true;
    }
    if(!mousePressed) {
      this.unlock();
    }
    if(this.locked) {
      this.newslidepos = min(max(mouseX-this.sheight/2, 
      this.slideposMin), this.slideposMax);
    }
    if(abs(this.newslidepos - this.slidepos) > 1) {
      if (this.locked) {
      this.slidepos += (this.newslidepos-this.slidepos)
      /this.loose;
      } else {
       this.newslidepos = this.slidepos; 
      }
    }
    this.display();
  }
  
  void unlock() {
   this.locked = false; 
  }

  void display() {
    /*noStroke();
    fill(225);
    rect (this.xpos-5, this.ypos-5, this.swidth+10, this.sheight);*/
    noFill();
    stroke(0);
    rect(this.xpos, this.ypos, this.swidth, this.sheight);
    if(this.over || this.locked) {
      fill(175);
    } else {
      fill(125);
    }
    rectMode(CENTER);
    rect(this.slidepos+2, this.ypos+3, this.sheight*2,this.sheight*4);
  }

  float getValue() {
    return (this.slidepos-this.xpos)/(this.swidth-this.sheight);
  }
   
}

