<?php 
//header("Content-type: image/jpg");
include "conn.php";

$license = $_POST['license'];

$sql = "SELECT image from news WHERE license='".$license."'";
$queryResult=mysqli_query($connect, $sql);

$result = array();

while($row=mysqli_fetch_assoc($queryResult)){
	$result[] =$row;
}

echo json_encode($result);