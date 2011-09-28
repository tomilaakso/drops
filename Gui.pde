
class Gui {
  ArrayList buttons;
  ArrayList scrolls;
  boolean active;
  int guistarty;
  
 Gui(){
   stroke(200);
   fill(225);
   rect(0, guistarty, 500, height-guistarty);
   this.buttons = new ArrayList();
   this.scrolls = new ArrayList();
   this.guistarty = 400;
   
   this.buttons.add(new Button(30,guistarty+35,"random","random"));
   this.buttons.add(new Button(60+6*6,guistarty+35,"manual", "manual"));
 }
 
 boolean active(){
  return this.active; 
 }
 
 void activate(boolean activate){
   this.active = activate;
 }
 
 int getStartY(){
  return this.guistarty; 
 }
 
 void update(){
   for (int a = 0; a < this.buttons.size(); a++){
     Button button = (Button) this.buttons.get(a);
     if (button.overMe() && !button.pressed() && mousePressed){
       String act = button.getAction();
       if (act.equals("random")) {
         setRandomMode(true);
       } else if (act.equals("manual")) {
         setRandomMode(false);
       }
       button.setPressed(true);
     }
     button.update();
   }
 }
  
}
