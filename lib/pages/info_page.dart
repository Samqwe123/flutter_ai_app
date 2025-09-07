import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfoPage extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  const InfoPage({
    super.key,
    required this.controller,
    required this.controller2,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Map<String, dynamic>? achievementsData;
  Map<String, dynamic>? schemaData;

  @override
  void initState() {
    super.initState();
    fetchUserStats(
      widget.controller2.text, // User ID
      widget.controller.text, // Game ID
      'put your api key here', // API Key
    );
  }

  Future<void> fetchUserStats(
    String steamId,
    String appId,
    String apiKey,
  ) async {
    final url =
        'https://steamuserstatsproxy-344rv4vqga-uc.a.run.app?appid=$appId&apikey=$apiKey&steamid=$steamId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        achievementsData = data['achievements'];
        schemaData = data['schema'];
      });
      print(jsonEncode(data)); // Pretty print the JSON
    } else {
      setState(() {
        achievementsData = {'error': 'Failed to fetch user stats'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievements = achievementsData?['playerstats']?['achievements'] ?? [];
    final schemaAchievements = schemaData?['game']?['availableGameStats']?['achievements'] ?? [];

    if (achievementsData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Game Info')),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text('User ID: ${widget.controller2.text}'),
                SizedBox(height: 10),
                Text('Game ID: ${widget.controller.text}'),
                Text('Game name: ${achievementsData?['playerstats']?['gameName'] ?? 'N/A'}'),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: achievements.isEmpty
                ? Center(child: Text('No achievements found.'))
                : ListView.builder(
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = achievements[index];
                      final isAchieved = achievement['achieved'] == 1;

                      // Find matching schema achievement for image
                      final schemaAchievement = schemaAchievements.firstWhere(
                        (schema) => schema['name'] == achievement['apiname'],
                        orElse: () => null,
                      );
                      final iconUrl = schemaAchievement != null
                          ? (isAchieved ? schemaAchievement['icon'] : schemaAchievement['icongray'])
                          : null;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 16,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isAchieved ? Colors.green[50] : Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isAchieved ? Colors.green : Colors.red,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (iconUrl != null)
                              Image.network(
                                'https://us-central1-flutter-e-com-39f60.cloudfunctions.net/steamImageProxy?url=${Uri.encodeComponent(iconUrl)}',
                                height: 50,
                                width: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, size: 50);
                                },
                              ),
                              SizedBox(height: 4),
                            Text(
                              achievement['name'] ??
                                  achievement['apiname'] ??
                                  'Unknown',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              achievement['description'] ?? '',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              isAchieved ? 'Unlocked' : 'Locked',
                              style: TextStyle(
                                color: isAchieved ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
