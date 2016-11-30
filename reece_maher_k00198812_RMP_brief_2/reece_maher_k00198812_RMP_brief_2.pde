//creating an array to create 500 drops(ellipses)
Drop[] drops = new Drop[500];
XML xml;
// importing minim and video libraries
import processing.video.*;
import ddf.minim.*;
Minim minim;
// variable for holdong audio file
AudioPlayer music;


// Variable for capture device
Capture video;

void setup() {
  size(1920, 1080);
  //load in the xml file
  xml = loadXML("controls.xml");
  // access all children from the keyboardEvent tag 
  XML[] controllers = xml.getChildren("keyboardEvent");
  
  // access all children from the mouseEventevent tag 
  XML[] control = xml.getChildren("mouseEvent");

//loop through all the tags named mouseEvent in this case there is only one
  for (int j = 0; j < control.length; j++) {
    //get the value from the class id
    int id = control[j].getInt("id");
    //get the value from the class moouseClick
    String event = control[j].getString("mouseClick");
    // get the content inside of the mouseEvent tag
    String outcome = control[j].getContent();
    println(id + ", " + event + "= " + outcome);
  }

//same procedure from above but applied to keyboardEvent tags
  for (int i = 0; i < controllers.length; i++) {
    int id = controllers[i].getInt("id");
    String event = controllers[i].getString("keyPressed");
    String outcome = controllers[i].getContent();
    println(id + ", " + event + "= " + outcome);
  }

// smooth edgrs (anti ailisaing)
  smooth();
  minim = new Minim(this);
  //load in the audio file
  music = minim.loadFile("Eminem.mp3", 512);
  //play the audio file
  music.play();
  //in = minim.getLineIn();
  
  //on setup loop through the length of the array drops and craetes the drops
  for ( int i =0; i< drops.length; i++) {
    drops[i] = new Drop();
  }


  video = new Capture(this, 1280, 720);
  video.start();
}

void captureEvent(Capture video) {
  // Read image from the camera Note: does not display video
  video.read();
}

void draw() {
  //re-draws background on every frame 
  background(160, 200, 210);

//load the pixels for the video
  video.loadPixels();
  
  // looping through the the length of the array drops(500) and calling the 2 funtions fall() and update()
  for ( int i =0; i< drops.length; i++) { 
    drops[i].fall();
    drops[i].update();

//looping through the x pixels of the video for every instance where the x point of a drop passes over it 
//if drops.x = 10 then it would loop through every 10nth pixel, these values are constantly changing 
//so the distance between the resulting shapes that will be drawn are also changing to these values
    for (int x = 0; x < video.width; x +=drops[i].x ) {
     
      //looping through the y pixels of the video for every instance where the y point of a drop passes over it
      for (int y = 0; y < video.height; y +=drops[i].y ) {

        //formula to detect specific pixels
        int loc = (video.width - x - 1) + y*video.width;
        
        //takes the color value from the video being captured and aplies that colour to that pixel
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);

        //fill coulour to be used on shapes wehre the rgb values are taken from the video being captured
        fill(r, g, b, 130);
        noStroke();


        //centers the video to be central on the canvas
        int shapeX, shapeY;
        shapeX = x + (width - video.width)/2;
        shapeY = y + (height - video.height)/2;

        shapeX += random(-5, 5);
        shapeY += random(-5, 5);


        //float to be used to determine the size of the shapes drawn to display the video
        // the size of the shape increases the further the mouse cursor is along the canvas
        float size = map(mouseX, 0, width, 1, 50);

        if (keyPressed== true && keyCode == LEFT) {
          //draws triangles to display the video when the left arrow key is pressed
          triangle(shapeX, shapeY, shapeX-random(10, 25)*2, shapeY+random(10, 25)*2, shapeX+random(10, 25)*2, shapeY+random(10, 25)*2);
        }

        if (keyPressed== true && keyCode == RIGHT) {
          //draws squares to display the video when the right arrow key is pressed
          rect(shapeX, shapeY, size, size);
        } else {
          //if no key is pressed draw ellipses on every point a drops x and y position is over the video capture are using colours the video is capturing
          ellipse(shapeX, shapeY, size, size);
          
        }
      }
    }
  }




  if (mousePressed == true) {
    //when the mouse is clicked and held the colour mode changes to HSB
    colorMode(HSB);
  } else {
    colorMode(RGB);
  }
}