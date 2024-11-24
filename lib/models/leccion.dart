import 'package:flutter/material.dart';

enum TipoLeccion {
  normal,
  cuento,
}

class Leccion {
  final String titulo;
  final String descripcion;
  final int nivel;
  final Color color;
  final IconData icono;
  final TipoLeccion tipo;
  final List<DialogoParte>? dialogos;

  const Leccion({
    required this.titulo,
    required this.descripcion,
    required this.nivel,
    required this.color,
    required this.icono,
    required this.tipo,
    this.dialogos,
  }) : assert(
          tipo != TipoLeccion.cuento || (tipo == TipoLeccion.cuento && dialogos != null),
          'Las lecciones de tipo cuento deben tener diálogos',
        );
}

class DialogoParte {
  final String texto;
  final String? traduccion;
  final String? audioUrl;
  final IconData? avatarIcon;
  final Color? avatarColor;
  final bool esNarracion;
  final Pregunta? pregunta;

  DialogoParte({
    required this.texto,
    this.traduccion,
    this.audioUrl,
    this.avatarIcon,
    this.avatarColor,
    this.esNarracion = false,
    this.pregunta,
  });
}

class Pregunta {
  final String pregunta;
  final List<String> opciones;
  final int respuestaCorrecta;
  final String explicacion;

  Pregunta({
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
  });
} 