<?php
    header("Content-type: image/png");
    //Bild erzeugen
    $img = imagecreate(500, 500);
    //
    $color['lime'] = imagecolorallocate($img, 0x00, 0xFF, 0x00);
    //Schwarze Farbe setzen
    $color['black'] = imagecolorallocate($img, 0x00, 0x00, 0x00);
    $color['green'] = imagecolorallocate($img, 34, 139, 34);
    $color['yellow'] = imagecolorallocate($img, 238, 238, 0);
    $color['red'] = imagecolorallocate($img, 238, 64, 0);
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
	if($row[2] <= 20){
            $farbe = 'green';
        }
        if($row[2] > 20 && $row[2] <= 35){
            $farbe = 'yellow';
        }
        if($row[2] > 35){
            $farbe = 'red';
        }
        $a = 51.025904 - $row[0];
        $b = 13.723427 - $row[1];
        $latpx = $a * 10239.606799;
        $lonpx = $b * 10239.606799;
        //echo "latpx: $latpx ; lonpx: $lonpx";
	//echo "latpx: $latpx ; a: $a ; row0: ".$row[0]."<br>";
        imagestring($img, 400, 250 + $lonpx, 250 + $latpx, $row[2]." E-6 g/m^3", $color[$farbe]);
    }
    //Hintergrundfarbe entfernen (transparent)
    imagecolortransparent($img, $color['lime']);
    //PNG erzeugen
    imagepng($img);
?>