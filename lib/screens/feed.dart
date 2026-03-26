import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Feed",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back", style: TextStyle(color: AppTheme.primaryGreen)),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Filter", style: TextStyle(color: AppTheme.primaryGreen)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: AppTheme.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              ),
                style: const TextStyle(color: AppTheme.secondaryText),
                cursorColor: AppTheme.primaryGreen,
                cursorHeight: 20,
                cursorWidth: 1,
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: 5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildFeedItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF77F3BB),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Switch to Eco Today!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("8m ago", style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "He'll want to use your yacht, and I don't want this thing smelling like fish.",
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}