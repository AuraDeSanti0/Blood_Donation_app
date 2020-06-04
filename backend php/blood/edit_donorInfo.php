<?php
include "conn.php";
mysqli_query($connect, 'set names utf8');
$id = $_POST['id'];
$name = $_POST['name'];
$sfz = $_POST['sfz'];
$birthday = $_POST['birthday'];
$sex = $_POST['sex'];
$phone = $_POST['phone'];
$bloodtype = $_POST['bloodtype'];
$city = $_POST['city'];
$pwd = $_POST['pwd'];

$name=mysqli_real_escape_string($connect, $name);
$sfz=mysqli_real_escape_string($connect, $sfz);
$phone=mysqli_real_escape_string($connect, $phone);
$bloodtype=mysqli_real_escape_string($connect, $bloodtype);
$city=mysqli_real_escape_string($connect, $city);
$pwd=mysqli_real_escape_string($connect, $pwd);
$sex=mysqli_real_escape_string($connect, $sex);

$sql1 = "update donor_users set name='".$name."',sfz='".$sfz."',birthday='".$birthday."', sex ='".$sex."',phone='".$phone."', bloodtype='".$bloodtype."',city='".$city."', pwd='".$pwd."' where id='".$id."'";						
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