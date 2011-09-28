
class Gui {
  ArrayList buttons;
  ArrayList scrolls;
  boolean active;
  int guistarty;
  
 Gui(){
   noStroke();
   fill(225);
   rect(0, guistarty, 499, height-guistarty-1);
   this.buttons = new ArrayList();
   this.scrolls = new ArrayList();
   this.guistarty = 400;
   
   this.buttons.add(new Button(50,guistarty+30,"random"));
   this.buttons.add(new Button(100,guistarty+30,"manual"));
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
     button.update();
     if (button.overMe()){
       
     }
   }
 }
  
}
