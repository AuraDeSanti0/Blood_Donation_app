<?php
include "conn.php";

$phone = $_POST['phone'];
$pwd = $_POST['pwd'];
//phone = '98765';
//$pwd = '9999';
//$sql="SELECT * FROM donor_users WHERE phone='".$phone."'and pwd='".$pwd."'";
$sql1="SELECT * FROM hospital_users WHERE phone='".$phone."'";
$response = array();
$queryResult=mysqli_query($connect, $sql1);
if(mysqli_num_rows($queryResult)>=1){
	$row=mysqli_fetch_assoc($queryResult);
	if($row["pwd"]==$pwd){
		echo json_encode($row);
		$response['code'] = '1';
		$response['message'] = 'success message.';
	}else{
    $response['code'] = '2';
    $response['message'] = 'wrong pwd.';
	echo json_encode($response);
	}
}else{
	$response['code'] = '3';
    $response['message'] = 'no user.';
	echo json_encode($response);
	}
?>