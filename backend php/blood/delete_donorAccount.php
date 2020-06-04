<?php

include "conn.php";

$sfz = $_POST['sfz'];

$sql1= "DELETE FROM donor_users WHERE sfz ='".$sfz."'";
$sql2 ="DELETE FROM blood_donations WHERE sfz ='".$sfz."'";
						
$rst1=mysqli_query($connect,$sql1);
if($rst1){
	$rst2=mysqli_query($connect,$sql2);
}