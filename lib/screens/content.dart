import 'package:flutter/material.dart';

// 1. The Data Model for your Content
class Article {
  final String id;
  final String title;
  final String category;
  final String readTime;
  final String imageUrl;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.readTime,
    required this.imageUrl,
  });
}

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. High-Quality Dummy Data (Using safe Unsplash URLs)
    // 2. High-Quality Dummy Data (Now using your safe local assets!)
    final Article featuredArticle = Article(
      id: "f1",
      title: "The Ultimate Guide to Zero-Waste Living in 2026",
      category: "Lifestyle",
      readTime: "5 min read",
      imageUrl: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png", // Using a known good local image
    );

    final List<Article> recentArticles = [
      Article(
        id: "a1",
        title: "10 Simple Swaps for a Sustainable Kitchen",
        category: "Home",
        readTime: "3 min read",
        imageUrl: "assets/products/8.-Cloth-Napkins.png",
      ),
      Article(
        id: "a2",
        title: "Understanding Your Daily Carbon Footprint",
        category: "Education",
        readTime: "7 min read",
        imageUrl: "assets/products/1.-Reusable-Beeswax-Food-Wraps.jpeg",
      ),
      Article(
        id: "a3",
        title: "The Rise of Upcycled Fashion Brands",
        category: "Style",
        readTime: "4 min read",
        imageUrl: "assets/products/3.-Bamboo-Toothbrushes.jpeg",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Eco Insights',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Featured",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),
              _buildFeaturedCard(featuredArticle),
              const SizedBox(height: 32),
              const Text(
                "Latest Reads",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),
              ...recentArticles.map((article) => _buildStandardCard(article)),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET: The Large Top Card ---
  Widget _buildFeaturedCard(Article article) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: _buildSafeImage(article.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    article.category.toUpperCase(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  article.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      article.readTime,
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- WIDGET: The Smaller List Cards ---
  Widget _buildStandardCard(Article article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
              child: SizedBox(
                width: 100,
                height: 100,
                child: _buildSafeImage(article.imageUrl),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.category,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- THE CORS-PROOF IMAGE LOADER ---
  // If the browser blocks the web image, it smoothly draws an eco-icon instead of crashing.
  // --- THE SMART IMAGE LOADER ---
  Widget _buildSafeImage(String path) {
    // If it's a web link, use Image.network
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
      );
    }
    // If it's a local file, use Image.asset
    else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
      );
    }
  }

  // The beautiful fallback if an image is missing
  Widget _fallbackIcon() {
    return Container(
      color: const Color(0xFFE8F5E9),
      child: const Center(
        child: Icon(Icons.eco, color: Colors.green, size: 40),
      ),
    );
  }
}