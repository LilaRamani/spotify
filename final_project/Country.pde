class Country implements Comparable<Country> {
  String id;
  int total_streams;
  int max;
  IntDict nationalities;
  float x1, x2;
  
  Country(String id) {
    this.id = id;
    total_streams = 0;
    max = 0;
    nationalities = new IntDict();
  }
  
  void addToDict(String n, int s) {
    if (!nationalities.hasKey(n)) {
      nationalities.set(n, s);
    } else {
      nationalities.add(n, s);
    }
    if (s > max) {
      max = s;
    }
    total_streams += s;
  }
  
  int getMax() {
    return max;
  }
  
  void setX(float x1, float x2) {
    this.x1 = x1;
    this.x2 = x2;
  }
  
  public int compareTo(Country c) {
    int returnVal = 0;
    if(!this.id.equalsIgnoreCase(c.id)) {
      return this.id.compareTo(c.id);
    }
    return returnVal;
  }
  
}
