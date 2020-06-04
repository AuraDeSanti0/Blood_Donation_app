<?php

$connect = mysqli_connect("localhost", "root", "root", "blood");
//$link = mysql_connect("localhost", "root", "root");

if($connect){
	//echo"Connected";
}
else{
	//echo "Connection Failed";
	exit();
}
mysqli_query($connect, 'set names utf8');

