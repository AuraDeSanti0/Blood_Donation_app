<?php

include "conn.php";

$bloodtype = $_POST['bloodtype'];
$city = $_POST['city'];
//$bloodtype = 'B-';
//$city = "北京";
$sql = "SELECT du.id, du.name, du.phone, du.bloodtype, MAX( DATE ) AS lastdate
		FROM donor_users du
		LEFT JOIN blood_donations bd ON du.sfz = bd.sfz
		WHERE du.bloodtype =  '".$bloodtype."'
		AND du.city =  '".$city."'
		GROUP BY du.id
		UNION 
		SELECT du.id, du.name, du.phone, du.bloodtype, MAX( DATE ) AS lastdate
		FROM donor_users du
		RIGHT JOIN blood_donations bd ON du.sfz = bd.sfz
		WHERE du.bloodtype =  '".$bloodtype."'
		AND du.city =  '".$city."'
		GROUP BY du.id";
		
$queryResult=mysqli_query($connect, $sql);
$result = array();
while($row=mysqli_fetch_assoc($queryResult)){
	$result[] =$row;
}

echo json_encode($result);