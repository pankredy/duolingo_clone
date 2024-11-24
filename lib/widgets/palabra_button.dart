import 'package:flutter/material.dart';

class PalabraButton extends StatelessWidget {
  final String palabra;
  final VoidCallback onTap;

  const PalabraButton({
    super.key,
    required this.palabra,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      child: Text(palabra),
    );
  }
} 