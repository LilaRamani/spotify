abstract class Chart {
  protected float margin = 10;
  protected float leftX = -1;
  protected float leftY = -1;
  protected float chartWidth = 0;
  protected float chartHeight = 0;
 
  Chart(float x, float y, float w, float h) {
    this.leftX = x;
    this.leftY = y;
    this.chartWidth = w;
    this.chartHeight = h;
  }
 
  void drawAxes() {
    fill(0);
    line(leftX, leftY, leftX, leftY + chartHeight);
    line(leftX, leftY + chartHeight, leftX + chartWidth, leftY + chartHeight);
  }
  
  void clearRegion() {
    fill(255);
    noStroke();
    rect(0, leftY - margin, width, chartHeight + margin * 2);
    strokeWeight(1);
    stroke(0);
  }
}

//class BarChart extends Chart {
//  BarChart(float x, float y, float w, float h) {
//    super(x, y, w, h);
//  }
  
  
//}
