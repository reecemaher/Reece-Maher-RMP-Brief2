class Drop{
  
 
 int x = (int)random(width);
 float x2 = random(5,25); 
 int y = (int)random(0, 200);
 float z = random(0,20);
 float speed = map(z,0,20/4,4/2,10/2);
 float wind = map(mouseX, 0,speed,0,x);
 
 float len = map(z, 0,20,15,35);
 
 float con = constrain(mouseX, 1,2);
 
 void fall(){
   //x += speed;
  y += speed;
  }
  
  
  void update(){
    //float thick = map(z,0,20,.2,2);
    //strokeWeight(thick);
   ellipse (x, y, len,len); 
   
   if(mouseX < width/3){
        x += speed; 
        //y -= 1;
        
      }
      
      if(mouseX > width/1.4){
       x -= speed; 
      // y += 15;
      }
      
      else{
        // ellipse (x, y, x2,x2); 
         x += 0;
      }
   
   
   
   if(y > height){
     float splashX = map(z,0,20,10,20);
     float splashY = map(z,0,20,10,20);
    // strokeWeight(splash);
     //fill(trackColor);
     noStroke();
     ellipse(x,y,splashX,splashY);
     y = (int)random(0, 200);
     x = (int)random(width);
     
      //speed = map(z,0,20,4,10);   
   }
   
   else if(x < 0){
     translate(0,0);
    x = (int)random(width + 50, width+500); 
   // println("less");
   // speed = map(z,0,20,4,10)*2;
   }
   
   else if(x > width){
     translate(0,0);
    x = (int)random(0,50);
   // speed = map(z,0,20,4,10);
   }
  }
}