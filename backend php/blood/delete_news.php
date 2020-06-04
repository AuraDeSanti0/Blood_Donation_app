<?php

include "conn.php";

$n_id = $_POST['n_id'];

$sql1= "DELETE FROM news WHERE n_id ='".$n_id."'";
						
$rst1=mysqli_query($connect,$sql1);

