
//Libary
#include <SPI.h>
#include <Ethernet.h>

//Data
int data_amount = 10;
int data_id = 1;
int data_zeit_h;
int data_zeit_m;
int data_zeit_s;
int data_datum_y;
int data_datum_m;
int data_datum_d;
double data_lat;
double data_lon;

int data_wert;

//CONFIG
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
char server[] = "192.168.137.205";
IPAddress ip(192, 168, 137, 3);
EthernetClient client;

//SETUP
void setup() {
  Serial.begin(9600);

  Serial.println("Wait for Serial");
  while (!Serial) {
    ;
  }
}

//LOOP
void loop() {
  getTime();
 // connectClient();
 // sendData();
}


//FUNCTIONS
int connectClient(void) {
  if (Ethernet.begin(mac) == 0) {
    Serial.println("Failed to configure Ethernet using DHCP");
    Ethernet.begin(mac, ip);
  } else {
    Serial.println("Configure Ethernet using DHCP");
  }
  if (data_id >= data_amount + 1) {
    Serial.println("Finish");
    while (true);
  }
}
int getTime(){
    Serial.print(hour());
    Serial.print(":");
    Serial.print(minute());
    Serial.print(":");
    Serial.print(second());
    Serial.print("  ");
    Serial.print(day());
    Serial.print("-");
    Serial.print(month());
    Serial.print("-");
    Serial.println(year());
}
int sendData(void) {
  Serial.println("Connect to Client Sever");
  if (client.connect(server, 80)) {
    data_lat = (double) random(51005904, 51045904) / 1000000;
    data_lon = (double) random(13700427, 13747427) / 1000000;
    data_wert = random(0, 50);

    Serial.print("DATA-ID: ");
    Serial.println(data_id);
    Serial.print("DATA-LAT: ");
    Serial.println(data_lat, 6);
    Serial.print("DATA-LON: ");
    Serial.println(data_lon, 6);
    Serial.print("DATA-WERT: ");
    Serial.println(data_wert);

    client.print("GET /daten_schreiben.php?");
    client.print("id=");
    client.print(data_id);
    client.print("&zeit=11:42:42&datum=2016-06-19&lat=");
    client.print(data_lat, 6);
    client.print("&lon=");
    client.print(data_lon, 6);
    client.print("&wert=");
    client.print(data_wert);
    client.println(" HTTP/1.1");
    client.print("Host: ");
    client.println(server);
    client.println("Connection: close");
    client.println();

    delay(100);
    Serial.println("Disconnecting...");
    client.stop();
    data_id++;
  } else {
    Serial.println("Connection failed!");
  }
}

