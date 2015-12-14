    (function() {
        function getHashParams() {
          var hashParams = {};
          var e, r = /([^&;=]+)=?([^&;]*)/g,
              q = window.location.hash.substring(1);
          while ( e = r.exec(q)) {
             hashParams[e[1]] = decodeURIComponent(e[2]);
          }
          return hashParams;
        }
        /*
        var country_codes = {
          "france": "fr",
          "argentina": "ar",
          "germany": "de",
          "usa": "us",
          "uk": "gb",
          "mexico": "mx",
          "sweden": "se",
          "costarica": "cr",
          "canada":"ca",
          "hongkong": "hk"
        }; */

        var countries = [
          {"country_code":"us", "name":"usa", "nationalities": {}},
          {"country_code":"gb", "name":"uk", "nationalities": {}},
          {"country_code":"mx", "name":"mexico", "nationalities": {}} 
        ];

        var artists = [];
        console.log(countries);

        var userProfileSource = document.getElementById('user-profile-template').innerHTML,
            userProfileTemplate = Handlebars.compile(userProfileSource),
            userProfilePlaceholder = document.getElementById('user-profile');

        var oauthSource = document.getElementById('oauth-template').innerHTML,
            oauthTemplate = Handlebars.compile(oauthSource),
            oauthPlaceholder = document.getElementById('oauth');

        var params = getHashParams();

        var access_token = params.access_token,
            refresh_token = params.refresh_token,
            error = params.error;

        if (error) {
          alert('There was an error during the authentication');
        } else {
          if (access_token) {
            // render oauth info
            oauthPlaceholder.innerHTML = oauthTemplate({
              access_token: access_token,
              refresh_token: refresh_token
            });
            $.ajax({
                url: 'https://api.spotify.com/v1/me',
                headers: {
                  'Authorization': 'Bearer ' + access_token
                },
                success: function(response) {
                  userProfilePlaceholder.innerHTML = userProfileTemplate(response);

                  $('#login').hide();
                  //$('#loggedin').show();
                }
            });
            
            //our request 
            for (i = 0; i < countries.length; i++) {
            console.log(countries[i].country_code);
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
                    /*    $.ajax({
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
                        });*/
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
      })();