
class Pigs {
  int G = 1;
  PShape[] partePuercoNon = new PShape [4];
  PShape[] partePuercoPar = new PShape [5];
  
  float limite1, limite2, amp, onsets;
  float mass = 10;
  float dMin = 12;
  
  
PVector[] zone = { 
  new PVector(30.0, 152.85), //0
  new PVector(647.15, 770), //1
  new PVector(604.25, 737.10), //2
  new PVector(142.85, 245.70), //3
  new PVector(225.70, 368.55), //4
  new PVector(491.40, 634.25), //5
  new PVector(368.55, 491.40)//6
  };

  
  PVector centroGrav; // atractor del pLoc
  PVector pLoc;//location x,y
  PVector prevCentre; // Centro anterior
  PVector acceleration; 
  
  PVector vel;

  PVector mouse = new PVector(mouseX , mouseY);
  String file;
  int fn ;
  boolean moveMouseX, moveMouseY;
  //Set the constructor
  Pigs(int puercoArchivo, float m) {
    fn = puercoArchivo;
    mass = m;
    float x = random(zone[fn].x+60 , zone[fn].y-60); //Colocarlo a una distacia aleatoria dentro de su zona
    float y = height/2;
    vel = new PVector(0,0);// Velocidad 0
    vel.limit(5);
    acceleration = new PVector(0,0); //
    pLoc = new PVector( x ,  y );//Centro del Puerco
    centroGrav = new PVector( x , y);//siemrpre regresar a este punto
    
    //Reasignacion de valores a variables públicas
    //Inicio de asignación y carga de los archivos svg
    // por valores pares o impares por la diferencia en el numero de archivos
    switch(fn) {
    case 0:
    case 2:
    case 4:
    case 6:
      for (int i = 0; i< partePuercoPar.length; i++) {
        file = "p"+fn+"_"+i+".svg"; 
        partePuercoPar[i] = loadShape(file);
      }
      break;
    case 1:
    case 3:
    case 5:
      for (int i = 0; i< partePuercoNon.length; i++) {
        file = "p"+fn+"_"+i+".svg"; 
        partePuercoNon[i] = loadShape(file);
      }
      break;
    }
  }
  
    void applyForce(PVector force) {//Aplicar fuerza Gravitacional 
      PVector f = PVector.div(force , mass);
      acceleration.add(f);
  }
  
  PVector attract(Atracttor a){
    PVector force = PVector.sub(pLoc, a.location); 
    float distance = force.mag();
    distance = constrain(distance,5.0,25.0);  
    force.normalize();
    float strength = (G * mass * a.mass) / (distance * distance);
    force.mult(strength);  
  // println(force, " Fuerza ", distance);
   return force; 
  }
  
  void update() {
    vel.add(acceleration);
    pLoc.add(vel);
    acceleration.mult(0);
  }
boolean checkMove(){
 if( ( mouseX == pmouseX )&& ( mouseY == pmouseY ) ) {
   //Estatico
   return false;
 }
  return true;
}


// Move  
  void checkEdges() {
    //Revisar si la posicion X del Puerco "pLOC" sale de la Zona,
    //si es así revertir su trayectoria y dirigirse al Centro de grav
    if (pLoc.x < zone[fn].x) {
      vel.mult(-1);
    }  else if(pLoc.x > zone[fn].y){
     vel.mult(-1);
    }  
    
    if (pLoc.y > height/2+70)  {
      
      vel.mult(-1);
      } else if(pLoc.y < height/2 -70){
     
      vel.mult(-1);
  }
}

  void display() {
  float randAng = random (80, 150);
  float r = map(mouseX, 0, width, 1, 6);
  float randX = r * sin(randAng);
  float randY = r * cos(randAng);
    shapeMode(CENTER);
    switch(fn) {  
      // Ciclos de asignaciones de partes y agrupacion controlada por fine number "fn"
      //---------------------//---------------------//---------------------
      //0
    case 0:
      pushMatrix();
      translate(pLoc.x, pLoc.y);
      //Par
      //------------------------------casco
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoPar[0], -30 + randX , (-partePuercoPar[4].height/2 + 35) + randY ); 
      popMatrix();
      //------------------------------bota ozq
      pushMatrix();
      scale(.77);
      shape(partePuercoPar[1], -85 + randX, 220 + randY);
      popMatrix();
      //      //------------------------------bota der
      pushMatrix();
      scale(.7);
      shape(partePuercoPar[2], -30, 255 + randY );
      popMatrix();
      //      //------------------------------brazo
      pushMatrix();
      shape(partePuercoPar[3], 25, 10 + randY);
      popMatrix();
      //      //------------------------------escudo
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoPar[4], -23, 50 + randY); 
      popMatrix();
      popMatrix(); 
      break;
      //---------------------//---------------------//---------------------
    case 2:
      pushMatrix();
      scale(.8);
      translate(pLoc.x, pLoc.y + 30);
      // println("PAR")
      //Par
            //------------------------------//casco
      //1
      pushMatrix(); 
      //println(rand);
      shape(partePuercoPar[0], -30, (-partePuercoPar[4].height/2 + 45) + randY);
      //1
      popMatrix();
            //------------------------------//bota ozq
      //2
      pushMatrix();
      scale(.77);
      shape(partePuercoPar[1], -50 + randX, 200);
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      scale(.5);
      shape(partePuercoPar[2], 5, 300 + randY);
      //3
      popMatrix();
      //      //------------------------------brazo
      //4
      pushMatrix();
      scale(.77);
      //rotate(randAng);
      shape(partePuercoPar[3], -82 + randX, 8);
      //4
      popMatrix();
      //      //------------------------------escudo
      //5
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoPar[4], -23, 50 + randX); 
      //5
      popMatrix();
      //0
      popMatrix(); 
      break;
      //---------------------//---------------------//---------------------  
    case 4:
      pushMatrix();
      translate(pLoc.x, pLoc.y + 25);
      //Par
      //      //------------------------------casco
      //1
      pushMatrix();
      shape(partePuercoPar[0], -20  , (-partePuercoPar[4].height/2 + 40)+ randX);
      //1
      popMatrix();
      //      //------------------------------bota ozq
      //2
      pushMatrix();
      scale(.77);
      shape(partePuercoPar[1], -83, 190 + randY);
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      scale(.77);
      shape(partePuercoPar[2], 25 + randX, 180 + randY);
      //3
      popMatrix();
      //      //------------------------------brazo
      //4
      pushMatrix();
      scale(.77);
      //rotate(randAng);
      shape(partePuercoPar[3], -85 + randX, 29);
      //4
      popMatrix();
      //      //------------------------------escudo
      //5
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoPar[4], -23, 50 + randY); 
      //5
      popMatrix();
      //0
      popMatrix(); 
      break;

      //---------------------//---------------------//---------------------
    case 6:
      pushMatrix();
      translate(pLoc.x, pLoc.y + 30);
      //Par
      //      //------------------------------casco
      //1
      pushMatrix();
      shape(partePuercoPar[0], -30, (-partePuercoPar[4].height/2 + 55) + randY);
      //1
      popMatrix();
      //      //------------------------------bota ozq
      //2
      pushMatrix();
      shape(partePuercoPar[1], -65, 160 + randY);
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      scale(.7);
      shape(partePuercoPar[2], 0, 250 + randY);
      //3
      popMatrix();
      //      //------------------------------brazo
      //4
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoPar[3], -99 + randX, 38);
      //4
      popMatrix();
      //      //------------------------------escudo
      //5
      pushMatrix();
      shape(partePuercoPar[4], -25, 60 + randX); 
      //5
      popMatrix();
      //0
      popMatrix(); 
      break;
      //---------------------//---------------------//---------------------
    case 1:
      //println("IMPAR");
      //IMPAR
            //------------------------------//casco
      //0
      pushMatrix();

      translate(pLoc.x, pLoc.y-20);
      //1
      pushMatrix();
      shape(partePuercoNon[0], -50 + randX, -partePuercoNon[3].height/2+45);
      //1
      popMatrix();
      //      //------------------------------bota ozq
      //2
      pushMatrix();
      scale(.7);
      shape(partePuercoNon[1], -95, 250 +  randY);
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      scale(.5);
      shape(partePuercoNon[2], -20, 350 + randY);
      //3
      popMatrix();
      //      //------------------------------escudo
      //4
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoNon[3], -40, 55 + randY); 
      //4
      popMatrix();
      //0
      popMatrix();
      break; 
      //---------------------//---------------------//---------------------
    case 3:
      //println("IMPAR");
      //IMPAR
      //      //------------------------------casco
      //0
      pushMatrix();
      translate(pLoc.x, pLoc.y);
      //1
      pushMatrix();
      shape(partePuercoNon[0], -30, (-partePuercoNon[3].height/2 + 45) + randY);
      //1
      popMatrix();
      //      //------------------------------bota ozq
      //2
      pushMatrix();
      scale(.7);
      //rotate(randAng );
      shape(partePuercoNon[1], -110 + randX, 250 + randY);
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      shape(partePuercoNon[2], -29 + randX, 180 + randY);
      //3
      popMatrix();
      //      //------------------------------escudo
      //4
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoNon[3], -40,  55 + randY); 
      //4
      popMatrix();
      //0
      popMatrix();
      break; 
      //---------------------//---------------------//---------------------
    case 5:
      //      println("IMPAR");
      //IMPAR
            //------------------------------//casco
      //0
      pushMatrix();
      translate(pLoc.x, pLoc.y);
      //1
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoNon[0], -35+ randX, (-partePuercoNon[3].height/2 + 45)+ randY);
      //1
      popMatrix();
      //      //------------------------------bota ozq
      //2
      pushMatrix();
      scale(.7);
      shape(partePuercoNon[1], -90, 280 + randY );
      //2
      popMatrix();
      //      //------------------------------bota der
      //3
      pushMatrix();
      scale(.7);
      shape(partePuercoNon[2], -5, 250 + randY);
      //3
      popMatrix();
      //      //------------------------------escudo
      //4
      pushMatrix();
      //rotate(randAng);
      shape(partePuercoNon[3], -40,  randY  + 55); 
      //4
      popMatrix();
      //0
      popMatrix();

      break;  
      //---------------------//---------------------//---------------------
    }
  }

}

