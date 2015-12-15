class BarChart {
  int margin = 30;
  float x, y, w, h;
  
  BarChart(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  private void clearRegion() {
    fill(255);
    stroke(255);
    rect(0, 0, .6 * width, height); 
  }
  
  private void drawAxes() {
    stroke(0);
    line(x, y, x, (height - margin));
    line(x, (height - margin), (.55 * width), (height - margin));
  }
  
  void display(ArrayList<Country> c, HashMap<String,Color> nats) {
    clearRegion();
    drawAxes();
    textAlign(LEFT);
    
    float max = 0;
    for (int m = 0; m < c.size(); m++) {
      if (c.get(m).total_streams > max) {
        max = c.get(m).total_streams;
      }
    }
    //Display y axis marks
    int marker = 20000000;
    for (float j = 1; j <= 7; j++) {
      textSize(10);
      fill(0);
      float thing = j/7;
      text(marker, 2, height - ((height - margin -y) * thing));
      marker += 20000000;
    }
    
    
    java.util.Collections.sort(c);
    
    float padding = width * .002;
    stroke(0);
    //fill(color(100,200,50));
    for (int i = 0; i < c.size(); i++) {
      float barW = (.55 * width) / c.size();
      float curr_y = (height - margin);
      float barX = x + (i * barW) + padding;
      for (String n : c.get(i).nationalities.keys()) {
        fill(nats.get(n).c);
        float barH = (c.get(i).nationalities.get(n)/max) * ((height - margin) - margin);
        float barY = curr_y - barH;
        rect(barX, barY, barW - padding, barH);
        curr_y -= barH;
      }
      c.get(i).setX(barX, barX + barW - padding);
      float currMidPoint = x + (i * barW) + (barW/4);
      textSize(10);
      fill(0);
      pushMatrix();
      translate(currMidPoint, height - 19);
      rotate(radians(15));
      text(c.get(i).id, 0, 0);
      popMatrix();
    }
    
  }
  
  void display(Artist a, HashMap<String,Color> n) {
    clearRegion();
    drawAxes();
    
    a.streams.sortKeys();
    
    float max = 0;
    for (String m : a.streams.keys()) {
      if (a.streams.get(m) > max) {
        max = a.streams.get(m);
      }
    }
    
    float padding = width * .002;
    stroke(0);
    int iter = 0;
    for (String i : a.streams.keys()) {
      float barW = (.55 * width) / a.streams.size();
      float barX = x + (iter * barW) + padding;
      float barH  = (a.streams.get(i)/max) * ((height - margin) - margin);
      float barY = height - margin - barH;
      fill(n.get(a.nationality).c);
      rect(barX, barY, barW - padding, barH);
      a.setX(barX, barX + barW - padding); 
      
      //draw x labels
      float currMidPoint = x + (iter * barW) + (barW/4);
      textSize(10);
      fill(0);
      pushMatrix();
      translate(currMidPoint, height - 19);
      rotate(radians(15));
      text(i, 0, 0);
      popMatrix();
      iter++;
    }
  }
  
  
}
