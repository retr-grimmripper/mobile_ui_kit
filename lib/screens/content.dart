import 'package:flutter/material.dart';

class Post {
  final String imagePath;
  final String title;
  final String author;
  final String description;
  final String body;
  final String time;
  bool isLiked;
  int likeCount;
  int commentCount;

  Post({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.description,
    required this.body,
    required this.time,
    this.isLiked = false,
    this.likeCount = 12,
    this.commentCount = 5,
  });
}

final List<String> myImages = [
  "assets/products/phonecase.png",
  "assets/products/smart-bulbs.png",
  "assets/products/sodastream.png",
  "assets/products/thefabric.png",
  "assets/products/charge_lantern.png",
];


final List<Post> dummyPosts = List.generate(
  5,
      (index) => Post(
    imagePath: myImages[index],
    title: "Eco Friendly Paint $index",
    author: "Author Name",
    description: "He'll want to use your yacht, and I don't want this thing smelling like fish.",
    body: "Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat.",
    time: "${index + 8}m ago",
    likeCount: (index * 5) + 10,
    commentCount: (index * 2) + 2,
  ),
);

class PostActionsRow extends StatefulWidget {
  final Post post;

  const PostActionsRow({super.key, required this.post});

  @override
  State<PostActionsRow> createState() => _PostActionsRowState();
}

class _PostActionsRowState extends State<PostActionsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.post.isLiked = !widget.post.isLiked;
              if (widget.post.isLiked) {
                widget.post.likeCount++;
              } else {
                widget.post.likeCount--;
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              children: [
                Icon(
                  widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.isLiked ? Colors.red : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  "${widget.post.likeCount}",
                  style: TextStyle(
                    color: widget.post.isLiked ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 24),

        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Comment on ${widget.post.title}")),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 20),
                const SizedBox(width: 6),
                Text(
                  "${widget.post.commentCount}",
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _CustomHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                ),
              ),
            ),
            // Post List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dummyPosts.length,
                itemBuilder: (context, index) {
                  final post = dummyPosts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(post: post),
                        ),
                      ).then((_) {
                        (context as Element).markNeedsBuild();
                      });
                    },
                    child: _buildContentCard(post),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(Post post) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              // --- THE FIX STARTS HERE ---
              image: DecorationImage(
                image: AssetImage(post.imagePath),
                fit: BoxFit.cover, // Ensures image fills the box
              ),
              // --- THE FIX ENDS HERE ---
            ),
          ),
          const SizedBox(height: 12),
          Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            post.description,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PostActionsRow(post: post),
              Text(
                post.time,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  // --- THE FIX STARTS HERE ---
                  image: DecorationImage(
                    image: AssetImage(post.imagePath),
                    fit: BoxFit.cover,
                  ),
                  // --- THE FIX ENDS HERE ---
                ),
              ),
              const SizedBox(height: 24),
              // ... Rest of your code remains the same ...
              Text(
                post.title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                post.author,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Text(
                post.body,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: PostActionsRow(post: post),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _CustomHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(30)),
                child: const TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: 6,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Search result", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)))))
          ],
        ),
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
            child: const Text("Back", style: TextStyle(color: Colors.green, fontSize: 16)),
          ),
          const Text("Content", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Filter", style: TextStyle(color: Colors.green, fontSize: 16)),
        ],
      ),
    );
  }
}