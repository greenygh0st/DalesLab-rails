$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

	// grap our upload form by its id
	var myzone = new Dropzone("#new_upload", {
		// restrict image size to a maximum 1MB
		maxFilesize: 10,
		// changed the passed param to one accepted by
		// our rails app
		paramName: "upload[image]",
		// show remove links on each image upload
		addRemoveLinks: true,

    init: function() {

      var thisDropzone = this;

        $.getJSON('./get_images', function(data) { // get the json response

            $.each(data, function(key,value){ //loop through it
                var mockFile = { name: value.location, size: value.size }; // here we get the file name and size as response

                thisDropzone.options.addedfile.call(thisDropzone, mockFile);

                thisDropzone.options.thumbnail.call(thisDropzone, mockFile, "../../../../"+value.location);//uploadsfolder is the folder where you have all those uploaded files
            });
        });
    },

		// if the upload was successful
		success: function(file, response){
			// find the remove button link of the uploaded file and give it an id
			// based of the fileID response from the server
			$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
			// add the dz-success class (the green tick sign)
			$(file.previewElement).addClass("dz-success");
		},
		//when the remove button is clicked
		removedfile: function(file){
			// grap the id of the uploaded file we set earlier
			var id = $(file.previewTemplate).find('.dz-remove').attr('id');

			// make a DELETE ajax request to delete the file
			$.ajax({
				type: 'DELETE',
				url: '/uploads/' + id,
				success: function(data){
					console.log(data.message);
				}
			});
		}
	});
});
