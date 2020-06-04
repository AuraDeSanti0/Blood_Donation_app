<?php

include "conn.php";

$license = $_POST['license'];

//$sql = "SELECT d.id,h.name,u.name, u.bloodtype , d.date from donor_users u INNER JOIN user_donations d ON u.sfz = d.sfz INNER JOIN hospital_users h ON d.license=h.license";
$sql = "SELECT d.d_id,h.name as hName,h.license,u.name as dName, u.sfz, u.bloodtype , d.date from donor_users u INNER JOIN blood_donations d ON u.sfz = d.sfz INNER JOIN hospital_users h ON d.license=h.license WHERE h.license='".$license."' ORDER BY d.date DESC";

$queryResult=mysqli_query($connect, $sql);

$result = array();

while($row=mysqli_fetch_assoc($queryResult)){
	$result[] =$row;
}

echo json_encode($result);