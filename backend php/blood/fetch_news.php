<?php

//header("Content-type: image/jpg");
include "conn.php";

$license = $_POST['license'];

$sql = "SELECT n.n_id, h.name as name, n.license, n.date, n.msg, n.image from news n inner join hospital_users h on n.license = h.license WHERE h.license='".$license."' ORDER BY n.date DESC";
$queryResult=mysqli_query($connect, $sql);

$result = array();

while($row=mysqli_fetch_assoc($queryResult)){
	//$row['image'] = base64_encode($row['image']);
	$result[] =$row;
}

echo json_encode($result);
