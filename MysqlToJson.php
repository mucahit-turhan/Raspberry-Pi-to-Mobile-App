<?php

$dbhost = 'localhost';
$dbuser = 'root';
$dbpassword = 'mucahit';
$dbname = 'temp_database';

try{

	$dbconnection = new mysqli($dbhost, $dbuser, $dbpassword, $dbname);

	$result = $dbconnection->query("SELECT * FROM tempLog");

	$dbarray = array();

	while( $row = $result->fetch_assoc()){
		$dbarray[] = $row;
	}

	echo json_encode($dbarray);

	}catch(Exception $exception){
	
	echo "Exception message: " , $exception->getMessage(), "\n";
	
	exit();

	}

$dbconnection->close();
	
?>
