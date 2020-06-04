<?php
include "conn.php";
$id = $_POST['id'];
$name = $_POST['name'];
//$license = $_POST['license'];
$phone = $_POST['phone'];
$city = $_POST['city'];
$pwd = $_POST['pwd'];

$name=mysqli_real_escape_string($connect, $name);
$license=mysqli_real_escape_string($connect, $license);
$phone=mysqli_real_escape_string($connect, $phone);
$city=mysqli_real_escape_string($connect, $city);
$pwd=mysqli_real_escape_string($connect, $pwd);

$sql1 = "update hospital_users set name='".$name."',phone='".$phone."', city='".$city."', pwd='".$pwd."' where id='".$id."'";						
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