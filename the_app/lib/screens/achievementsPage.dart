import 'package:flutter/material.dart';
import 'package:the_app/provider/award_provider.dart';
import 'package:the_app/utils/awards.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:provider/provider.dart';



class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final awardProvider = Provider.of<AwardProvider>(context, listen: false);

    //load awards on first loading of page
    /*WidgetsBinding.instance.addPostFrameCallback((_){
      awardProvider.initAwardList();
    });*/

    return Scaffold(
      
      body: FutureBuilder<void>(
        future: awardProvider.init(), //awardProvider.initAwardList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Fehler: ${snapshot.error}"));
          }

          //final unlocked = awardProvider.unlockedAwards;
          //final locked = awardProvider.lockedAwards;

          return SingleChildScrollView(
          
        //body: SingleChildScrollView(
          
        child: Column(
        children: [    
          Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Keep it up!',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),   
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(children: [
                Text("20", style: TextStyle(fontSize: 80)), // this 20 needs to be a streak amount
                Text("weeks of walking", style: TextStyle(fontSize: 20)),
              ],),
              Icon(Icons.local_fire_department, color: Colors.orange, size: 150.0,),
            ],),
          Container(
            padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
            child: Text(
              'Your awards:',
              style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),   
          Consumer<AwardProvider>(
            builder: (context, provider, _) {
              /*
              if (provider.awards.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              */
              return _buildAwardsList(provider.unlockedAwards);
          },
        ),

        //_buildAwardsList(unlocked),
        Container(
            padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
            child: Text(
              'Locked awards:',
              style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),   
        Consumer<AwardProvider>(
          builder: (context, provider, _) {
            /*
            if (provider.awards.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            */
            return _buildAwardsList(provider.lockedAwards);
          },
        ),
        //_buildAwardsList(locked),
        /*Container(
            padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
            child: Text(
              'All available awards:',
              style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),   
          Consumer<AwardProvider>(
            builder: (context, provider, _) {
              if (provider.awards.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return _buildAwardsList(awardProvider.awards);
          },
        ),*/
      ],
      ),
      );
      },
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.achievements),
    );
  } //build

  Widget _buildAwardsList(List<Award> awards) {
    print(awards);
    return SizedBox(
      height: 270,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: awards.isNotEmpty
          ? awards.length
          : 1,
        itemBuilder: awards.isEmpty
          ? (context, index){
            try{
            return Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset(
                    'lib/pictures/awards/noAwards.png',
                    width: 150,
                    height: 150,
                ),
                Text('No awards unlocked (YET)!', 
                  textAlign: TextAlign.center),
                ],
              ),
            );
          } catch (e) {
            print('Error rendering award $index: $e');
            return ErrorWidget(e);
          }
          }
          : (context, index) {
            try {
              final award = awards[index];
              return Container(
                width: 200,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40, //2 lines
                      child: Text(award.title, 
                        maxLines: 2, 
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center),
                    ),
                    Image.asset(
                        award.imagePath,
                        width: 150,
                        height: 150,
                        color: award.isUnlocked ? null : Colors.grey.withOpacity(0.9),
                        colorBlendMode: BlendMode.saturation,
                    ),
                    SizedBox(
                      height: 80, //4 lines
                      child: Text(award.condition, 
                        maxLines: 4, 
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center),
                    )
                  ],
                ),
              );
            } catch (e) {
              print('Error rendering award $index: $e');
              return ErrorWidget(e);
            }
          },
        ),
      );
  }
}
