
class Button {
  int x, y, xwidth;
  String action, message;

  Button(int x, int y, String action) {
    this.x = x;
    this.y = y;
    this.xwidth = 30;
    this.action = action;
    this.message = null;
    this.display();
  }

  Button(int x, int y, String action, String message) {
    this.x = x;
    this.y = y;
    this.xwidth = 30;
    this.message = message;
    this.action = action;
    this.display();
  }

  void display() {
    noStroke();
    if (this.overMe()) {
      fill(175);
      rect(x, y, xwidth, 30);
    } 
    else {
      fill(125);
      rect(x, y, xwidth, 30);
    }

    if (this.message != null) {
    }
  }

  String getAction() {
    return this.action;
  }

  boolean overMe() {
    if (mouseX >= x && mouseX <= x+30 && 
      mouseY >= y && mouseY <= y+30) {
      return true;
    } 
    else {
      return false;
    }
  }

  void update() {
    this.overMe();
    this.display();
  }
}

