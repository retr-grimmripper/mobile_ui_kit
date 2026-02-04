import 'package:flutter/material.dart';
import '../theme/styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  final String label;
  final bool isPassword;

  const CustomInput({super.key, required this.label, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        suffixText: isPassword ? "Show" : null,
        suffixStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String leftText;
  final String rightText;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.leftText = "Back",
    this.rightText = "Filter",
    this.onLeftTap,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onLeftTap ?? () => Navigator.pop(context),
            child: Text(leftText, style: AppText.body.copyWith(color: AppColors.primary)),
          ),
          Text(title, style: AppText.header1),
          TextButton(
            onPressed: onRightTap ?? () {},
            child: Text(rightText, style: AppText.body.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class ToggleSwitch extends StatelessWidget {
  final bool isLeftActive;
  final Function(bool) onToggle;

  const ToggleSwitch({super.key, required this.isLeftActive, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _buildOption("Posts", isLeftActive)),
          Expanded(child: _buildOption("Photos", !isLeftActive)),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool isActive) {
    return GestureDetector(
      onTap: () => onToggle(text == "Posts"),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        decoration: isActive
            ? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100))
            : null,
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? AppColors.primary : const Color(0xFFBDBDBD),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}