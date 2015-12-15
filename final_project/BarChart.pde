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
    rect(0, 0, width, y); 
  }
  
  private void drawAxes() {
    stroke(0);
    line(x, y, x, (height - margin));
    line(x, (height - margin), (.5 * width), (height - margin));
  }
  
  void display(ArrayList<Country> c) {
    clearRegion();
    drawAxes();
    
    float max = 0;
    for (int m = 0; m < c.size(); m++) {
      if (c.get(m).total_streams > max) {
        max = c.get(m).total_streams;
      }
    }
    
    java.util.Collections.sort(c);
    
    float padding = width * .01;
    stroke(0);
    //fill(color(100,200,50));
    for (int i = 0; i < c.size(); i++) {
      float barW = (.5 * width) / c.size();
      float curr_y = (height - margin);
      fill(color(100,200,50));
      for (String n : c.get(i).nationalities.keys()) {
        float barH = (c.get(i).nationalities.get(n)/max) * ((height - margin) - margin);
        float barX = x + (i * barW) + padding;
        float barY = curr_y - barH;
        rect(barX, barY, barW - padding, barH);
        curr_y -= barH;
      }
      float currMidPoint = x + (i * barW) + (barW/4);
      textSize(12);
      fill(0);
      pushMatrix();
      translate(currMidPoint, height - 19);
      rotate(radians(15));
      text(c.get(i).id, 0, 0);
      popMatrix();
    }
    
  }
  
  
}
