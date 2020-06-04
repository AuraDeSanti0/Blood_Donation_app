<?php 

include "conn.php";

$n_id = $_POST['n_id'];
$license = $_POST['license'];
$date = $_POST['date'];
$msg = $_POST['msg'];

$sql = "INSERT INTO news (n_id,license, date, msg) VALUES('$n_id','$license', '$date', '$msg')";
$rst1=mysqli_query($connect,$sql);
if(rst1){
    $response['code'] = '1';
    $response['message'] = 'success message.';
  }else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}