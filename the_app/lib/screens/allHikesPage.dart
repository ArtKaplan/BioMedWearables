import 'package:flutter/material.dart';
import 'package:the_app/data/hike.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/screens/thisHikePage.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:provider/provider.dart';




class Allhikespage extends StatefulWidget {
  const Allhikespage({super.key});

  @override
  State<Allhikespage> createState() => _AllhikespageState();
}

class _AllhikespageState extends State<Allhikespage>{

  final List<String> categories = [
    'short',
    'middle', 
    'long',
  ];

  final Map<String, String> categoryLabels = {
  'short': '< 4 hours',
  'middle': '4–6 hours',
  'long': '> 6 hours',
  };

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final filterHikes = hikelist.where((hike){
      return selectedCategories.isEmpty || selectedCategories.contains(hike.type);
    }).toList();
    Icon getIcon(Hike hike){
      if(hike.favourite == true){
          return Icon(Icons.favorite);
      } else {
        return Icon(Icons.favorite_border);
      }
    }
    double stepLength = Provider.of<SettingsProvider>(context).stepLength! / 100;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
              child: Column( children: [Text('How much time do you have?', style: TextStyle(fontSize: 25, color: Color(0xFF66101F))), Text('Travel time included', style: TextStyle(fontSize: 20, color: Color(0xFF66101F), fontStyle: FontStyle.italic))])
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: categories
                .map((category)=>FilterChip(
                  label: Text(categoryLabels[category]!), 
                  selected: selectedCategories.contains(category),
                  backgroundColor: Color(0xFF66101F),
                  selectedColor: Color(0xFF66101F),
                  checkmarkColor: Color(0xFFFFF1D7),
                  labelStyle: TextStyle(color: Color(0xFFFFF1D7)),
                  onSelected: (selected) {
                    setState((){
                      if (selected){
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  }),
                )
                .toList(),
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: filterHikes.length,
              itemBuilder: (context,index){
                final hike = filterHikes[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFFDE7C5A)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text(hike.name, style: const TextStyle(color: Color(0xFFFFF1D7), fontWeight: FontWeight.bold),),
                      subtitle:Text('Distance: '+hike.distance.toString()+' km, Duration: '+hike.duration + ', Steps: ${hike.distance * 1000 ~/ stepLength}'+'\nTravel time from Padova station: '+hike.traveltime, style: const TextStyle(color: Color(0xFFFFF1D7), fontStyle: FontStyle.italic),),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Thishikepage(hike: hike)),
                          ).then((result){setState((){});});
                      },
                      trailing: IconButton(
                        icon: getIcon(hike),
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        onPressed: () => {
                          setState(() {
                            hike.favourite = !hike.favourite;
                          })
                        },
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        )
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.hikes)
    );
  } //build
} //SettingPage


