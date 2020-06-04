<?php
include "conn.php";

mysqli_query($connect, 'set names utf8');
$name = $_POST['name'];
$sfz = $_POST['sfz'];
$phone = $_POST['phone'];
$bloodtype = $_POST['bloodtype'];
$city = $_POST['city'];
$pwd = $_POST['pwd'];
$birthday = $_POST['birthday'];
$sex = $_POST['sex'];

$name=mysqli_real_escape_string($connect, $name);
$sfz=mysqli_real_escape_string($connect, $sfz);
$phone=mysqli_real_escape_string($connect, $phone);
$bloodtype=mysqli_real_escape_string($connect, $bloodtype);
$city=mysqli_real_escape_string($connect, $city);
$pwd=mysqli_real_escape_string($connect, $pwd);
$sex=mysqli_real_escape_string($connect, $sex);

$sql = "SELECT id from donor_users where sfz='$sfz' OR phone='$phone'";
$rst=mysqli_query($connect,$sql);
if(mysqli_fetch_row($rst)==false){
	//die('exists');
	$sql1= "INSERT INTO donor_users (name, sfz, birthday,sex, phone, bloodtype, city, pwd) VALUES('$name', '$sfz', '$birthday','$sex', '$phone', '$bloodtype', '$city', '$pwd')";
						
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