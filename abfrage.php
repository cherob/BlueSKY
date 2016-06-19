<?php
    $lat = $_GET["lat"];
    $lon = $_GET["lon"];
    $mysql_host = "localhost";
    $mysql_db   = "luft";
    $mysql_user = "luft";
    $mysql_pw   = "luft1234";
    $connection = mysql_connect($mysql_host, $mysql_user, $mysql_pw) or die("Verbindung zur Datenbank fehlgeschlagen.");
    mysql_select_db($mysql_db, $connection) or die("Datenbank konnte nicht ausgewaehlt werden.");
    $sql = "SELECT wert FROM `luftmessung` where `id`=0";
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