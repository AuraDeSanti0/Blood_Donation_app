<?php 

include "conn.php";

$n_id = $_POST['n_id'];
//$name = $_POST['hName'];
$license = $_POST['license'];
$date = $_POST['date'];
$msg = $_POST['msg'];
$image = $_FILES['image']['name'];

$imagePath ="uploads/".$image;
move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);
$sql = "INSERT INTO news (n_id,  license, date, msg, image) VALUES('$n_id', '$license', '$date', '$msg', '$image')";
$rst1=mysqli_query($connect,$sql);
if(rst1){
    $response['code'] = '1';
    $response['message'] = 'success message.';
  }else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}