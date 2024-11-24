import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import '../models/leccion.dart';
import '../widgets/palabra_button.dart';

class LessonScreen extends StatefulWidget {
  final Leccion leccion;

  const LessonScreen({super.key, required this.leccion});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<String> palabrasSeleccionadas = [];
  final List<String> palabrasDisponibles = [
    'This', 'neighborhood', 'did', "n't", 'be',
    'dangerous', 'to', 'use', 'tallest'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.leccion.titulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProgressBar(progress: 0.3, vidas: 3),
            _buildEjercicioDificil(),
            _buildInstruccion(),
            _buildAreaRespuesta(),
            const Spacer(),
            _buildPalabrasDisponibles(),
            _buildBotonComprobar(),
          ],
        ),
      ),
    );
  }

  Widget _buildEjercicioDificil() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red[400], size: 16),
                const SizedBox(width: 8),
                Text(
                  'EJERCICIO DIFÍCIL',
                  style: TextStyle(color: Colors.red[400], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruccion() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Traduce esta oración',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 16),
                Text(
                  'Este vecindario no\nsolía ser peligroso.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaRespuesta() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        palabrasSeleccionadas.join(' '),
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildPalabrasDisponibles() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: palabrasDisponibles.map((palabra) {
          return PalabraButton(
            palabra: palabra,
            onTap: () {
              setState(() {
                palabrasSeleccionadas.add(palabra);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBotonComprobar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF58CC02),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'COMPROBAR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 