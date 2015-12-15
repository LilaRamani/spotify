class Country implements Comparable<Country> {
  String id;
  int total_streams;
  int max;
  IntDict nationalities;
  
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
  
  public int compareTo(Country c) {
    int returnVal = 0;
    if(!this.id.equalsIgnoreCase(c.id)) {
      return this.id.compareTo(c.id);
    }
    return returnVal;
  }
  
}
