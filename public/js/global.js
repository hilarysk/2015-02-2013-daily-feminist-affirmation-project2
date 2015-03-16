//Captures click on menu image
window.onload = function(){
var publicMenuLink = document.getElementById("publicMenuAnchor");

  publicMenuLink.addEventListener("click", function(event) {
    event.preventDefault();
    if (document.getElementById("publicMenu").style.display === "none"){
      document.getElementById("publicMenu").style.display = "block";
      document.getElementById("jsReaffirm").style.backgroundColor = "#dfdfdf";
    }
    else {
      document.getElementById("publicMenu").style.display = "none";
      document.getElementById("jsReaffirm").style.backgroundColor = "";
    }
  });


  //SUPPOSED TO MAKE MAIN YAY PAGE DYNAMIC; SAVE FOR LATER. NEED TO SET UP LIKE TABS? NOT SURE.
  

  // var publicReaffirm = document.getElementById("publicLayoutLink");
  //
  // var placeNewItem = function(eventObject) {
  //   var results = JSON.parse(this.response) //array of hashes
  //   console.log(results);
  //   document.getElementById("yieldPublic").innerHTML = results;
  // }
  //
  // publicReaffirm.addEventListener("click", function(event) {
  //   event.preventDefault();
  //   var req = new XMLHttpRequest;
  //   req.open("post", "http://localhost:4567/yay");
  //   req.send();
  //   req.addEventListener("load", function(eventObject) {
  //     var results = JSON.parse(this.response);
  //     console.log(results);
  //     document.getElementById("yieldPublic").innerHTML = results;
  //
  //
  //
  //   });
  //   });

}