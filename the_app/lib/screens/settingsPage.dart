import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/logoutButton.dart';
import 'package:the_app/widgets/resetSettingsButton.dart';
import 'package:the_app/utils/numPicker.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(
      context,
    ); //access to Settingsprovider
    return Scaffold(
      body: Column(
        children: [
          Container(height: 150, child: Image.asset('lib/pictures/logo.png')),
          Expanded(
            child: SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground:
                    Theme.of(context).textTheme.labelLarge?.color,
                titleTextColor: Theme.of(context).textTheme.titleLarge?.color,
                settingsTileTextColor:
                    Theme.of(context).textTheme.titleLarge?.color,
                tileDescriptionTextColor:
                    Theme.of(context).textTheme.titleLarge?.color,
                leadingIconsColor:
                    Theme.of(context).textTheme.titleLarge?.color,
              ),
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
                            final textController = TextEditingController(
                              text: settings.name,
                            );
                            return AlertDialog(
                              title: const Text('Enter your name'),
                              content: TextField(
                                controller: textController,
                                decoration: const InputDecoration(
                                  hintText: 'Jane Doe',
                                ),
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
                      title: Text('Step goal'),
                      value: Text('${settings.goal}'),
                      leading: Icon(Icons.emoji_events_rounded),
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final textController = TextEditingController(
                              text: '${settings.goal}',
                            );
                            return AlertDialog(
                              title: const Text('Enter your goal'),
                              content: TextField(
                                // https://medium.com/@gabrieloranekwu/number-input-on-flutter-textfields-the-right-way-06441f7b5550
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: textController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '10000',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final int newGoal = int.parse(
                                      textController.text,
                                    );
                                    settings.setGoal(newGoal);
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
                      activeSwitchColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ],
                ),

                /*+++++++++++++++++++++++++++++++++++++++++
                ++++++++++++++ NOTIFICATIONS ++++++++++++++ 
                +++++++++++++++++++++++++++++++++++++++++++*/
                SettingsSection(
                  title: Text('Notification'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      title: Text('Push-Notifcation'),
                      leading: Icon(Icons.notification_add),
                      initialValue: settings.pushNotifications,
                      onToggle: (value) => settings.setPushNotifications(value),
                      activeSwitchColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    SettingsTile(
                      title: Text('Time Push-Notifications'),
                      value: Text('Choose Notification Time'),
                      leading: Icon(Icons.notifications_active),
                      enabled: settings.pushNotifications,
                      onPressed: (context) {},
                    ),
                  ],
                ),

                /*+++++++++++++++++++++++++++++++++++++++++
                  ++++++++++++++ PERSONAL INFO ++++++++++++++ 
                  +++++++++++++++++++++++++++++++++++++++++++*/
                SettingsSection(
                  title: Text('Personal Information'),
                  tiles: <SettingsTile>[
                    SettingsTile(
                      title: Text('Sex'),
                      value:
                          settings.sex != null && settings.sex != 'ERROR'
                              ? Text('${settings.sex}')
                              : Text('Choose your sex'),
                      leading: Icon(Icons.person),
                      trailing: DropdownButton(
                        value: settings.sex,
                        items:
                            ['male', 'female', 'diverse'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) => settings.setSex(newValue),
                      ),
                    ),
                    SettingsTile(
                      title: Text('Birthday'),
                      value:
                          settings.birthday != null &&
                                  settings.birthday.toString() !=
                                      '0000-00-00T00:00:00.000'
                              ? Text(
                                '${settings.birthday?.day}.${settings.birthday?.month}.${settings.birthday?.year}',
                              )
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
                    SettingsTile(
                      title: Text('Age'),
                      value:
                          settings.age != null && settings.age != -1
                              ? Text('${settings.age}')
                              : Text(
                                'Select your birthday to calculate your age',
                              ),
                      leading: Icon(Icons.person),
                    ),
                    SettingsTile(
                      title: Text('Height'),
                      value:
                          settings.height != null && settings.height != -1
                              ? Text('${settings.height} cm')
                              : Text('Choose your height'),
                      leading: Icon(Icons.height),
                      trailing: Icon(Icons.arrow_drop_down),
                      onPressed: (context) {
                        int wholeNumber = settings.height ?? 175;
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,

                          builder: (context) {
                            return SafeArea(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NumberPicker(
                                            minValue: 30,
                                            maxValue: 240,
                                            value: wholeNumber,
                                            onChanged:
                                                (value) => setState(
                                                  () => wholeNumber = value,
                                                ),
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
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SettingsTile(
                      title: Text('Weight'),
                      value:
                          settings.weight != null && settings.weight != -1.0
                              ? Text('${settings.weight} kg')
                              : Text('Choose your weight'),
                      leading: Icon(Icons.monitor_weight),
                      trailing: Icon(Icons.arrow_drop_down),
                      onPressed: (context) {
                        double weight = settings.weight ?? 75.6;
                        int wholeNumber = weight.floor();
                        int decimal = ((weight - wholeNumber) * 10).floor();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return SafeArea(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NumberPicker(
                                            minValue: 30,
                                            maxValue: 200,
                                            value: wholeNumber,
                                            onChanged:
                                                (value) => setState(
                                                  () => wholeNumber = value,
                                                ),
                                          ),
                                          const Text('.'),
                                          NumberPicker(
                                            minValue: 0,
                                            maxValue: 9,
                                            value: decimal,
                                            onChanged:
                                                (value) => setState(
                                                  () => decimal = value,
                                                ),
                                          ),
                                          const Text(' kg'),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          final double newWeight =
                                              wholeNumber + decimal / 10;
                                          settings.setWeight(newWeight);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),

                /*+++++++++++++++++++++++++++++++++++++++++
                +++++++++++++++ Step Length +++++++++++++++
                +++++++++++++++++++++++++++++++++++++++++++*/
                SettingsSection(
                  title: Text('Step Length'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      title: Text('Personalize Step Length'),
                      leading: Icon(Icons.width_wide),
                      initialValue: settings.stepLengthPersonalized,
                      onToggle:
                          (value) => settings.setStepLengthPersonalized(value),
                      activeSwitchColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    SettingsTile(
                      title: Text('Auto Step Length'),
                      value:
                          settings.height != null && settings.height != -1
                              ? Text(
                                'Approx. step length based on your height: ${settings.stepLength} cm',
                              )
                              : Text(
                                'Select your heigth to calculate your approx. step length',
                              ),
                      leading: Icon(Icons.width_wide),
                      enabled: !settings.stepLengthPersonalized,
                    ),
                    SettingsTile(
                      title: Text('Select Step Length'),
                      value:
                          settings.stepLength != null &&
                                  settings.stepLengthPersonalized &&
                                  settings.stepLength != -1
                              ? Text('${settings.stepLength} cm')
                              : Text('Choose your Step Length'),
                      leading: Icon(Icons.width_wide),
                      trailing: Icon(Icons.arrow_drop_down),
                      enabled: settings.stepLengthPersonalized,
                      onPressed: (context) async {
                        final newStepLength = await showNumberPickerDialog(
                          context: context,
                          initialValue: settings.stepLength ?? 72,
                          minValue: 40,
                          maxValue: 110,
                          unit: 'cm',
                        );

                        if (newStepLength != null) {
                          settings.setStepLength(newValue: newStepLength);
                        }
                      },
                    ),
                  ],
                ),

                /*+++++++++++++++++++++++++++++++++++++++++
                +++++++++++++++ HEART RATE ++++++++++++++++
                +++++++++++++++++++++++++++++++++++++++++++*/
                SettingsSection(
                  title: Text('Heart Rate'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      title: Text('Personalize Max Heart Rate'),
                      leading: Icon(Icons.monitor_heart),
                      initialValue: settings.maxHeartRatePersonalized,
                      onToggle:
                          (value) =>
                              settings.setMaxHeartRatePersonalized(value),
                      activeSwitchColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    SettingsTile(
                      title: Text('Auto Max Heart Rate'),
                      value:
                          settings.maxHeartRate != null &&
                                  !settings.maxHeartRatePersonalized &&
                                  settings.maxHeartRate != -1
                              ? Text('${settings.maxHeartRate} bpm')
                              : Text(
                                'Select your birthday to calculate your approx. max. heart rate',
                              ),
                      leading: Icon(Icons.monitor_heart),
                      enabled: !settings.maxHeartRatePersonalized,
                    ),
                    SettingsTile(
                      title: Text('Select Max Heart Rate'),
                      value:
                          settings.maxHeartRate != null &&
                                  settings.maxHeartRatePersonalized &&
                                  settings.maxHeartRate != -1
                              ? Text('${settings.maxHeartRate} bpm')
                              : Text('Choose your Max Heart Rate'),
                      leading: Icon(Icons.monitor_heart),
                      trailing: Icon(Icons.arrow_drop_down),
                      enabled: settings.maxHeartRatePersonalized,
                      onPressed: (context) async {
                        final newMHR = await showNumberPickerDialog(
                          context: context,
                          initialValue:
                              settings.maxHeartRate ?? 191, //default value
                          minValue: 130,
                          maxValue: 240,
                          unit: 'bpm',
                        );

                        if (newMHR != null) {
                          settings.setMaxHeartRate(
                            newValue: newMHR,
                          ); // Provider-Update
                        }
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('Reset'),
                  tiles: <SettingsTile>[
                    SettingsTile(
                      title: Text('Reset Settings'),
                      leading: Icon(Icons.delete),
                      trailing: ResetSettingsButton(),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('Logout'),
                  tiles: <SettingsTile>[
                    SettingsTile(
                      title: Text('Logout'),
                      leading: Icon(Icons.logout),
                      trailing: LogoutButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigBar(currentPage: CurrentPage.settings),
    );
  }
}

//SettingPage
