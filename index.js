$(document).ready( function() {
	console.log("hi");
	$.ajax({
            type:"POST",
            headers:
            {
                'Authorization', 'Basic YTdkY2YxYTZkNDljNDdkMGI0ZGQyNjRkN2RhODgxMDk6IDcxZjlkNTdjNzYwNTQ0Y2VhMzc2MWQxM2E1YmFkZmM4DQo=',
                'Content-Type':'application/json'
            },
            url: "https://accounts.spotify.com/api/token",
            dataType: 'json',
            data: "grant_type=client_credentials",
            processData: false,
            success: function(msg) {
            	 console.log(data);
            }
    });
});