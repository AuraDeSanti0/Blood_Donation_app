<?php
include "conn.php";

$phone = $_POST['phone'];
$pwd = $_POST['pwd'];

$queryResult=$connect->query("SELECT * FROM hospital_users WHERE phone='".$phone."'and pwd='".$pwd."'");

$result = array();

while($row=$queryResult->fetch_assoc()){
	$result[] = $row;
}

echo json_encode($result);
//echo($result);
?>