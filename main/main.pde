
//WINDOW SIZE
//NOTE: to change window size, change the two values below
// and the parameters in size() function in the setup() method
int window_h = 500;
int window_w = 500;

//GLOBAL VARIABLES
int num_points = 1000;
int modulo = num_points;
float multiplier = 2;
float multiplier_modifier = 1;
PVector[] points;
float r = 250;


void setup() {
  size(500, 500);
}

void draw() {
  initialize_circle();
  calibrate_points();
  display_labels();
  draw_lines(multiplier, modulo);
}



//draw the circle
void initialize_circle() {
  clear();
  background(0);
  noFill();
  stroke(254, 100);
  ellipse(window_w/2, window_h/2, r*2, r*2);
}

//obtain points on the circle
void calibrate_points() {
  points = new PVector[num_points];
  float a = 360/(float)num_points;
  for (int i = 0; i < num_points; i++) {
    float x = r*cos(radians(a*i));
    float y = r*sin(radians(a*i));
    PVector v = new PVector(x, y);
    
    points[i] = v;
  }
}

//display N, multiplier, and modulo values
void display_labels() {
  String lbl_N = "N: " + num_points;
  String lbl_multiple = "Multiplier: " + multiplier;
  String lbl_modulo = "Modulo: " + modulo;
  String lbl = lbl_N + "\n" + lbl_multiple + "\n" + lbl_modulo;
  
  fill(255);
  text(lbl, window_w - 100, window_h - 50, window_w, window_h);
}

//draw the lines by calling on connect_modulo for each point
void draw_lines(float mult, int mod) {
  for (int i = 0; i < num_points; i++) {
    //connect(i, mod);
    connect_modulo(i, mult, mod);
  }
}

/*
//connect a point (indicated by start_index) to all other dots defined by modulo
void connect(int start_index, int modulo) {
  int r = 255 - start_index*255/num_points;
  int b = 193;
  int g = 89;
  PVector p_start = points[start_index];
  
  pushMatrix();
  translate(window_w/2, window_h/2);
  noStroke();
  fill(r, g, b, 30);
  ellipse(p_start.x, p_start.y, 10,10);
  for (int i = 0; i < num_points; i += modulo) {
    if (i != start_index) {
      PVector p_dest = points[i];
      stroke(r, g, b, 50);
      line(p_start.x, p_start.y, p_dest.x, p_dest.y);
    }
  }
  popMatrix();
}
*/

//connect a point (start_index) to the point determined by index*mult%mod
void connect_modulo(int start_index, float multiplier, int modulo) {
  int dest_index = (int)(start_index*multiplier)%modulo;
  PVector p_start = points[start_index];
  PVector p_dest = points[dest_index];
  
  int r = 255 - start_index*255/num_points;
  int g = 128 + start_index*255/num_points;
  int b = 0 + start_index*255/num_points;
  
  pushMatrix();
  translate(window_w/2, window_h/2);
  noStroke();
  fill(r, g, b, 40);
  stroke(r, g, b, 50);
  line(p_start.x, p_start.y, p_dest.x, p_dest.y);
  popMatrix();
}

//reacts to keys:
//  up/down changes modulo value;
//  left/right changes multiplier
//  1/2/3 changes multiplier modifier to 1/0.1/0.01
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (modulo != num_points) modulo++;
    }
    else if (keyCode == DOWN) {
      if (modulo > 1) modulo--;
    }
    else if (keyCode == LEFT) {
      if (multiplier > 1) multiplier -= multiplier_modifier;
    }
    else if (keyCode == RIGHT) multiplier += multiplier_modifier;
  }
  else {
    if (key == '1') multiplier_modifier = 1;
    else if (key == '2') multiplier_modifier = 0.1;
    else if (key == '3') multiplier_modifier = 0.01;
  }
}
