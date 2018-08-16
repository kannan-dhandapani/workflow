$(document).ready(function() {
    $("#addattr").click(function(e) {
        $("#additem").append('<div class="form-group" id="deleteitem"><input type="text" name="keyname" id="keyid" class="form-control" placeholder="Key">' + '<input type="text" name="keyvalue" id="keyvalue" class="form-control" placeholder="Value">' + '<input type="button" value="-" id="delete" class="btn btn-primary" onclick="javascript:removeElement(); return false;" ></div>');
        //$("#additem").append('<%= text_area_tag :mdesc, params[:mdesc], placeholder: "Description", class: "form-control", rows: "4" %>');
    });
});

function removeElement() {
    var element = document.getElementById("deleteitem");
    element.parentNode.removeChild(element);
}
