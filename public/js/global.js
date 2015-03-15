//Captures click on menu image
window.onload = function(){
var publicMenuLink = document.getElementById("publicMenuAnchor");

console.log(publicMenuLink);

publicMenuLink.addEventListener("click", function(event) {
  event.preventDefault();
  console.log("hello world!");
  if (document.getElementById("publicMenu").style.display === "none"){
    document.getElementById("publicMenu").style.display = "block";
    document.getElementById("jsReaffirm").style.backgroundColor = "#dfdfdf";
  }
  else {
    document.getElementById("publicMenu").style.display = "none";
    document.getElementById("jsReaffirm").style.backgroundColor = "";
  }
});
//
// var adminMenuLink = document.getElementById("adminMenuAnchor");
//
// adminMenuLink.addEventListener("click", function(event) {
//   event.preventDefault();
//   if (document.getElementById("adminMenu").style.display === "none"){
//     document.getElementById("adminMenu").style.display = "block";
//     document.getElementById("adminjsReaffirm").style.backgroundColor = "#000000";
//   }
//   else {
//     document.getElementById("adminMenu").style.display = "none";
//     document.getElementById("adminjsReaffirm").style.backgroundColor = "";
//   }
// });


}