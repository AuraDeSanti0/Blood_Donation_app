<?php
include "conn.php";

$n_id = $_POST['n_id'];
$msg = $_POST['msg'];
$image = $_FILES['image']['name'];

$imagePath ="uploads/".$image;
move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);
echo($imagePath);
$sql = "UPDATE news SET msg='".$msg."', image ='".$image."' where n_id='".$n_id."'";
$rst1=mysqli_query($connect,$sql);

