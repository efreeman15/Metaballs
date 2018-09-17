class Blob {
  PVector pos;
  float r;
  PVector vel;

  Blob(float x, float y, float _r) {
    pos = new PVector(x, y);
    r = _r;
  }
  void update() {

    if (pos.x > width || pos.x < 0) {
      vel.x *= -1;
    }
    if (pos.y > height || pos.y < 0) {
      vel.y *= -1;
    }
  }
  void show() {
    paper.beginDraw();
    paper.noFill();
    paper.noStroke();
    paper.ellipse(pos.x, pos.y, r*2, r*2);
    paper.endDraw();
  }
}
