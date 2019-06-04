<!DOCTYPE HTML>
<html>
<head>
<style>
#div1 {
  width: 500px;
  height: 300px;
  padding: 10px;
  border: 1px solid #aaaaaa;
}
</style>
<script>
function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("text");
  ev.target.appendChild(document.getElementById(data));
}
</script>
</head>
<body>

<p>Drag the W3Schools image into the rectangle:</p>

<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
<br>
<img id="drag1" src="img/hospital.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag2" src="img/bones.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag3" src="img/dog.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag4" src="img/bath.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag5" src="img/facial-treatment.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag6" src="img/school.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
<img id="drag7" src="img/pet-house.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">

</body>
</html>
