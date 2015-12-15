import java.util.Map;

String path = "final_data.csv";
ArrayList <Artist> artists = new ArrayList<Artist>();
ArrayList <Country> countries = new ArrayList<Country>();
HashMap<String, Color> nationalities = new HashMap<String, Color>();
Boolean artist_clicked;
int buffer = 10;
int radius_buffer = 20000;
color highlight = color(255, 255, 153);
color temp;
Boolean show_key = false;

Color [] colors = {
  new Color(color(141,211,199)),
  new Color(color(255,255,179)),
  new Color(color(190,186,218)),
  new Color(color(251,128,114)),
  new Color(color(128,177,211)),
  new Color(color(253,180,98)),
  new Color(color(179,222,105)),
  new Color(color(252,205,229)),
  new Color(color(217,217,217)),
  new Color(color(188,128,189)),
  new Color(color(204,235,197)),
  new Color(color(255,237,111)),
  new Color(color(166, 206, 227)),
  new Color(color(178,223, 138)),
  new Color(color(51, 160, 44)),
  new Color(color(251, 154, 153)),
  new Color(color(227, 26, 28)),
  new Color(color(253, 191, 111)),
  new Color(color(255, 127, 0)),
  new Color(color(202, 178, 214)),
  new Color(color(31, 120, 180)),
  new Color(color(106, 61, 154)),
  new Color(color(177, 89, 40))
};

BarChart barchart;
BubbleGraph bg;

void setup() {
  size(1000,700);
  background(255);
  artist_clicked = false;
  
  loadStrings();
  frame.setResizable(true);
  barchart = new BarChart(60, 10, .6 * width, height);
  bg = new BubbleGraph(.5 * width, radius_buffer);
  //java.util.Collections.shuffle(artists);
}

void draw() {
  background(255);
  barchart.display(countries, nationalities);
  bg.display(artists, nationalities);
  if (show_key) {
    make_key();
  } else {
    hover();
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    for (int i = 0; i < countries.size(); i++) {
      if (mouseX > countries.get(i).x1 && mouseX < countries.get(i).x2) {
        for (Map.Entry name : nationalities.entrySet()) {
          
        }
        makeArtistsGrey();
      }
    }
  } else {
    
  }
}

void keyPressed() {
  if (key == 107) {
    show_key = !show_key;
  }
}

void hover() {
  for (Map.Entry name : nationalities.entrySet()) {
    color current = get(mouseX, mouseY);
    Color val = (Color)name.getValue();
    if (current == val.c) {
      textSize(20);
      fill(0);
      String temp = (String)name.getKey();
      for (int i = 0; i < countries.size(); i++) {
        if (mouseX > countries.get(i).x1 && mouseX < countries.get(i).x2) {
          text(temp + ", " + countries.get(i).nationalities.get(temp), 120, 30);
        }
      }
    }
  }
  for (int j = 0; j < artists.size(); j++) {
    //if it's in the circle
    //text(artists.get(j).name + ", " + artists.get(j).total_streams, 120, 30);
  }
}

void makeArtistsGrey() {
  //if they're not in the country (or not in the nationality, I'm too tired to remember which one makes sense
  //fill(100)
  //THIS MAYBE BELONGS AS A BOOLEAN IN THE ARTIST CLASS THAT MAKES YOU COLOR YOURSELF GREY
}

void make_key() {
  fill(253, 255, 249, 127);
  rect(.38 * width, 10, .24 * width, height - 20);
  float y = 15;
  float increment = (height - 30)/nationalities.size();
  for (Map.Entry name : nationalities.entrySet()) {
    Color val = (Color)name.getValue();
    fill(val.c);
    rect(.39 * width, y, .22 * width, y + increment - 2);
    String temp = (String)name.getKey();
    textSize(16);
    textAlign(CENTER);
    fill(0);
    text(temp, .5 * width, (y + (y+increment))/2);
    y += increment;
  }
}

void loadStrings() {
  String [] lines = loadStrings(path);
  int color_iter = 0;
  
  for (int i = 0; i < lines.length; i++) {
    String [] row = split(lines[i], ",");
    String country = row[0];
    String artist_name = row[1];
    int curr_streams = (int)parseFloat(row[2]);
    String nationality = row[3];
    int a_index = -1;
    int c_index = -1;
    
    if (!nationalities.containsKey(nationality)) {
      nationalities.put(nationality, colors[color_iter]);
      color_iter++;
    }
    
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
