String path = "final_data.csv";
ArrayList <Artist> artists = new ArrayList<Artist>();
ArrayList <Country> countries = new ArrayList<Country>();
Boolean artist_clicked;
int buffer = 10;

BarChart barchart;

void setup() {
  size(1000,700);
  background(255);
  artist_clicked = false;
  
  loadStrings();
  frame.setResizable(true);
  barchart = new BarChart(30, 10, .5 * width, height);
}

void draw() {
  barchart.display(countries);
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    artist_clicked = true;
  } else {
    artist_clicked = false;
  }
}

void loadStrings() {
  String [] lines = loadStrings(path);
  
  for (int i = 0; i < lines.length; i++) {
    String [] row = split(lines[i], ",");
    String country = row[0];
    String artist_name = row[1];
    int curr_streams = (int)parseFloat(row[2]);
    String nationality = row[3];
    int a_index = -1;
    int c_index = -1;
    
    for (int j = 0; j < artists.size(); j++) {
      if (artists.get(j).name.equals(artist_name)) {
        a_index = j;
        //artists.get(j).addToDict(country, curr_streams);
      }
    }
    if (a_index == -1) {
      Artist artist = new Artist(artist_name, nationality);
      artists.add(artist);
      a_index = artists.indexOf(artist);
    }
    for (int k = 0; k < countries.size(); k++) {
      if (countries.get(k).id.equals(country)) {
        c_index = k;
      }
    }
    if (c_index == -1) {
      Country c = new Country(country);
      countries.add(c);
      c_index = countries.indexOf(c);
    }

    artists.get(a_index).addToDict(country, curr_streams);
    countries.get(c_index).addToDict(nationality, curr_streams);
  }
}
