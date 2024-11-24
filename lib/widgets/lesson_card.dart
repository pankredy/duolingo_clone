import 'package:flutter/material.dart';
import '../models/leccion.dart';

class LessonCard extends StatelessWidget {
  final Leccion leccion;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.leccion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                leccion.icono,
                size: 40,
                color: leccion.color,
              ),
              const SizedBox(height: 12),
              Text(
                leccion.titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                leccion.descripcion,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: leccion.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Nivel ${leccion.nivel}',
                  style: TextStyle(
                    color: leccion.color,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 