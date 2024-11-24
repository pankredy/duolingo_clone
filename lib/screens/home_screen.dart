import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/lesson_card.dart';
import '../models/leccion.dart';
import 'story_lesson_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('Language Stories'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.book_fill),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person_fill),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Historias',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: LeccionesData.lecciones.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final leccion = LeccionesData.lecciones[index];
                  return _buildLeccionItem(context, leccion);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeccionItem(BuildContext context, Leccion leccion) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryLessonScreen(leccion: leccion),
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: leccion.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    leccion.icono,
                    color: leccion.color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            leccion.titulo,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            CupertinoIcons.book_fill,
                            color: leccion.color,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        leccion.descripcion,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: leccion.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Nivel ${leccion.nivel}',
                    style: TextStyle(
                      color: leccion.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeccionesData {
  static final List<Leccion> lecciones = [
    Leccion(
      titulo: 'Una cita',
      descripcion: 'Julia tiene una cita en el restaurante',
      nivel: 2,
      color: Colors.red,
      icono: Icons.restaurant,
      tipo: TipoLeccion.cuento,
      dialogos: [
        DialogoParte(
          texto: 'Julia and Daniel are meeting for their first date.',
          traduccion: 'Julia y Daniel se encuentran en su primera cita.',
          esNarracion: true,
        ),
        DialogoParte(
          texto: 'They met at the university library last week.',
          traduccion: 'Se conocieron en la biblioteca de la universidad la semana pasada.',
          esNarracion: true,
        ),
        DialogoParte(
          texto: 'Hi! How are you?',
          traduccion: '¡Hola! ¿Cómo estás?',
          avatarIcon: Icons.face,
          avatarColor: Colors.purple,
        ),
        DialogoParte(
          texto: 'Good, thanks!',
          traduccion: '¡Bien, gracias!',
          avatarIcon: Icons.face_2,
          avatarColor: Colors.blue,
        ),
        DialogoParte(
          texto: 'What do you want to eat?',
          traduccion: '¿Qué quieres comer?',
          avatarIcon: Icons.face,
          avatarColor: Colors.purple,
        ),
        DialogoParte(
          texto: '',
          esNarracion: true,
          pregunta: Pregunta(
            pregunta: 'Daniel quiere saber...',
            opciones: [
              '...si Julia quiere pagar la cuenta.',
              '...qué quiere comer Julia.',
            ],
            respuestaCorrecta: 1,
            explicacion: 'Daniel preguntó "What do you want to eat?" (¿Qué quieres comer?)',
          ),
        ),
        DialogoParte(
          texto: 'I want pasta. And you?',
          traduccion: 'Quiero pasta. ¿Y tú?',
          avatarIcon: Icons.face_2,
          avatarColor: Colors.blue,
        ),
        DialogoParte(
          texto: 'I prefer the fish.',
          traduccion: 'Prefiero el pescado.',
          avatarIcon: Icons.face,
          avatarColor: Colors.purple,
        ),
        DialogoParte(
          texto: '',
          esNarracion: true,
          pregunta: Pregunta(
            pregunta: '¿Qué van a comer?',
            opciones: [
              'Julia pasta y Daniel pescado',
              'Julia pescado y Daniel pasta',
              'Ambos quieren pasta',
              'Ambos quieren pescado',
            ],
            respuestaCorrecta: 0,
            explicacion: 'Julia dijo que quiere pasta y Daniel prefiere el pescado.',
          ),
        ),
        DialogoParte(
          texto: 'The pasta here is delicious!',
          traduccion: '¡La pasta aquí es deliciosa!',
          avatarIcon: Icons.face_2,
          avatarColor: Colors.blue,
        ),
        DialogoParte(
          texto: 'Have you been here before?',
          traduccion: '¿Has estado aquí antes?',
          avatarIcon: Icons.face,
          avatarColor: Colors.purple,
        ),
        DialogoParte(
          texto: '',
          esNarracion: true,
          pregunta: Pregunta(
            pregunta: '¿Qué podemos inferir?',
            opciones: [
              'Es la primera vez que Daniel viene al restaurante',
              'Julia conoce el restaurante',
              'Ninguno conoce el restaurante',
            ],
            respuestaCorrecta: 1,
            explicacion: 'Julia sabe que la pasta es deliciosa, lo que sugiere que ha estado antes en el restaurante.',
          ),
        ),
        DialogoParte(
          texto: 'Yes, I come here often.',
          traduccion: 'Sí, vengo aquí a menudo.',
          avatarIcon: Icons.face_2,
          avatarColor: Colors.blue,
        ),
        DialogoParte(
          texto: 'Waiter, we are ready to order!',
          traduccion: '¡Mesero, estamos listos para ordenar!',
          avatarIcon: Icons.face,
          avatarColor: Colors.purple,
        ),
        DialogoParte(
          texto: '',
          esNarracion: true,
          pregunta: Pregunta(
            pregunta: '¿Cuál es la situación actual?',
            opciones: [
              'Están esperando la comida',
              'Están listos para pedir',
              'Están pagando la cuenta',
            ],
            respuestaCorrecta: 1,
            explicacion: 'Daniel llama al mesero diciendo que están listos para ordenar.',
          ),
        ),
      ],
    ),
  ];
}
