import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

// global variables
ControlP5 cp5;
SamplePlayer music;
SamplePlayer click;
Gain g;
Glide gainGlide;
Double musicLength;
int buttonsY;
Button playButton;
Button stopButton;
Button ffButton;
Button rewButton;
Button resetButton;
//AudioContext ac; is declared in helper_functions
//end global variables

void setup() {
  size(300, 400); //size(width, height) must be the first line in setup()
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions
  
  // create music SamplePlayer
  music = getSamplePlayer("intermission.wav", false);
  music.pause(true);
  musicLength = music.getSample().getLength();
    
  // create 'click' SamplePlayer
  click = getSamplePlayer("button-16.wav", false);
  click.pause(true);
  
  // Gain and glide
  gainGlide = new Glide (ac, 1.0, 1000);
  g = new Gain(ac, 1, gainGlide);
  // connect music SP to gain
  g.addInput(music);
  
  // End Listener
  music.setEndListener(new Bead() {
        public void messageReceived(Bead message) {
            if (music.getPosition() >= musicLength) {
              // dont set to end yet
              music.pause(true);
              music.setRate(new Glide(ac, -1 ,0)); // makes it so only able to rewind
              music.setToEnd();
            } else if (music.getPosition() <= 0.0){
              // sample is rewinded all the way
              music.pause(true);
              music.setRate(new Glide(ac, 1, 0));
              music.reset();
            }
        }
  });
  
  // connect music Gain and click to output to AudioContext
  ac.out.addInput(g);
  ac.out.addInput(click);
  ac.start();
  
  // UI Controls
  cp5 = new ControlP5(this);
  buttonsY = 350;  // the Y coordinate of the buttons
    
  playButton = cp5.addButton("play")
    .setSize(40, 50)
    .setPosition(30, buttonsY)
    .setColorBackground(color(100));
  
  stopButton = cp5.addButton("stopButton")
    .setSize(40, 50)
    .setPosition(75, buttonsY)
    .setLabel("Stop")
    .setColorBackground(color(100));
  
  ffButton = cp5.addButton("fastforward")
    .setSize(40, 50)
    .setPosition(120, buttonsY)
    .setLabel("F.F.")
    .setColorBackground(color(100));
  
  rewButton = cp5.addButton("rewind")
    .setSize(40, 50)
    .setPosition(165, buttonsY)
    .setLabel("Rew.")
    .setColorBackground(color(100));
  
  resetButton = cp5.addButton("reset")
    .setSize(40, 50)
    .setPosition(210, buttonsY)
    .setColorBackground(color(100));
    
  cp5.addKnob("volumeKnob")
    .setPosition(255, 350)
    .setRange(0,100)
    .setLabel("Volume")
    .setValue(100)
    .setColorBackground(color(100))
    .setColorForeground(color(255))
    .setLabelVisible(false);
    
}

public void play() {
  println("play button pressed at ", music.getPosition());
  resetButtons();
  playButton.setColorBackground(255);
  // play click noise
  click.start();
  music.setRate(new Glide(ac, 1, 0)); //set rate to normal
  music.start();
  click.reset();
}

public void stopButton() {
  println("stop button pressed at ", music.getPosition());
  resetButtons();
  stopButton.setColorBackground(255);
  // play click noise
  click.start();
  music.pause(true);
  click.reset();
}

public void fastforward() {
  println("fastforward button pressed at ", music.getPosition());
  resetButtons();
  ffButton.setColorBackground(255);
  // play click noise
  click.start();
  music.setRate(new Glide(ac, 2, 0)); //set rate to double time
  music.start();
  click.reset();
}

public void rewind() {
  println("rewind button pressed at ", music.getPosition());
  resetButtons();
  rewButton.setColorBackground(255);
  // play click noise
  click.start();
  music.setRate(new Glide(ac, -2, 0)); //set rate to double backwards
  music.start();
  click.reset();
}

public void reset() {
  println("reset button pressed");
  resetButtons();
  resetButton.setColorBackground(255);
  // play click noise
  click.start();
  music.pause(true);
  music.reset();
  click.reset();
}

// sets color of buttons to un-pressed
public void resetButtons() {
  stopButton.setColorBackground(color(100));
  playButton.setColorBackground(color(100));
  ffButton.setColorBackground(color(100));
  rewButton.setColorBackground(color(100));
  resetButton.setColorBackground(color(100));
}

public void volumeKnob(float value) {
  gainGlide.setValue(value/100.0);
}

void draw() {
  background(150); // gray background
  noStroke();
  
  // draw speaker box
  fill(150);
  rect(10, 10, 280, 155, 6);
  fill(0); // black
  stroke(0);
  int x = 15;
  while (x <= 285) {
    int y = 15;
    while (y <= 160) {
      ellipse(x, y, 1, 1);
      y = y + 6;
    }
    x = x + 6;
  }
  
  // draw tape deck
  stroke(0);
  fill(200);
  rect(10, 175, 280, 155, 6);
  // draw tape deck cover
  stroke(0);
  fill(100);
  rect(50, 205, 200, 65, 6);
  // draw gears
  fill(0);
  Gear g1 = new Gear(100, 240);
  g1.display();
  Gear g2 = new Gear(200, 240);
  g2.display();
}

class Gear {
  float x, y;
  Gear (float xpos, float ypos) {
    x = xpos;
    y = ypos;
  }

  void display() {
    ellipse(x, y, 30, 30);
    rect(x-5, y-20, 10, 40);
    rect(x-20, y-5, 40, 10);
  }
}
