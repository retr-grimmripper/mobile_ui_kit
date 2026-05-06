import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ==========================================
  // 1. POSTS (SOCIAL FEED)
  // ==========================================

  // Get a real-time stream of all posts
  static Stream<QuerySnapshot> getFeedStream() {
    return _db.collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Create a new post
  static Future<void> createPost(String content) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Fetch the user's name from their profile
    final userDoc = await _db.collection('users').doc(user.uid).get();
    final authorName = userDoc.data()?['name'] ?? 'Eco Warrior';

    // Add the post to Firestore
    await _db.collection('posts').add({
      'authorId': user.uid,
      'authorName': authorName,
      'content': content,
      'likeCount': 0,
      'likedBy': [], // List of user IDs who liked it
      'commentCount': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Award 15 Eco-Points for posting!
    await updateEcoPoints(user.uid, 15);
  }

  // Toggle a Like on a post
  static Future<void> toggleLike(String postId, List dynamicLikedBy) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final postRef = _db.collection('posts').doc(postId);

    // Check if the user already liked it
    if (dynamicLikedBy.contains(user.uid)) {
      // Unlike
      await postRef.update({
        'likedBy': FieldValue.arrayRemove([user.uid]),
        'likeCount': FieldValue.increment(-1),
      });
    } else {
      // Like
      await postRef.update({
        'likedBy': FieldValue.arrayUnion([user.uid]),
        'likeCount': FieldValue.increment(1),
      });
      // Optional: Award 1 point to the person who liked it
      await updateEcoPoints(user.uid, 1);
    }
  }

  // ==========================================
  // 2. GAMIFICATION (ECO-POINTS)
  // ==========================================

  static Future<void> updateEcoPoints(String uid, int pointsToAdd) async {
    await _db.collection('users').doc(uid).update({
      'ecoPoints': FieldValue.increment(pointsToAdd),
    });
  }
}