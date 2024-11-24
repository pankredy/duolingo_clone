import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final int vidas;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.vidas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                minHeight: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                vidas.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 