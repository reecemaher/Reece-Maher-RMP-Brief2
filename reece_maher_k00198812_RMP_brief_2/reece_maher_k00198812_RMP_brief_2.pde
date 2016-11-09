PImage  img;

import processing.video.*;
import java.awt.Color;

float[] hsb;
Capture video;

void setup() {
  size(1280,720);
  hsb = new float[3];
  video = new Capture(this,1280,720);
  
  video.start();
  
  img = loadImage("mirror.png");
}

void draw(){

  if( video.available()){
    video.read();
    loadPixels();
    video.loadPixels();
    
     for (int x = 0; x < video.width; x++ ) {
      for (int y = 0; y < video.height; y++ ) {
        
        int loc = x + y*video.width;
        
          int r, g, b;
        r = (video.pixels[loc] >> 16) & 0xFF;
        g = (video.pixels[loc] >> 8) & 0xFF;
        b = (video.pixels[loc]) & 0xFF;
        
        hsb = Color.RGBtoHSB((int)r,(int)g,(int)b, null);
        
        float deg = hsb[0]*360;
        
        if (deg >= 200 && deg < 260){ 
          // green
          r = 0;
          g = 0;
          b = 0;
        } 
  
        color c = color(r,g,b);
        pixels[loc] = c;
        
    scale(-1,1);
    //image(video,-width,0);
  }
  if(mousePressed == true && mouseButton == LEFT){
  ellipse(mouseX,mouseY,50, 50);
  }
     }
     updatePixels();
  }
  
 image(img,0,0);
 
   
 
  }