<?php

include "conn.php";

$city = $_POST['city'];

//$city=mysqli_real_escape_string($connect, $city);

$sql = "SELECT n.n_id, h.name as name, n.license, n.date, n.msg, n.image from news n inner join hospital_users h on n.license = h.license WHERE h.city='".$city."' ORDER BY n.date DESC";

$queryResult=mysqli_query($connect, $sql);

$result = array();

while($row=mysqli_fetch_assoc($queryResult)){
	//$row['image'] = base64_encode($row['image']);
	$result[] =$row;
}

echo json_encode($result);
