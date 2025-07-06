class Hike {
  final String name;
  final double distance;
  final String duration;
  final String url;
  final String traveltime;
  bool favourite;
  String type;
  String route;
  String maps;
  List<Duration> times;
  List difficulties;

  Hike({
    required this.name,
    required this.distance,
    required this.duration,
    required this.url,
    required this.traveltime,
    required this.favourite,
    required this.type,
    required this.route,
    required this.maps,
    required this.times,
    required this.difficulties,
  });
}

final List<Hike> hikelist = [
  Hike(name: "Monte Ricco e Monte Castello", distance: 8.78, duration: "2h45", url: "https://www.komoot.com/smarttour/11885115", traveltime: "0h20", favourite: true, type: "short", route: "Take the train to Monselice (20 minutes) and walk 30 minutes", maps:"https://maps.app.goo.gl/RGjsshChSjqknqPPA", times: [], difficulties:[]),
  Hike(name: "Sentiero del Monte Cecilia", distance: 5.85, duration: "1h45", url: "https://www.komoot.com/smarttour/e1014732379", traveltime: "1h10", favourite: true, type: "middle", route: "Take bus E006 to stop Baone (1h10)", maps: "https://maps.app.goo.gl/DSwgpR2LxQpqR1gWA", times: [], difficulties:[]),
  Hike(name: "Sentiero della Villa Draghi", distance: 9.09, duration: "2h40", url: "https://www.komoot.com/smarttour/e1308461374", traveltime: "0h10", favourite: false, type: "short", route: "Take the train to Terme Euganee-Abano-Montegrotto (8 minutes) and walk 30 minutes", maps: "https://maps.app.goo.gl/cX324wmc5G1Ar92C9", times: [], difficulties:[]), // duration includes walk from station to starting point
  Hike(name: "Sentiero del Monte Cinto", distance: 6.00, duration: "1h55", url: "https://www.komoot.com/smarttour/e1014187883", traveltime: "1h10", favourite: false, type: "middle", route: "Take bus E018 to stop Museo Cava Bomba", maps: "https://maps.app.goo.gl/JTVBovhJPcN6LPoW9", times: [], difficulties:[]),
  Hike(name: "Sentiero del Monte Lozzo", distance: 7.76, duration: "2h25", url: "https://www.komoot.com/smarttour/e1014176760", traveltime: "1h10", favourite: false, type: "middle", route: "Take bus E018 to stop Lozzo Atestino", maps: "https://maps.app.goo.gl/ofpvydaBDUaaTkks8", times: [], difficulties:[]),
  Hike(name: "Abbazia di Praglia", distance: 9.14, duration: "2h50", url: "https://www.komoot.com/smarttour/e1307976644", traveltime: "0h40", favourite: false, type: "short", route: "Take bus E017 or E018 to stop Bresseo", maps:"https://maps.app.goo.gl/GwLFsLCQTLSidozP8", times: [], difficulties:[]),
  Hike(name: "Monte Cero", distance: 10.2, duration: "3h10", url: "https://www.komoot.com/smarttour/e1258720215", traveltime: "1h00", favourite: false, type: "middle", route: "Take bus E013-V to stop Este", maps: "https://maps.app.goo.gl/vAWroq6WDW3QJLJZ6", times: [], difficulties:[]), 
  Hike(name: "Cascate del Silan", distance: 14.9, duration: "4h20", url: "https://www.komoot.com/smarttour/21304231", traveltime: "1h15", favourite: false, type: "long", route: "Take the bus or train to Bassano Del Grappa and walk 40 minutes", maps: "https://maps.app.goo.gl/fTJTALgvYAU4Wq3k8", times: [], difficulties:[]),
  Hike(name: "Monte Berico", distance: 13.9, duration: "3h50", url: "https://www.komoot.com/smarttour/30430651", traveltime: "0h15", favourite: false, type: "middle", route: "Take the train to Vicenza and walk 20 minutes", maps: "https://maps.app.goo.gl/TUzrWuxHSY6T8c619", times: [], difficulties:[]),
  Hike(name: "Lago di Corlo", distance: 15.8, duration: "5h10", url: "https://www.komoot.com/tour/2115684197", traveltime: "1h35", favourite: false, type: "long", route: "Take the train to Cismon Del Grappa and walk 15 minutes", maps: "https://maps.app.goo.gl/74ELyvV8ncFCi5aWA", times: [], difficulties:[]),
  Hike(name: "Padova canals", distance: 14.6, duration: "4h45", url: "https://www.komoot.com/tour/2224142945", traveltime: "0h10", favourite: false, type: "middle", route: "Walk to the nearest point from your home or walk 10 minutes from Padova Station", maps: "https://maps.app.goo.gl/wgy9PQwA17FU7wVv5", times: [], difficulties:[]),
  Hike(name: "Il Casoni della Fogolana", distance: 16.9, duration: "4h15", url: "https://www.komoot.com/smarttour/11894189", traveltime: "0h50", favourite: false, type: "long", route: "Take the train to Venezia Mestre and take the bus 80 (Arriva Veneto) to stop Santa Margherita, Strada Romea", maps:"https://maps.app.goo.gl/ckVnfArFeLKm7tUW8", times: [], difficulties:[]),
];

List<String> hike_names(){
  List<String> list_of_names = [];
  for(var k = 1; k<hikelist.length; k++){
    list_of_names.add(hikelist[k].name);
  }
  print(list_of_names);
  return list_of_names;
}