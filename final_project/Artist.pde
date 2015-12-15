class Artist {
  String nationality;
  String name;
  int total_streams;
  int max;
  float x, y, radius;
  Boolean xyrSet;
  float x1, x2;
  IntDict streams;
  
  color grey;
  Boolean is_grey;
  
  Artist(String name, String nationality) {
    this.name = name;
    this.nationality = nationality;
    total_streams = 0;
    max = 0;
    streams = new IntDict();
    
    grey = color(100);
    is_grey = false;
    xyrSet = false;
  }
  
  void addToDict(String country, int stream) {
    if (!streams.hasKey(country)) {
      streams.set(country, stream);
    } else {
      streams.add(country, stream);
    }
    if (stream > max) {
      max = stream;
    }
    total_streams += stream;
  }
  
  void setXYR(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.radius = r;
    xyrSet = true;
  }
  
  void setX(float x1, float x2) {
    this.x1 = x1;
    this.x2 = x2;
  }
  
  Boolean in_bounds() {
    if (mouseX > (x-radius) && mouseX < (x+radius) && mouseY > (y-radius) && mouseY < (y+radius)) {
      return true;
    } else if (mouseX > x1 && mouseX < x2) {
      //return true;
    }
    return false;
  }
  
  void make_grey() {
    this.is_grey = true;
  }
  
}
