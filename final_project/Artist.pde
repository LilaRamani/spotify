class Artist {
  String nationality;
  String name;
  int total_streams;
  int max;
  IntDict streams;
  
  Artist(String name, String nationality) {
    this.name = name;
    this.nationality = nationality;
    total_streams = 0;
    max = 0;
    streams = new IntDict();
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
  
  
}
