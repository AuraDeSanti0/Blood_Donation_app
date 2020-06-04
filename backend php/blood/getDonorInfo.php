<?php
include "conn.php";
mysqli_query($connect, 'set names utf8');

$id = $_POST['id'];
$sql="SELECT * FROM donor_users WHERE id='".$id."'";
$queryResult=mysqli_query($connect, $sql);

$result = array();

$row=mysqli_fetch_assoc($queryResult);
/*
while($row=$queryResult->fetch_assoc()){
	$result[] = $row;
}
*/
echo json_encode($row);
//echo($result);
?>