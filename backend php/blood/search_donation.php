<?php

include "conn.php";

$bloodtype = $_POST['bloodtype'];
$city = $_POST['city'];

$response = array();

$sql = "select du.id, du.name, du.phone, du.bloodtype, max(date) as lastdate from donor_users du inner join blood_donations bd on du.sfz = bd.sfz where du.bloodtype = '".$bloodtype."' and du.city = '".$city."' group by du.id";

$queryResult=mysqli_query($connect, $sql);

$result = array();

while($row=mysqli_fetch_assoc($queryResult)){
	$result[] =$row;
}

echo json_encode($result);