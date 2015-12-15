class Nationality {
  String id;
  color c;
  int streams;
  Boolean hover;
  
  Nationality(String id, int s) {
    this.id = id;
    this.streams = s;
    c = color(random(255), random(255), random(255));
    hover = false;
  }
  
}
