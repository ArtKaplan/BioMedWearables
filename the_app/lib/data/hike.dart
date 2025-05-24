
class Hike {
  final String name;
  final double steps;
  final double distance;
  final String duration;
  final String url;
  final String traveltime;
  bool favourite;
  String type;

  Hike({
    required this.name,
    required this.steps, // for now: manually calculated for average, can be adapted with data from professor, 1300/km women 1500/km men
    required this.distance,
    required this.duration,
    required this.url,
    required this.traveltime,
    required this.favourite,
    required this.type,
  });
}

final List<Hike> hikelist = [
  Hike(name: "Monte Ricco e Monte Castello", steps: 4914, distance: 3.78, duration: "1h45", url: "https://www.komoot.com/smarttour/11885115", traveltime: "0h20", favourite: true, type: 'short'),// take train to Monselice
  Hike(name: "Sentiero del Monte Cecilia", steps: 7605, distance: 5.85, duration: "1h45", url: "https://www.komoot.com/smarttour/e1014732379", traveltime: "1h40", favourite: true, type: 'middle'), // take the bus to Baone
  Hike(name: "Sentiero della Villa Draghi", steps: 6617, distance: 5.09, duration: "1h40", url: "https://www.komoot.com/smarttour/e1308461374", traveltime: "0h40", favourite: false, type: 'short'), // take the train to Terme Euganee-Abano-Montegrotto and walk 2km
  Hike(name: "Sentiero del Monte Cinto", steps: 7800, distance: 6.00, duration: "1h56", url: "https://www.komoot.com/smarttour/e1014187883", traveltime: "1h30", favourite: false, type: 'middle'), // take bus to Cinto Euganeo R.
  Hike(name: "Sentiero del Monte Lozzo", steps: 10088, distance: 7.76, duration: "2h26", url: "https://www.komoot.com/smarttour/e1014176760", traveltime: "1h30", favourite: false, type: 'middle'),// take bus to Lozzo Chiesa
  Hike(name: "Abbazia di Praglia", steps: 11700, distance: 9.14, duration: "2h51", url: "https://www.komoot.com/smarttour/e1307976644", traveltime: "0h40", favourite: false, type: 'short'), // take bus to Besseo
  Hike(name: "Monte Cero", steps: 13260, distance: 10.2, duration: "3h07", url: "https://www.komoot.com/smarttour/e1258720215", traveltime: "1h00", favourite: false, type: 'middle'), //take train to Este
  Hike(name: "Cascate del Silan", steps: 13650, distance: 10.5, duration: "3h011", url: "https://www.komoot.com/smarttour/21304231", traveltime: "1h45", favourite: false, type: 'long'), // take bus/train to Bassano then walk 2 km
  Hike(name: "Monte Berico", steps: 14950, distance: 11.5, duration: "3h11", url: "https://www.komoot.com/smarttour/30430651", traveltime: "0h45", favourite: false, type: 'middle'), // take train to vicenza then walk 15 min
  Hike(name: "Lago di Corlo", steps: 17940, distance: 13.8, duration: "4h40", url: "https://www.komoot.com/tour/2115684197", traveltime: "2h00", favourite: false, type: 'long'),//take train to Cismon Del Grappa then walk 20 min
  Hike(name: "Padova canals", steps: 48980, distance: 14.6, duration: "4h25", url: "https://www.komoot.com/tour/2224142945", traveltime: "0h10", favourite: false, type: 'middle'), // walk to nearest point
  Hike(name: "Il Casoni della Fogolana", steps: 21970, distance: 16.9, duration: "4h45", url: "https://www.komoot.com/smarttour/11894189", traveltime: "1h30", favourite: false, type: 'long'),//take train to Mestre and bus to Santa Margherita, Strada Romea
];