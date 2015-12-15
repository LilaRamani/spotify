import java.util.Map;

String path = "final_data.csv";
ArrayList <Artist> artists = new ArrayList<Artist>();
ArrayList <Country> countries = new ArrayList<Country>();
HashMap<String, Color> nationalities = new HashMap<String, Color>();

float total_w = -1, total_h = -1;
int artist_clicked;
int buffer = 10;
int radius_buffer = 10000;
color highlight = color(255, 255, 153);
color temp;
Boolean show_key = false;
Boolean intro = true;
Boolean topchart_screen = false;
Boolean artist_screen = false;
PImage icon;
PImage icon2;
String photo = "../spotify.png";
String justin = "../justin-bieber.png";

Color [] colors = {
  new Color(color(141,211,199)),
  new Color(color(255,255,179)),
  new Color(color(190,186,218)),
  new Color(color(251,128,114)),
  new Color(color(128,177,211)),
  new Color(color(253,180,98)),
  new Color(color(179,222,105)),
  new Color(color(252,205,229)),
  new Color(color(217,247,217)),
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
  total_w = displayWidth;
  total_h = displayHeight;
  size(displayWidth, displayHeight);
  background(255);
  artist_clicked = -1;
  
  icon = loadImage(photo);
  icon2 = loadImage(justin);
  
  loadStrings();
  frame.setResizable(true);
  barchart = new BarChart(60, 10, .6 * width, height);
  bg = new BubbleGraph(radius_buffer);
  //java.util.Collections.shuffle(artists);
}

void draw() {
  background(255);
  
  if (intro) {
    display_intro();
  } else if (topchart_screen) {
    display_topchart_screen();
  } else if (artist_screen) {
    display_artist_screen();
  } else {
  
    if (artist_clicked == -1) {
      barchart.display(countries, nationalities);
    } else {
      barchart.display(artists.get(artist_clicked), nationalities);
    }
    bg.display(artists, nationalities);
    if (show_key) {
      make_key();
    } else {
      hover();
    }
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    for (int j = 0; j < artists.size(); j++) {
      if (artists.get(j).in_bounds()) {
        artist_clicked = j;
      }
    }
    
    
    
    for (int i = 0; i < countries.size(); i++) {
      if (mouseX > countries.get(i).x1 && mouseX < countries.get(i).x2) {
        for (Map.Entry name : nationalities.entrySet()) {
          
        }
      }
    }
  } else {
    artist_clicked = -1;
  }
}

void keyPressed() {
  if (key == 107) {
    show_key = !show_key;
  }
  if (key == 32) {
    intro = false;
  }
  if (key == 110) {
    topchart_screen = true;
  }
  if (key == 98) {
    topchart_screen = false;
    artist_screen = false;
  }
  if (key == 97) {
     artist_screen = true;
  }
}

void hover() {
  Boolean found = false;
  for (Map.Entry name : nationalities.entrySet()) {
    color current = get(mouseX, mouseY);
    Color val = (Color)name.getValue();
    if (current == val.c) {
      found = true;
      textSize(16);
      fill(0);
      String temp = (String)name.getKey();
      if (artist_clicked == -1) {
        for (int i = 0; i < countries.size(); i++) {
          if (mouseX > countries.get(i).x1 && mouseX < countries.get(i).x2) {
            text(temp + ", " + countries.get(i).nationalities.get(temp), 120, 30);
            makeArtistsGrey(countries.get(i), temp);
          }
        }
      } else {
        for (String c : artists.get(artist_clicked).streams.keys()) {
          
        }
      }
    }
  }
  if (!found) {
    for (int k = 0; k < artists.size(); k++) {
      artists.get(k).is_grey = false;
    }
  }
  
  
  for (int j = 0; j < artists.size(); j++) {
    if (artists.get(j).in_bounds()) {
      textSize(16);
      fill(0);
      text(artists.get(j).name + ", " + artists.get(j).total_streams, 120, 30);
    }
  }
}

void makeArtistsGrey(Country c, String nat) {
  for (int i = 0; i < artists.size(); i++) {
    if (!(artists.get(i).nationality.equals(nat) && artists.get(i).streams.hasKey(c.id))) {
      artists.get(i).is_grey = true;
    } else {
      artists.get(i).is_grey = false;
    }
  }
}

void make_key() {
  fill(253, 255, 249, 127);
  rect(.1 * width, 20, .1 * width, 400);
  float y = 25;
  float increment = (410)/nationalities.size();
  for (Map.Entry name : nationalities.entrySet()) {
    Color val = (Color)name.getValue();
    fill(val.c);
    println(y + increment -2);
    rect(.11 * width, y, .08 * width, increment - 5);
    String temp = (String)name.getKey();
    textSize(11);
    textAlign(CENTER);
    fill(0);
    text(temp, .15 * width, (y + (y+increment))/2);
    y += increment;
  }
  textAlign(LEFT);
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

void display_intro() {
  textSize(32);
  textAlign(CENTER);
  fill(color(0));
  String text1 = "Visualizing Spotify Top Charts";
  text(text1, width/2, height/4);
  textSize(20);
  String text2 = "by Sam Weiser and Lila Ramani";
  text(text2, width/2, 3*height/4);
  imageMode(CENTER);
  image(icon, width/2, height/2);  
}
void display_topchart_screen() {
    textSize(20);
    textAlign(CENTER);
    fill(color(0));
    String text1 = "Which Top Chart is most diverse?";
    text(text1, width/2, height/4);
    String text2 = "Spain";
    text(text2, width/2, height/4 + 30);
    String text3 = "Which Chart has the most streams?";
    text(text3, width/2, 2*height/3);
    String text4 = "USA";
    text(text4, width/2, 2*height/3 + 30);  
}

void display_artist_screen() {
    textSize(20);
    textAlign(CENTER);
    fill(color(0));
    String text1 = "Which artist has the most streams?";
    text(text1, width/2, height/4);
    String text2 = "Justin Beiber";
    text(text2, width/2, height/4 + 30);
    String text3 = "Which country listens to itself the most?";
    text(text3, width/2, 2*height/3);
    String text4 = "France";
    text(text4, width/2, 2*height/3 + 30); 
    imageMode(CENTER);
    image(icon2, width/2, height/2);  
}