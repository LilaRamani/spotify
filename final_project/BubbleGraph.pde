
class BubbleGraph {
  int buffer;
  float radius;
  float w;
  
  BubbleGraph(float w, int buffer) {
    this.w = w;
    this.buffer = buffer;
    radius = 0;
  }
  
  void display(ArrayList<Artist> a, HashMap<String,Color> n) {
    //java.util.Collections.shuffle(a);
    ellipseMode(RADIUS);
    int max = getMax(a);
    float x = .58 * width;
    float y = 0;
    Boolean new_row = false;
    float prev_rad = 0;
    for (int i = 0; i < a.size(); i++) {
      radius = sqrt(buffer * ((float)a.get(i).total_streams/max));
      if (y == 0) {y = radius;}
      if (!new_row) {
        x += radius;
      } else {
        //y += radius;
      }
      fill(n.get(a.get(i).nationality).c);
      if ((x + radius) > width) {
        y += prev_rad;
        x = .58 * width + radius;
        new_row = true;
        prev_rad = 0;
        ellipse(x, y, radius, radius);
      } else {
        ellipse(x, y, radius, radius);
        x += radius + 2;
        new_row = false;
      }
      if (radius > prev_rad) {
        prev_rad = radius;
      }
    }
    
    
  }
  
  int getMax(ArrayList<Artist> a) {
    int max = 0;
    for (int i = 0; i < a.size(); i++) {
      if (a.get(i).total_streams > max) {
        max = a.get(i).total_streams;
      }
    }
    return max;
  }
  
  
}
