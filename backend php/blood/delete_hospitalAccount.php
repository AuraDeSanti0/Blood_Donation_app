<?php

include "conn.php";

$license = $_POST['license'];

$sql1= "DELETE FROM hospital_users WHERE license ='".$license."'";
						
$rst1=mysqli_query($connect,$sql1);
