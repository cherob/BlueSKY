<?php
    $lat = $_GET["lat1"];
	$lat2 = $_GET["lat2"];
    $lon = $_GET["lon1"];
	$lon2 = $_GET["lon2"];
    $mysql_host = "localhost";
    $mysql_db   = "luft";
    $mysql_user = "luft";
    $mysql_pw   = "luft1234";
    $connection = mysql_connect($mysql_host, $mysql_user, $mysql_pw) or die("Verbindung zur Datenbank fehlgeschlagen.");
    mysql_select_db($mysql_db, $connection) or die("Datenbank konnte nicht ausgewaehlt werden.");
    $sql = "SELECT wert FROM `luftmessung` where `lat` > ".$lat." && `lat` < ".$lat2." && `lon` > ".$lon." && `lon` < ".$lon2."";
    $result = mysql_query($sql, $connection);
    
    $row = mysql_fetch_array($result, MYSQL_NUM);
    if ($lat == 51.025051){
        if($lon == 13.730007){
            if($row[0] <= 20){
                echo "1";
            }
            if($row[0] > 20 && $row[0] <= 35){
		echo "2";
            }
            if($row[0] > 35){
                echo "3";
            }
        }
    }
?>