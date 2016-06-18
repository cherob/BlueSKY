<?php
    //Bild erzeugen
    $img = imagecreate(500, 500);
    //
    $color['lime'] = imagecolorallocate($img, 0x00, 0xFF, 0x00);
    //Schwarze Farbe setzen
    $color['black'] = imagecolorallocate($img, 0x00, 0x00, 0x00);
    //Text schreiben
    $mysql_host = "localhost";
    $mysql_db   = "luft";
    $mysql_user = "luft";
    $mysql_pw   = "luft1234";
    $connection = mysql_connect($mysql_host, $mysql_user, $mysql_pw) or die("Verbindung zur Datenbank fehlgeschlagen.");
    mysql_select_db($mysql_db, $connection) or die("Datenbank konnte nicht ausgewaehlt werden.");
    $sql = "SELECT lat, lon, wert FROM `luftmessung`";
    $result = mysql_query($sql, $connection);
    while (($row = mysql_fetch_array($result, MYSQL_NUM))!== FALSE){
	$a = 51.025904 - $row[0];
        $b = 13.723427 - $row[1];
        $latpx = $a * 10239.606799;
        $lonpx = $b * 10239.606799;
        //echo "latpx: $latpx ; lonpx: $lonpx";
	//echo "latpx: $latpx ; a: $a ; row0: ".$row[0]."<br>";
        imagestring($img, 400, 250 + $lonpx, 250 + $latpx, $row[2], $color['black']);
    }
    //Hintergrundfarbe entfernen (transparent)
    imagecolortransparent($img, $color['lime']);
    //PNG erzeugen
    header("Content-type: image/png");
    imagepng($img);
?>