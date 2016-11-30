Drop[] drops = new Drop[500];
XML xml;

import processing.video.*;
import ddf.minim.*;
Minim minim;
AudioPlayer music;
//import ddf.minim.spi.*;
//import ddf.minim.signals.*;
//import ddf.minim.*;
//import ddf.minim.analysis.*;
//import ddf.minim.ugens.*;
//import ddf.minim.effects.*;

//AudioPlayer player;
//AudioInput in;
float s= random(5, 25);
// Variable for capture device
Capture video;

void setup() {
  size(1920, 1080);
  xml = loadXML("controls.xml");
  XML[] controllers = xml.getChildren("keyboardEvent");
  XML[] control = xml.getChildren("mouseEvent");
  
  for(int j = 0; j < control.length; j++){
    int id = control[j].getInt("id");
    String event = control[j].getString("mouseClick");
    String outcome = control[j].getContent();
    println(id + ", " + event + ", " + outcome);
  }
  
  for(int i = 0; i < controllers.length; i++){
   int id = controllers[i].getInt("id");
   String event = controllers[i].getString("keyPressed");
   String outcome = controllers[i].getContent();
   println(id + ", " + event + ", " + outcome);
   }
  
  smooth();
  minim = new Minim(this);
    music = minim.loadFile("Eminem.mp3", 512);
    music.play();
  //in = minim.getLineIn();
  for ( int i =0; i< drops.length; i++) {
    drops[i] = new Drop();
  }


  video = new Capture(this, 1280, 720);
  video.start();
  // Start off tracking for red
  //trackColor = color(255, 0, 0);
}

void captureEvent(Capture video) {
  // Read image from the camera
  video.read();
}

void draw() {
  background(160, 200, 210);

  video.loadPixels();
  //image(video, 0, 0);
  for ( int i =0; i< drops.length; i++) { 
    // stroke(trackColor);
    drops[i].fall();
    drops[i].update();


    for (int x = 0; x < video.width; x +=drops[i].x ) {
      for (int y = 0; y < video.height; y +=drops[i].y ) {


        //int loc = x + y*video.width;
        int loc = (video.width - x - 1) + y*video.width;
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);

        fill(r, g, b, 130);
        noStroke();

        int shapeX, shapeY;
        shapeX = x + (width - video.width)/2;
        shapeY = y + (height - video.height)/2;

        shapeX += random(-5, 5);
        shapeY += random(-5, 5);

        float size = map(mouseX, 0, width, 1, 50);

        if (keyPressed== true && keyCode == LEFT) {

          triangle(shapeX, shapeY, shapeX-random(10, 25)*2, shapeY+random(10, 25)*2, shapeX+random(10, 25)*2, shapeY+random(10, 25)*2);
        }

        if (keyPressed== true && keyCode == RIGHT) {

          rect(shapeX, shapeY, size, size);
        } else {
          ellipse(shapeX, shapeY, size, size);
        }
        strokeWeight(10);
        //line(shapeX,shapeY,random(5,25), random(5,25));
      }
      //if(mousePressed == true){

      // for( int i =0 ; i< drops.length; i++){ 
      //// stroke(trackColor);
      // drops[i].fall();
      // drops[i].update();
      // }

      //}
      //for(int i = 0; i < in.bufferSize() - 1; i++)
      // {

      //}
      //
    }
  }




  if (mousePressed == true) {
    colorMode(HSB);
  } else {
    colorMode(RGB);
  }

 // updatePixels();

  //if(mouseX >1000 && size <50){
  //   size++;
  //   println('r');
  //   println(size);
  // }

  // if(mouseX <200 && size >5){
  //   size--;
  //   println('l');
  //   println(size);

  // }

  // else if(mouseX > 200 && mouseX <1000){
  //   if(size >25){
  //  size --; 
  //   }
  //  if(size <25){
  //   size++; 
  //  }
  // }
}