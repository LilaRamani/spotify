$( document ).ready(function() {    
    function getHashParams() {
          var hashParams = {};
          var e, r = /([^&;=]+)=?([^&;]*)/g,
              q = window.location.hash.substring(1);
          while ( e = r.exec(q)) {
             hashParams[e[1]] = decodeURIComponent(e[2]);
          }
          return hashParams;
    }
    
    var charts = [];
    var artists = {};
    var track_ids = [];
    var chart_numstreams = 0;

    var csvContentArray = [];
        
    $.ajax({
            type: "GET",
            url: "allcharts.csv",
            dataType: "text",
            success: function(allText) {
              //var csvContent = "data:text/csv;charset=utf-8,";
              var allTextLines = allText.split(/\r\n|\n/);
              var finished = false;
              for (var m = 0; m < allTextLines.length; m++) {
                if (m % 51 == 0) {
                  var country = [allTextLines[m]];
                  //csvContentArray.push(country);
                } else {
                  var data = allTextLines[m].split(',');
                  var temp_parse = data[4].split('/');
                  var track_id = temp_parse[4];
                  if (m == allTextLines.length - 2) {
                    console.log("Hi");
                    finished = true;
                  }
                  get_artist_nationality(track_id, data, finished, country);
                }
              }
              //console.log("About to give content");
              //var csvContent = "data:text/csv;charset=utf-8," + csvContentArray.join("\n");

              /*var allTextLines = allText.split(/\r\n|\n/);
              //var charts = [];
              //var artists = {};
              //var track_ids = [];
              var chart;
              for (var m = 0; m<allTextLines.length; m++) {
                if (m % 51 == 0) {
                  var country_id = allTextLines[m];
                  chart = {"name":country_id, "nationalities": {}, "total_streams": 0};
                } else {
                  var data = allTextLines[m].split(',');
                  var artist_name = data[2];
                  //var nationality;
                  chart_numstreams = parseInt(data[3]);
                  var temp_parse = data[4].split('/');
                  var track_id = temp_parse[4];
                  track_ids.push(track_id);

                  if (artist_name in artists) {
                    //nationality = artists[artist_name].nationality;
                    if (country_id in artists[artist_name].chart_streams) {
                      //console.log("Getting here, adding streams to existing index")
                      artists[artist_name].chart_streams[country_id] += chart_numstreams;
                    } else {
                      //console.log(country_id);
                      artists[artist_name].chart_streams[country_id] = chart_numstreams;
                      //console.log()
                    }
                  } else {
                    //nationality = get_artist_nationality(track_id);
                    var artist = {"totalstreams": 0, "nationality": "", "chart_streams": {}};
                    artist.chart_streams[country_id] = chart_numstreams;
                    artists[artist_name] = artist;
                  }
                  //console.log("Here!");
                  //console.log(nationality);
                  //if (nationality in chart.nationalities) {
                  //  chart.nationalities[nationality] += chart_numstreams;
                  //} else {
                  //  chart.nationalities[nationality] = chart_numstreams;
                  //}
                  chart.total_streams += chart_numstreams;
                  if (m % 51 == 50) {
                    charts.push(chart);  
                  }
                }
              }

              for (var i = 0; i < track_ids.length; i++) {
                //console.log(track_ids[i]);
                get_artist_nationality(track_ids[i], artists);
              }
              //console.log(charts);
              //console.log(artists);*/
            } 
    });

    function get_artist_nationality(trackid, line, finish, country) {
        var params = getHashParams();

        var userProfileSource = document.getElementById('user-profile-template').innerHTML,
            userProfileTemplate = Handlebars.compile(userProfileSource),
            userProfilePlaceholder = document.getElementById('user-profile');

        var oauthSource = document.getElementById('oauth-template').innerHTML,
            oauthTemplate = Handlebars.compile(oauthSource),
            oauthPlaceholder = document.getElementById('oauth');


        var access_token = params.access_token,
            refresh_token = params.refresh_token,
            error = params.error;

        if (error) {
          alert('There was an error during the authentication');
        } else {
          if (access_token) {
            // render oauth info
            //console.log("I have access token");
            oauthPlaceholder.innerHTML = oauthTemplate({
              access_token: access_token,
              refresh_token: refresh_token
            });
        
            $.ajax({
                  url: 'https://api.spotify.com/v1/tracks/' + trackid,
                  headers: {
                      'Authorization': 'Bearer ' + access_token
                  },
                  success: function(track) {
                      //console.log("track!");
                      var artist_id = track.artists[0].id;
                      //console.log(track.artists[0].name);
                      $.ajax({
                          url: 'http://developer.echonest.com/api/v4/artist/profile?api_key=SYQMGE9UITIW7I4XJ&id=spotify:artist:' + artist_id + '&format=json&bucket=artist_location',
                          //async: false,
                          
                        }).done(function(musician) {
                            console.log(musician);
                            var temp;
                            if (musician.response.artist.artist_location) {
                              temp = musician.response.artist.artist_location.country;
                            }

                            if (temp) {
                              console.log(line[2]);
                              console.log(line[3]);
                              var data = [country, line[2], line[3], temp];
                              csvContentArray.push(data);
                            } else {
                              var data = [country, line[2], line[3], "Other"];
                              csvContentArray.push(data);
                            }
                            //console.log("Done with my shit");

                            if (finish) {
                              console.log("About to load content");
                              var csvContent = "data:text/csv;charset=utf-8," + csvContentArray.join("\n");

                              var encodedUri = encodeURI(csvContent);
                              var link = document.createElement("a");
                              link.setAttribute("href", encodedUri);
                              link.setAttribute("download", "final_data.csv");

                              link.click();
                            }

                             /* for (var key in artists) {
                                if (key == musician.response.artist) {
                                  if (temp) {
                                    artists[key].nationality = temp;
                                  } else {
                                    artists[key].nationality = "Other";
                                  }
                                }
                              }*/

                            //if (temp in chart.nationalities) {
                            //  chart.nationalities[temp] = 

                            //}


                           // if (musician.response.artist.artist_location != undefined) {
                             // console.log(musician.response.artist.artist_location.country);
                            //  return musician.response.artist.artist_location.country;
                            //} else {
                            //  return "Other";
                            //}
                        }).fail(function(musician) {
                          console.log("ERROR");
                        });
                  }
            });
          }
          document.getElementById('obtain-new-token').addEventListener('click', function() {
            $.ajax({
              url: '/refresh_token',
              data: {
                'refresh_token': refresh_token
              }
            }).done(function(data) {
              access_token = data.access_token;
              oauthPlaceholder.innerHTML = oauthTemplate({
                access_token: access_token,
                refresh_token: refresh_token
              });
            });
          }, false);
        }
      }
    });

    
    /*
    function query_api(countries) {
        var params = getHashParams();

        var access_token = params.access_token,
            refresh_token = params.refresh_token,
            error = params.error;

        console.log(countries);
        if (error) {
          alert('There was an error during the authentication');
        } else {
          if (access_token) {
            // render oauth info
            oauthPlaceholder.innerHTML = oauthTemplate({
              access_token: access_token,
              refresh_token: refresh_token
            });
            
            //our request 
            for (i = 0; i < countries.length; i++) {
 
            $.ajax({
                url: 'https://api.spotify.com/v1/browse/categories/toplists/playlists?country=' + countries[i].country_code,
                headers: {
                  'Authorization': 'Bearer ' + access_token
                },
                success: function(country_chart) {
                  console.log(country_chart);
                  var url_string = country_chart.playlists.items[0].href;
                  $('#login').hide();
                  $.ajax({
                    url: url_string,
                    headers: {
                      'Authorization': 'Bearer ' + access_token
                    },
                    success: function(chart_tracks) {
                      console.log("tracks!");
                      console.log(chart_tracks);
                      for (var c = 0; c < chart_tracks.tracks.total; c++) {
                        //console.log(chart_tracks.tracks.items[c].track.artists[0].name);
                        var artist_name = chart_tracks.tracks.items[c].tracks.artists[0].name;
                        var artist_id = chart_tracks.tracks.items[c].track.artists[0].id;
                        $.ajax({
                          url: 
                          headers: {
                              'Authorization': 'Bearer ' + access_token
                          },
                          success: function(chart_tracks) {

                          }
                        });  
                        var artist = {"name": artist_name,"id":artist_id, "num_streams": 0, "nationality": ''};
                        artists.push(artist);
                        $.ajax({
                          url: 'http://developer.echonest.com/api/v4/artist/profile?api_key=SYQMGE9UITIW7I4XJ&id=spotify:artist:' + artist_id + '&format=json&bucket=artist_location',
                          
                        }).done(function(musician) {
                            console.log(musician.response.artist.name);
                            console.log(musician); 
                        }).fail(function(musician) {
                          console.log("ERROR");
                        });
                      }
                    }
                  });
                }
          });
          }
          } else {
              // render initial screen
              $('#login').show();
              $('#loggedin').hide();
          }
      }
    } */

    //document.getElementById('obtain-new-token').addEventListener('click', function() {
      //      $.ajax({
        //      url: '/refresh_token',
          //    data: {
            //    'refresh_token': refresh_token
              //}
//            }).done(function(data) {
  //            access_token = data.access_token;
    //          oauthPlaceholder.innerHTML = oauthTemplate({
      //          access_token: access_token,
        //        refresh_token: refresh_token
          //    });
            //});
    //}, false);
  //});
