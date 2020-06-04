<?php
include "conn.php";
mysqli_query($connect, 'set names utf8');
$name = $_POST['name'];
$license = $_POST['license'];
$phone = $_POST['phone'];
$city = $_POST['city'];
$pwd = $_POST['pwd'];

$name=mysqli_real_escape_string($connect, $name);
$license=mysqli_real_escape_string($connect, $license);
$phone=mysqli_real_escape_string($connect, $phone);
$city=mysqli_real_escape_string($connect, $city);
$pwd=mysqli_real_escape_string($connect, $pwd);


$sql = "SELECT id from hospital_users where license='$license' OR phone='$phone'";
$rst=mysqli_query($connect,$sql);
if(mysqli_fetch_row($rst)==false){
	//die('exists');
	$sql1= "INSERT INTO hospital_users (license, name, phone, city, pwd) VALUES('$license', '$name', '$phone', '$city', '$pwd')";
						
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
}else {
	$response['code'] = '3';
    $response['message'] = 'user exists.';
}

echo json_encode($response);