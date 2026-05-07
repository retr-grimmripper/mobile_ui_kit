import 'package:flutter/material.dart';
import 'package:mobile_ui_kit1/theme/styles.dart';
import 'product_detail.dart'; // We will create this next

// 1. Updated Product Model for Premium Eco Data
class Product {
  final String id;
  final String name;
  final double price;
  final String imagePath; // Kept so you can easily swap real images in later!
  final String vendorName;
  final String ecoImpact;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.vendorName = "EcoStore",
    this.ecoImpact = "Carbon Neutral",
  });
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Restructured Eco-Categories
    final List<Product> zeroWaste = [
      Product(id: "z1", name: "Premium Cloth Napkins", price: 59.99, imagePath: "assets/products/8.-Cloth-Napkins.png", ecoImpact: "Saves 100+ paper towels"),
      Product(id: "z2", name: "Reusable Beeswax Wraps", price: 85.50, imagePath: "assets/products/1.-Reusable-Beeswax-Food-Wraps.jpeg", ecoImpact: "Zero Plastic"),
      Product(id: "z3", name: "Stainless Steel Straws", price: 30.00, imagePath: "assets/products/12.-Stainless-Steel-Straws.jpeg", ecoImpact: "Ocean Friendly"),
      Product(id: "z4", name: "Stainless Steel Straws", price: 30.00, imagePath: "assets/products/12.-Stainless-Steel-Straws.jpeg", ecoImpact: "Ocean Friendly"),
      Product(id: "z5", name: "Stainless Steel Straws", price: 30.00, imagePath: "assets/products/12.-Stainless-Steel-Straws.jpeg", ecoImpact: "Ocean Friendly"),
      Product(id: "z6", name: "Stainless Steel Straws", price: 30.00, imagePath: "assets/products/12.-Stainless-Steel-Straws.jpeg", ecoImpact: "Ocean Friendly"),

    ];

    final List<Product> ecoHome = [
      Product(id: "h1", name: "Glass Soap Dispensers", price: 120.00, imagePath: "assets/products/2.-Refillable-Glass-Soap-Dispensers.jpeg", ecoImpact: "Refillable"),
      Product(id: "h2", name: "Bamboo Toothbrushes", price: 30.00, imagePath: "assets/products/3.-Bamboo-Toothbrushes.jpeg", ecoImpact: "100% Biodegradable"),
      Product(id: "h3", name: "Eco Cleaning Kit", price: 101.75, imagePath: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png", ecoImpact: "Non-Toxic"),
      Product(id: "h4", name: "Eco Cleaning Kit", price: 101.75, imagePath: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png", ecoImpact: "Non-Toxic"),
      Product(id: "h5", name: "Eco Cleaning Kit", price: 101.75, imagePath: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png", ecoImpact: "Non-Toxic"),
      Product(id: "h6", name: "Eco Cleaning Kit", price: 101.75, imagePath: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png", ecoImpact: "Non-Toxic"),

    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _MarketHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SearchBar(),
                    _buildSectionTitle("Zero Waste Living"),
                    _buildHorizontalList(zeroWaste),
                    _buildSectionTitle("Sustainable Eco-Home"),
                    _buildHorizontalList(ecoHome),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -0.5),
      ),
    );
  }

  Widget _buildHorizontalList(List<Product> products) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _PremiumItemCard(product: products[index]);
        },
      ),
    );
  }
}

class _PremiumItemCard extends StatelessWidget {
  final Product product;

  const _PremiumItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
        );
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- THE SAFE BULLETPROOF PLACEHOLDER ---
            // Replaced the broken AssetImage with a clean green placeholder box
            Hero(
              tag: product.id,
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  // THE SMART IMAGE FIX:
                  image: DecorationImage(
                    image: product.imagePath.startsWith('http')
                        ? NetworkImage(product.imagePath) as ImageProvider
                        : AssetImage(product.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.eco, color: Colors.white, size: 14),
                  ),
                ),
              ),
            ),
            // --- END PLACEHOLDER ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Kept your custom header and search bar exactly as they were!
class _MarketHeader extends StatelessWidget {
  const _MarketHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text("Back", style: TextStyle(color: Color(0xFF5DB075), fontSize: 16))),
              const Text("Market", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
              TextButton(onPressed: () {}, child: const Text("Filter", style: TextStyle(color: Color(0xFF5DB075), fontSize: 16)))
            ]
        )
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
            height: 50,
            decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(25)),
            child: const TextField(
                decoration: InputDecoration(
                    hintText: "Search eco-products",
                    hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFBDBDBD))
                )
            )
        )
    );
  }
}