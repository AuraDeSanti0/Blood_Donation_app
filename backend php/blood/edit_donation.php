<?php

include "conn.php";

$d_id = $_POST['d_id'];
$sfz = $_POST['sfz'];
$date = $_POST['date'];

$response = array();

$sql1 = "SELECT id from donor_users where sfz='$sfz'";
$rst=mysqli_query($connect,$sql1);
if(mysqli_fetch_row($rst)){
	$sql = "update blood_donations set sfz='".$sfz."', date ='".$date."' where d_id='".$d_id."'";
	$rst1=mysqli_query($connect,$sql);
	if(rst1){
    $response['code'] = '1';
    $response['message'] = 'success message.';
  }else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}
}
else{
	$response['code'] = '3';
    $response['message'] = 'user doesnt exist.';
}


echo json_encode($response);