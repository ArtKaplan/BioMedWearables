import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/HikeDescrPage.dart';
import 'package:the_app/data/hike.dart';

class Thishikepage extends StatefulWidget {
  final Hike hike;
  const Thishikepage({super.key, required this.hike});
  @override
  State<Thishikepage> createState() => _Thishikepage();
}

class _Thishikepage extends State<Thishikepage>{
  @override
  Widget build(BuildContext context) {
    Icon getIcon(Hike widget){
      if(widget.favourite == true){
          return Icon(Icons.favorite);
      } else {
        return Icon(Icons.favorite_border);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hike.name),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: getIcon(widget.hike),
            color: Theme.of(context).textTheme.titleLarge?.color,
            onPressed: () => {
              setState(() {
              widget.hike.favourite = !widget.hike.favourite;
              })
            },
          ),
        ],
      ),
      body: Hikedescrpage(hike: widget.hike),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.hikes)
    );
  } //build
} //SettingPage