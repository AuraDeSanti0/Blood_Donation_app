<?php
include "conn.php";

$n_id = $_POST['n_id'];
$msg = $_POST['msg'];
$response = array();
$sql = "update news set msg='".$msg."' where n_id='".$n_id."'";
$rst1=mysqli_query($connect,$sql);
if(rst1){
    $response['code'] = '1';
    $response['message'] = 'success message.';
  }else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}

echo json_encode($response);