class Hike {
  final String name;
  final double steps;
  final double distance;
  final String duration;
  final String url;
  final String traveltime;

  Hike({
    required this.name,
    required this.steps, // for now: manually calculated for average, can be adapted with data from professor
    required this.distance,
    required this.duration,
    required this.url,
    required this.traveltime,
  });
}

final List<Hike> hikelist = [
  Hike(name: "Sentiero del Monte Cecilia", steps: 7605, distance: 5.85, duration: "1h45", url: "https://www.komoot.com/smarttour/e1014732379", traveltime: "TBD"),
  Hike(name: "Sentiero della Villa Draghi", steps: 6617, distance: 5.09, duration: "1h40", url: "https://www.komoot.com/smarttour/e1308461374", traveltime: "TBD"),
  Hike(name: "Sentiero del Monte Cinto", steps: 7800, distance: 6.00, duration: "1h56", url: "https://www.komoot.com/smarttour/e1014187883", traveltime: "TBD"),
  Hike(name: "Sentiero del Monte Lozzo", steps: 10088, distance: 7.76, duration: "2h26", url: "https://www.komoot.com/smarttour/e1014176760", traveltime: "TBD"),
  Hike(name: "Abbazia di Praglia", steps: 11700, distance: 9.14, duration: "2h51", url: "https://www.komoot.com/smarttour/e1307976644", traveltime: "TBD"),
  Hike(name: "Monte Cero", steps: 13260, distance: 10.2, duration: "3h07", url: "https://www.komoot.com/smarttour/e1307976644", traveltime: "TBD"),
  Hike(name: "Cascate del Silan", steps: 13650, distance: 10.5, duration: "3h011", url: "https://www.komoot.com/smarttour/21304231", traveltime: "TBD"),
  Hike(name: "Monte Berico", steps: 14950, distance: 11.5, duration: "3h11", url: "https://www.komoot.com/smarttour/30430651", traveltime: "TBD"),
  Hike(name: "Padova canals", steps: 48980, distance: 14.6, duration: "4h25", url: "https://www.komoot.com/tour/2224142945", traveltime: "TBD"),
  Hike(name: "Il Casoni della Fogolana", steps: 21970, distance: 16.9, duration: "4h45", url: "https://www.komoot.com/smarttour/e1307976644", traveltime: "TBD"),
  
];