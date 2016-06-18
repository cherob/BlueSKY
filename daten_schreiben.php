<?php
$mysql_host = "localhost";
$mysql_db   = "luft";
$mysql_user = "luft";
$mysql_pw   = "luft1234";
$id = $_GET["id"];
$zeit = $_GET["zeit"];
$datum = $_GET["datum"];
$lat = $_GET["lat"];
$lon = $_GET["lon"];
$wert = $_GET["wert"];

 
$connection = mysql_connect($mysql_host, $mysql_user, $mysql_pw) or die("Verbindung zur Datenbank fehlgeschlagen.");
mysql_select_db($mysql_db, $connection) or die("Datenbank konnte nicht ausgewaehlt werden.");
$insert_data = "INSERT INTO luftmessung (id, zeit, datum, lat, lon, wert) VALUES ('".$id."', '".$zeit."', '".$datum."', '".$lat."', '".$lon."', '".$wert."')";
mysql_query($insert_data, $connection) or die("Fehler beim Eintragen der Daten in die Datenbank!");
?>