import 'package:flutter/material.dart';
import '../theme/styles.dart';
import '../widgets/ui_kit.dart';
import 'notification_screen.dart'; // <--- IMPORT YOUR NEW FILE HERE

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showPosts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: const Center(child: Text("Settings", style: TextStyle(color: Colors.white))),
        actions: [
          // --- NEW NOTIFICATION BUTTON START ---
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          // --- NEW NOTIFICATION BUTTON END ---

          const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16, left: 8),
                child: Text("Logout", style: TextStyle(color: Colors.white)),
              )
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(height: 80, color: AppColors.primary),
              Positioned(
                bottom: -60,
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const NetworkImage("https://i.pravatar.cc/300"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

          Text("Victoria Robertson", style: AppText.header1),
          const SizedBox(height: 8),
          Text("A mantra goes here", style: AppText.body.copyWith(fontWeight: FontWeight.bold)),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ToggleSwitch(
              isLeftActive: showPosts,
              onToggle: (val) => setState(() => showPosts = val),
            ),
          ),

          Expanded(
            child: showPosts ? _buildPostsList() : _buildPhotosGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => ListTile(
        leading: Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(8))),
        title: const Text("Header", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("He'll want to use your yacht, and I don't want this thing smelling like fish."),
        trailing: const Text("8m ago", style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildPhotosGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}