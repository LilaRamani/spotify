$(document).ready( function() {
	console.log("hi");
	$.ajax({
            type:"POST",
            beforeSend: function (request)
            {
                request.setRequestHeader("Authorization", "Basic YTdkY2YxYTZkNDljNDdkMGI0ZGQyNjRkN2RhODgxMDk6IDcxZjlkNTdjNzYwNTQ0Y2VhMzc2MWQxM2E1YmFkZmM4DQo=");
            },
            url: "https://accounts.spotify.com/api/token",
            data: "grant_type=client_credentials",
            processData: false,
            success: function(msg) {
            	 console.log(data);
            }
    });
});