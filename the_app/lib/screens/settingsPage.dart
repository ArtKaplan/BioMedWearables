import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/logoutButton.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);//access to Settingsprovider
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), actions: [
          IconButton(
            icon: Image.asset('lib/pictures/logo simple.png'),
            onPressed: (){Navigator.pop(context);},
          ),
        ],),
      body: 
        SettingsList(
          sections: [

            /*+++++++++++++++++++++++++++++++++++++++++
            +++++++++++++++++ GENERAL +++++++++++++++++ 
            +++++++++++++++++++++++++++++++++++++++++++*/
            SettingsSection(
              title: Text('General'),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: Text('Name'),
                  value: Text(settings.name),
                  leading: Icon(Icons.person),
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final textController = TextEditingController(text: settings.name);
                        return AlertDialog(
                          title: const Text('Enter your name'),
                          content: TextField(
                            controller: textController,
                            decoration: const InputDecoration(hintText: 'Jane Doe'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final newName = textController.text;
                                settings.setName(newName);
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SettingsTile(
                  title: Text('Language'),
                  value: Text('English'),
                  leading: const Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Dark Mode'),
                  leading: Icon(Icons.dark_mode),
                  onToggle: (value) => settings.setDarkMode(value),
                  initialValue: settings.darkMode,
                ),
              ],
            ),

            /*+++++++++++++++++++++++++++++++++++++++++
            ++++++++++++++ NOTIFICATIONS ++++++++++++++ 
            +++++++++++++++++++++++++++++++++++++++++++*/
            SettingsSection(title: Text('Notification'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(title: Text('Push-Notifcation'),
                  leading: Icon(Icons.notification_add),
                  initialValue: settings.pushNotifications,
                  onToggle: (value) => settings.setPushNotifications(value),
                ),
                SettingsTile(title: Text('Time Push-Notifications'),
                  value: Text('Choose Notification Time'),
                  leading: Icon(Icons.notifications_active),
                  enabled: settings.pushNotifications,
                  onPressed: (context) {},
                ),
              ]),

              /*+++++++++++++++++++++++++++++++++++++++++
              ++++++++++++++ PERSONAL INFO ++++++++++++++ 
              +++++++++++++++++++++++++++++++++++++++++++*/
            SettingsSection(title: Text('Personal Information'),
            tiles: <SettingsTile>[
              SettingsTile(title: Text('Sex'),
                value: settings.sex != null
                  ? Text('${settings.sex}')
                  : Text('Choose your sex'),
                leading: Icon(Icons.person),
                trailing: DropdownButton(
                  value: settings.sex,
                  items: ['male', 'female', 'divers'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  onChanged: (newValue) => settings.setSex(newValue),
                  ),
              ),
              SettingsTile(title: Text('Birthday'),
                value: settings.birthday != null
                  ? Text('${settings.birthday?.day}.${settings.birthday?.month}.${settings.birthday?.year}')
                  : Text('Choose birthday'),
                leading: Icon(Icons.cake),
                trailing: Icon(Icons.arrow_drop_down),
                onPressed: (context) async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    settings.setBirthday(pickedDate);
                  }
                },
              ),
              SettingsTile(title: Text('Age'),
                value: settings.age != null
                  ? Text('${settings.age}')
                  : Text('Select your birthday to calculate your age'),
                leading: Icon(Icons.person),
              ),
              SettingsTile(title: Text('Height'),
                value: settings.heigth != null 
                  ? Text('${settings.heigth} cm') 
                  : Text('Choose your height') ,
                leading: Icon(Icons.height),
                trailing: Icon(Icons.arrow_drop_down),
                onPressed: (context) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          int wholeNumber = 175; 
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberPicker(
                                    minValue: 30,
                                    maxValue: 240,
                                    value: wholeNumber,
                                    onChanged: (value) => setState(() => wholeNumber = value),
                                  ),
                                  const Text(' cm'),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final int newHeight = wholeNumber;
                                  settings.setHeight(newHeight);
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                          ),],
                        );
                      },
                    );
                  },
                );
                },
              ),
              SettingsTile(title: Text('Weight'),
                value: settings.weight != null
                  ? Text('${settings.weight} kg')
                  : Text('Choose your weight'),
                leading: Icon(Icons.monitor_weight),
                trailing: Icon(Icons.arrow_drop_down),
                onPressed: (context) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          int wholeNumber = 75; 
                          int decimal = 6;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberPicker(
                                    minValue: 30,
                                    maxValue: 200,
                                    value: wholeNumber,
                                    onChanged: (value) => setState(() => wholeNumber = value),
                                  ),
                                  const Text('.'),
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 9,
                                    value: decimal,
                                    onChanged: (value) => setState(() => decimal = value),
                                  ),
                                  const Text(' kg'),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final double newWeight = wholeNumber + decimal/10;
                                  settings.setWeight(newWeight);
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                          ),],
                        );
                      },
                    );
                  },
                );
                },
              ),
              SettingsTile(title: Text('Step Length'),
                value: settings.stepLength != null
                  ? Text('${settings.stepLength} cm')
                  : Text('Select your heigth to calculate your approx. step length'),
                leading: Icon(Icons.width_wide),
                /*trailing: Text('${settings.stepLength} cm'),
                onPressed: (BuildContext context) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          int wholeNumber = 175; 
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberPicker(
                                    minValue: 30,
                                    maxValue: 150,
                                    value: wholeNumber,
                                    onChanged: (value) => setState(() => wholeNumber = value),
                                  ),
                                  const Text(' cm'),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final int newStepLength = wholeNumber;
                                  settings.setStepLength(newStepLength);
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                          ),],
                        );
                      },
                    );
                  },
                );
                },*/
              ),
              SettingsTile(title: Text('Resting Heart Rate'),
                  value: settings.restingHeartRate != null
                    ? Text('${settings.restingHeartRate} bpm')
                    : Text('Select your birthday to calculate your approx. resting heart rate'),
                  leading: Icon(Icons.monitor_heart),
                )
            ]),
          SettingsSection(title: Text('Logout'),
            tiles: <SettingsTile>[
              SettingsTile(title: Text('Logout'),
                leading: Icon(Icons.logout),
                trailing: LogoutButton(),
              )
          ],
        ),
      ],),

        //LogoutButton(), // TODO: change design or integrate elsewhere

      
      bottomNavigationBar: BottomNavigBar(),
    );
  } //build
} //SettingPage
