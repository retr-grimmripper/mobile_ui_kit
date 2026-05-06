import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../theme/styles.dart';
import 'package:mobile_ui_kit1/lib/services/database_service.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  void _submitPost() async {
    if (_postController.text.trim().isEmpty) return;

    // Send to Firebase
    await DatabaseService.createPost(_postController.text.trim());

    // Clear the input and hide keyboard
    _postController.clear();
    FocusScope.of(context).unfocus();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Eco-impact shared! +15 Points 🌱")),
      );
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Community Feed",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back", style: TextStyle(color: AppTheme.primaryGreen, fontSize: 16)),
        ),
      ),
      body: Column(
        children: [
          // Input Area
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: "What's your eco-impact today?",
                filled: true,
                fillColor: AppTheme.inputFill,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                prefixIcon: const Icon(Icons.edit, color: AppColors.primary),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: _submitPost,
                ),
              ),
              style: const TextStyle(color: Colors.black87),
              cursorColor: AppTheme.primaryGreen,
              onSubmitted: (_) => _submitPost(),
            ),
          ),

          // Real-Time Feed List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: DatabaseService.getFeedStream(),
              builder: (context, snapshot) {
                // Handle Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                // Handle Error State
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // Handle Empty State
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No eco-posts yet. Be the first!", style: TextStyle(color: Colors.grey)));
                }

                final posts = snapshot.data!.docs;

                return ListView.separated(
                  itemCount: posts.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final postDoc = posts[index];
                    final postData = postDoc.data() as Map<String, dynamic>;

                    return _buildPremiumFeedItem(
                      postId: postDoc.id,
                      data: postData,
                      isLiked: (postData['likedBy'] as List).contains(currentUserId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFeedItem({required String postId, required Map<String, dynamic> data, required bool isLiked}) {
    // Format timestamp roughly (You can use the 'timeago' package for better formatting later)
    final timestamp = data['timestamp'] as Timestamp?;
    final timeString = timestamp != null ? "${DateTime.now().difference(timestamp.toDate()).inMinutes}m ago" : "Just now";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Glowing Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: const Center(child: Icon(Icons.energy_savings_leaf, color: Colors.white, size: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['authorName'] ?? 'Eco Warrior',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    Text(timeString, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  data['content'] ?? '',
                  style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Interactive Real-Time Like Button
                    GestureDetector(
                      onTap: () => DatabaseService.toggleLike(postId, data['likedBy'] ?? []),
                      child: Row(
                        children: [
                          Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 20,
                              color: isLiked ? Colors.red : Colors.grey[500]
                          ),
                          const SizedBox(width: 6),
                          Text(
                              "${data['likeCount'] ?? 0}",
                              style: TextStyle(color: isLiked ? Colors.red : Colors.grey[500], fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.comment_outlined, size: 20, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Text("${data['commentCount'] ?? 0}", style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}