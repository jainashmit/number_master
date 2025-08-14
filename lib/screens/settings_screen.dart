// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:number_master/screens/how_to_play_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(
              top: 50, bottom: 16, left: 16.0, right: 16.0),
          children: [
            Card(
              color: Colors.purple[800],
              child: SwitchListTile(
                title:
                    const Text('Sound', style: TextStyle(color: Colors.white)),
                value: true,
                onChanged: (val) {},
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: SwitchListTile(
                title: const Text('Vibration',
                    style: TextStyle(color: Colors.white)),
                value: true,
                onChanged: (val) {},
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: ListTile(
                title: const Text('Remove Ads',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: ListTile(
                title: const Text('Contact Us',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: ListTile(
                title: const Text('How to Play',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HowToPlayScreen())),
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: const ListTile(
                title: Text('Terms of Service',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: const ListTile(
                title: Text('Privacy Policy',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Card(
              color: Colors.purple[800],
              child: const ListTile(
                title: Text('v1.4.2', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
