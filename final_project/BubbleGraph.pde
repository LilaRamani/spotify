
class BubbleGraph {
  int buffer;
  float radius;
  Boolean first_time;
  float min_w, min_h, max_w, max_h;
  
  BubbleGraph(int buffer) {
    this.buffer = buffer;
    radius = 0;
    first_time = true;
  }
  
  void display(ArrayList<Artist> a, HashMap<String,Color> n) {
    min_w = .58*width;
    min_h = 0;
    max_w = width;
    max_h = height - 60;
    Boolean fits = false;
    
    //java.util.Collections.shuffle(a);
    ellipseMode(RADIUS);
    int max = getMax(a);
    
    for (int i = 0; i < a.size(); i++) {
      radius = sqrt(buffer * ((float)a.get(i).total_streams/max));
      if (first_time) {
        while(!fits) {
          float x = random(min_w, max_w);
          float y = random(min_h, max_h);
          if (in_graph_bounds(x, y, radius) && no_overlap(x, y, radius, a, i)) {
            fits = true;
            if (a.get(i).is_grey) {
              fill(200);
            } else {
              fill(n.get(a.get(i).nationality).c);
            }
            ellipse(x, y, radius, radius);
            a.get(i).setXYR(x, y, radius);
          }
        }
        fits = false;
      } else {
        if (a.get(i).is_grey) {
          fill(200);
        } else {
          fill(n.get(a.get(i).nationality).c);
        }
        ellipse(a.get(i).x, a.get(i).y, radius, radius);
      }
    }
    first_time = false;
  }
  
  Boolean in_graph_bounds(float x, float y, float r) {
    if ((x - r) >= min_w && (x + r) <= max_w && (y - r) >= min_h && (y + r) <= max_h) {
      return true;
    }
    return false;
  }
  
  Boolean no_overlap(float x, float y, float r, ArrayList<Artist> a, int iter) {
    for (int j = 0; j < a.size(); j++) {
      if (a.get(j).xyrSet) {
        float distance = dist(x, y, a.get(j).x, a.get(j).y);
        //println("Checking " + (r + a.get(j).radius) + " with " + distance);
        if (distance < (r + a.get(j).radius)) {
          //println(r);
          return false;
        }
      }
    }
    return true;
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
