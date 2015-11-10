class Atracttor{
 float mass;
 PVector location; 
 float G= 1;
 
 Atracttor(float xPos,float yPos){
  location = new PVector(xPos, yPos);
  mass = 50;
 } 
 
 void display (){
  fill(255,0,0);
   ellipse(location.x,location.y,20,20) ;
 }
}

