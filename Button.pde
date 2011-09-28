
class Button {
  int x, y, xwidth;
  String action, message;
  boolean pressed;

  Button(int x, int y, String action) {
    this.x = x;
    this.y = y;
    this.xwidth = 30;
    this.action = action;
    this.message = null;
    this.pressed = false;
    this.display();
  }

  Button(int x, int y, String action, String message) {
    this.x = x;
    this.y = y;
    this.xwidth = message.length()*6+10;
    this.message = message;
    this.action = action;
    this.display();
  }

  void display() {
    if (!this.overMe()) {
      stroke(200);
      fill(225);
      rect(x, y, xwidth, 30);
      fill(175);
    } 
    else {
      stroke(225);
      fill(255);
      rect(x, y, xwidth, 30);
      fill(215);
    }
    PFont font = loadFont("Thonburi-10.vlw");
    if (this.message != null && font != null) {
      textFont(font, 10);
      text(message,x+5,y+18);
    }
  }

  String getAction() {
    return this.action;
  }
  
  boolean pressed() {
    return this.pressed;
  }
  
  void setPressed(boolean on) {
    this.pressed = on;
  }

  boolean overMe() {
    if (mouseX >= x && mouseX <= x+30 && 
      mouseY >= y && mouseY <= y+30) {
      return true;
    } 
    else {
      if (this.pressed()) {
        this.setPressed(false);
      }
      return false;
    }
  }

  void update() {
    this.overMe();
    this.display();
  }
}

