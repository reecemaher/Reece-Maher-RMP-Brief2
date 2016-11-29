
Drop[] drops = new Drop[1000];
import processing.video.*;
float s = 80;
Capture video;



void setup(){
  size(1920,1080);
  //frameRate(10);
  for(int i = 0; i < drops.length; i++){
   drops[i] = new Drop(); 
  }
  video = new Capture(this, 1280,720);
  video.start();
}

void captureEvent(Capture video){
 video.read(); 
}

void draw(){
  background(160,200,210);
 video.loadPixels();
 for (int i =0; i <drops.length;i++){
   noStroke();
   drops[i].fall();
   drops[i].update();
 //for(drops[i].x = 0; drops[i].x< video.width; drops[i].x +=s){
 //  for ( drops[i].y = 0; drops[i].y < video.height; drops[i].y+=s){
   for (int x = 0; x < video.width; x +=drops[i].x ) {
    for (int y = 0; y < video.height; y +=drops[i].y ) {
    //int loc = (video.width -drops[i].x -1) + drops[i].y*video.width;
     int loc = (video.width -x -1) + y*video.width;
    float r = red(video.pixels[loc]);
    float g = green(video.pixels[loc]);
    float b = blue(video.pixels[loc]);
    
    //if(r > 1000 && g > green(video.pixels[loc]) && b > blue(video.pixels[loc])){
    // r = red(150);
    // g = green(27);
    // b = blue(200);
     
    // fill(r,g,b, 130);
    //}
    
      r = constrain(r,0,255);
      g = constrain(g,0,255);
      b = constrain(b,0,255);

      // make a new color and set pixel in the window
      
    fill(r,g,b, 130);
    
    //int shapeX, shapeY;
    //  shapeX = drops[i].x + (width - video.width)/2;
    //  shapeY = drops[i].y + (height - video.height)/2;
      
    //  shapeX += random(-5,5);
    //  shapeY += random(-5,5);
    // noStroke();
    // ellipse(shapeX,shapeY,s,s);
    color c = color(r,g,b);
    video.pixels[loc] = c;
   }
 }
 
 }
 
}