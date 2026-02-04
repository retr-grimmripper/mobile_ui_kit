import 'package:flutter/material.dart';
import 'package:mobile_ui_kit1/theme/styles.dart';

class Product {
  final String name;
  final double price;
  final String imagePath;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> hotDeals = [
      Product(name: " Eco-Friendly Charge Lantern", price: 59.99, imagePath: "assets/products/charge_lantern.png"),
      Product(name: "Smart Energy Savings Bulbs", price: 120.00, imagePath: "assets/products/smart-bulbs.png"),
      Product(name: "Re-spin Record Player", price: 85.50, imagePath: "assets/products/respin_record-player.png"),
      Product(name: "Stainless Steel Straws", price: 30.00, imagePath: "assets/products/12.-Stainless-Steel-Straws.jpeg"),
    ];

    final List<Product> trending = [
      Product(name: "Reusable Beewax Food Wrapper", price: 45.00, imagePath: "assets/products/1.-Reusable-Beeswax-Food-Wraps.jpeg"),
      Product(name: "Refillable Glass Soap Dish", price: 89.99, imagePath: "assets/products/2.-Refillable-Glass-Soap-Dispensers.jpeg"),
      Product(name: "Bamboo Toothbrushes", price: 30.00, imagePath: "assets/products/3.-Bamboo-Toothbrushes.jpeg"),
      Product(name: "Cleaning Products  ", price: 101.75, imagePath: "assets/products/7.-Eco-Friendly-Cleaning-Products-2.png"),
      Product(name: "Cloth Napkins", price: 37.00, imagePath: "assets/products/8.-Cloth-Napkins.png"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _MarketHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SearchBar(),

                    _buildSectionTitle("Hot deals"),
                    _buildHorizontalList(hotDeals),

                    _buildSectionTitle("Trending"),
                    _buildHorizontalList(trending),

                    _buildSectionTitle("Deals"),
                    const SizedBox(height: 20),
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
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<Product> products) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _ItemCard(product: products[index]);
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final Product product;

  const _ItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(product.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            product.name,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${product.price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _MarketHeader extends StatelessWidget {
  const _MarketHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text("Back", style: TextStyle(color: Color(0xFF5DB075), fontSize: 16)),
          ),
          const Text("Market", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text("Filter", style: TextStyle(color: Color(0xFF5DB075), fontSize: 16)),
          ),
        ],
      ),
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
            hintText: "Search",
            hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 16),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ),
    );
  }
}