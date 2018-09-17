/*
 * 2018/04/12
 * Metaball
 * Emma Freeman
 * 
 *
 * click to place a new metaball. 
 * Pressing enter changes whether you are adding or subtracting a metaball.
 * hit r to randomize colors.
 * Press up and down arrows to increase or decrease the size of your metaball.
 * Press side arrows to change brightness of colors.
 * Press s to save an image.
 * Press n to erase all metaballs.
 */
ArrayList<Blob> blobs = new ArrayList<Blob>();
float rad;

PGraphics paper;
PGraphics cursor;

float cursorfill;

boolean flipped;
int colors = 1; // 0 = bw, 1 = red, 2 = green, 3 = blue
int colorblob1;
int colorblob2;

void setup() {
  size(600, 600);
  rad = 20;
  paper = createGraphics(600, 600);
  cursor = createGraphics(600, 600);
}

void draw() {
  cursor.beginDraw();
  if (!flipped) {
    cursor.stroke(255);
  } else {
    cursor.stroke(0);
  }
  cursor.background(255, 255, 255, 0);
  cursor.ellipse(mouseX, mouseY, rad, rad);
  paper.beginDraw();
  paper.background(51);
  paper.loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;

      float sum = 0;
      for (int m=0; m<blobs.size(); m++) {
        Blob blob = blobs.get(m);
        float d = dist(x, y, blob.pos.x, blob.pos.y);
        sum += 150 * blobs.get(m).r / d;
      } 
      if (colors == 0) {
        paper.pixels[index] = color(sum);
      } else if (colors == 1) {
        paper.pixels[index] = color(sum, colorblob1, colorblob2);
      } else if (colors == 2) {
        paper.pixels[index] = color(colorblob1, sum, colorblob2);
      }
      else if (colors == 3) {
        paper.pixels[index] = color(colorblob1, colorblob2, sum);
      }
    }
  }
  cursor.noFill();
  cursor.endDraw();
  paper.updatePixels();
  for (Blob b : blobs) {
    b.update();
    b.show();
  }
  paper.endDraw();

  image(paper, 0, 0);
  image(cursor, 0, 0);
}

void mousePressed() {
  blobs.add(new Blob(mouseX, mouseY, rad));
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (!flipped) {
        rad+=10;
      } else {
        rad-=10;
      }
    }
    if (keyCode == DOWN) {
      if (!flipped) {
        if (rad > 0) {
          rad-=10;
        }
      } else {
        rad += 10;
      }
    }
    if (keyCode == LEFT) {
      if (colorblob1 > 0) {
        colorblob1 -= 5;
      }
      if (colorblob2 > 0) {
        colorblob2 -= 5;
      }
    }
    if (keyCode == RIGHT) {
      if (colorblob1 < 255) {
        colorblob1 += 5;
      }
      if (colorblob2 < 255) {
        colorblob2 += 5;
      }
    }
  }
  if (key == 'r') {
    colorblob1 = int(random(0, 255));
    colorblob2 = int(random(0, 255));
  }
  if (key == 'e') {
    colorblob1 = 100;
    colorblob2 = 100;
  }
  if (key == ENTER) {
    flipped = !flipped;
    rad = -rad;
  }
  if (key == 'n') {
    blobs = new ArrayList<Blob>();
  }
  if (key == 's') {
    int saved = int(random(0, 1000));
    paper.save("screen" + str(saved) + "jpg");
    println("Saved");
  }
  if (key == '0') {
    colors = 0;
  }
  if (key == '1') {
    colors = 1;
  }
  if (key == '2') {
    colors = 2;
  }
  if (key == '3') {
    colors = 3;
  }
}
