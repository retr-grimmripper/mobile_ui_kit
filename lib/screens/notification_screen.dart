import 'package:flutter/material.dart';
// import '../theme/styles.dart'; // Uncomment if you have your styles file

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
        // Custom Back Button to match your theme
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5DB075)), // Green color from your previous screens
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Filter", style: TextStyle(color: Color(0xFF5DB075), fontSize: 16)),
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _dummyNotifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return _NotificationTile(item: _dummyNotifications[index]);
        },
      ),
    );
  }
}

// Simple widget for the individual notification row
class _NotificationTile extends StatelessWidget {
  final Map<String, dynamic> item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                          text: item['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: " ${item['action']}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['time'],
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
          ),
          // Optional: Show a preview image if they commented on a photo
          if (item['hasPreview'])
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}

// Dummy Data
final List<Map<String, dynamic>> _dummyNotifications = [
  {
    "name": "Kevin H.",
    "action": "commented on your post: 'That looks amazing!'",
    "time": "5m ago",
    "image": "https://i.pravatar.cc/150?img=11",
    "hasPreview": true,
  },
  {
    "name": "Alice Smith",
    "action": "liked your cover photo.",
    "time": "20m ago",
    "image": "https://i.pravatar.cc/150?img=5",
    "hasPreview": false,
  },
  {
    "name": "Market Team",
    "action": "Your item 'Gaming Mouse' has been approved.",
    "time": "1h ago",
    "image": "https://i.pravatar.cc/150?img=8",
    "hasPreview": true,
  },
  {
    "name": "John Doe",
    "action": "started following you.",
    "time": "2h ago",
    "image": "https://i.pravatar.cc/150?img=3",
    "hasPreview": false,
  },
];