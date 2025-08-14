import 'package:flutter/material.dart';
import 'package:number_master/screens/how_to_play_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(title: const Text('Sound'), value: true, onChanged: (val) {}),
          SwitchListTile(title: const Text('Vibration'), value: true, onChanged: (val) {}),
          ListTile(title: const Text('Remove Ads'), trailing: const Icon(Icons.arrow_forward)),
          ListTile(title: const Text('Contact Us'), trailing: const Icon(Icons.arrow_forward)),
          ListTile(
            title: const Text('How to Play'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HowToPlayScreen())),
          ),
          const ListTile(title: Text('Terms of Service')),
          const ListTile(title: Text('Privacy Policy')),
          const ListTile(title: Text('v1.4.2')),
        ],
      ),
    );
  }
}