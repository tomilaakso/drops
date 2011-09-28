
class Gui {
  ArrayList buttons;
  Sizebar sizebar;
  boolean active;
  int guistarty = height-100;
  
 Gui(){
   this.buttons = new ArrayList();
   this.sizebar = new Sizebar(300, guistarty+20, 50,4,10);
   
   this.buttons.add(new Button(30,guistarty+35,"random","random"));
   this.buttons.add(new Button(60+6*6,guistarty+35,"manual", "manual"));
   
   this.update();
 }
 
 boolean active(){
  return this.active; 
 }
 
 void activate(boolean activate){
   this.active = activate;
   if (!activate) {
    this.sizebar.unlock(); 
   }
   println(sizebar.getValue());
 }
 
 int getStartY(){
  return this.guistarty; 
 }
 
 void update(){
   rectMode(CORNER);
   stroke(200);
   fill(225);
   rect(0, guistarty, 500, height-guistarty);
   
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
   sizebar.update();
 }
  
}
