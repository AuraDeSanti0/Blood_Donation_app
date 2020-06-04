<?php

include "conn.php";

$d_id = $_POST['d_id'];
$sfz = $_POST['sfz'];


$sql1= "DELETE FROM blood_donations WHERE d_id ='".$d_id."'";
						
$rst1=mysqli_query($connect,$sql1);

$response = array();
//do sql test and storing
if(rst1){
    $response['code'] = '1';
    $response['message'] = 'success message.';
}else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}
echo json_encode($response);