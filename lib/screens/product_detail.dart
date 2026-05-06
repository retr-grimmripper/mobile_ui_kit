import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_ui_kit1/theme/styles.dart';
import 'market.dart'; // Import to access the Product model

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. The Background Image (using Hero for seamless transition)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Hero(
              tag: product.id,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Custom Back Button with Glassmorphism
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
                  ),
                ),
              ),
            ),
          ),

          // 2. The Glassmorphic Details Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55, // Overlaps the image slightly
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
                ],
              ),
              child: Column(
                children: [
                  // Drag indicator pill
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Price Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
                                ),
                              ),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Vendor Name
                          Text(
                            "By ${product.vendorName}",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 24),

                          // Eco-Impact Banner
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.park, color: AppColors.primary, size: 28),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Eco-Impact", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      Text(product.ecoImpact, style: TextStyle(color: Colors.grey[800], fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Description Placeholder
                          const Text(
                            "Description",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "This premium eco-friendly product is sourced sustainably to minimize carbon footprint. Make a positive impact on the environment with every purchase.",
                            style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.6),
                          ),
                          const SizedBox(height: 100), // Spacing for bottom button
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Floating Add to Cart Button
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 10,
                shadowColor: AppColors.primary.withOpacity(0.5),
              ),
              onPressed: () {
                // Future: Add to cart logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Eco-Cart! 🌱")),
                );
              },
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}