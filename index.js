$(document).ready( function() {
	console.log("hi");
	var client_id = 'a7dcf1a6d49c47d0b4dd264d7da88109'; // Your client id
	var client_secret = '71f9d57c760544cea3761d13a5badfc8'; // Your client secret
	$.ajax({
            type:"POST",
            headers: {
                'Authorization': 'Basic ' + (new Buffer(client_id + ':' + client_secret).toString('base64')),
                'Content-Type':'application/json'
            },
            url: "https://accounts.spotify.com/api/token",
            dataType: 'json',
            data: {grant_type: 'client_credentials'}
            success: function(msg) {
            	 console.log(data);
            }
    });
});

