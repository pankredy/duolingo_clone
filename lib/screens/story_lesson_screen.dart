import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/leccion.dart';

class StoryLessonScreen extends StatefulWidget {
  final Leccion leccion;

  const StoryLessonScreen({super.key, required this.leccion});

  @override
  State<StoryLessonScreen> createState() => _StoryLessonScreenState();
}

class _StoryLessonScreenState extends State<StoryLessonScreen> {
  int currentIndex = 0;
  bool showTranslation = false;
  int? selectedOption;
  bool hasAnswered = false;
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogoParte = widget.leccion.dialogos![currentIndex];
    final esPregunta = dialogoParte.pregunta != null;

    _scrollToBottom();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.leccion.titulo),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      currentIndex + 1,
                      (index) {
                        final parte = widget.leccion.dialogos![index];
                        if (parte.esNarracion) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildNarracion(parte),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildDialogo(parte),
                          );
                        }
                      },
                    ),
                    if (esPregunta) ...[
                      const SizedBox(height: 16),
                      _buildPregunta(dialogoParte.pregunta!),
                    ],
                  ],
                ),
              ),
            ),
            _buildBottomButton(dialogoParte),
          ],
        ),
      ),
    );
  }

  Widget _buildNarracion(DialogoParte parte) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parte.texto,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          if (showTranslation && parte.traduccion != null) ...[
            const SizedBox(height: 8),
            Text(
              parte.traduccion!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDialogo(DialogoParte parte) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: parte.avatarColor?.withOpacity(0.1) ?? Colors.grey[200],
            child: Icon(
              parte.avatarIcon ?? CupertinoIcons.person_fill,
              color: parte.avatarColor ?? Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parte.texto,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  if (showTranslation && parte.traduccion != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      parte.traduccion!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPregunta(Pregunta pregunta) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF007AFF).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007AFF).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF007AFF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.question_circle_fill,
                  color: Color(0xFF007AFF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Responde la pregunta',
                style: TextStyle(
                  color: Color(0xFF007AFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            pregunta.pregunta,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            pregunta.opciones.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildOpcion(index, pregunta),
            ),
          ),
          if (hasAnswered && selectedOption == pregunta.respuestaCorrecta)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF34C759).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Color(0xFF34C759),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '¡Correcto!',
                    style: TextStyle(
                      color: Color(0xFF34C759),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOpcion(int index, Pregunta pregunta) {
    final bool isSelected = selectedOption == index;
    final bool isCorrect = index == pregunta.respuestaCorrecta;
    
    return GestureDetector(
      onTap: hasAnswered ? null : () => setState(() => selectedOption = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getOptionBackgroundColor(index, isSelected, isCorrect),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getOptionBorderColor(index, isSelected, isCorrect),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getOptionBorderColor(index, isSelected, isCorrect),
                  width: 2,
                ),
              ),
              child: _buildOptionCheckmark(index, isSelected, isCorrect),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                pregunta.opciones[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getOptionBackgroundColor(int index, bool isSelected, bool isCorrect) {
    if (!hasAnswered) {
      return isSelected ? const Color(0xFFE5E5EA) : Colors.white;
    }
    if (isCorrect) return const Color(0xFF34C759).withOpacity(0.1);
    if (isSelected) return const Color(0xFFFF3B30).withOpacity(0.1);
    return Colors.white;
  }

  Color _getOptionBorderColor(int index, bool isSelected, bool isCorrect) {
    if (!hasAnswered) {
      return isSelected ? const Color(0xFF007AFF) : const Color(0xFFE5E5EA);
    }
    if (isCorrect) return const Color(0xFF34C759);
    if (isSelected) return const Color(0xFFFF3B30);
    return const Color(0xFFE5E5EA);
  }

  Widget? _buildOptionCheckmark(int index, bool isSelected, bool isCorrect) {
    if (!hasAnswered) {
      return isSelected 
          ? const Icon(CupertinoIcons.checkmark_alt, size: 16, color: Color(0xFF007AFF))
          : null;
    }
    if (isCorrect) {
      return const Icon(CupertinoIcons.checkmark_alt, size: 16, color: Color(0xFF34C759));
    }
    if (isSelected) {
      return const Icon(CupertinoIcons.xmark, size: 16, color: Color(0xFFFF3B30));
    }
    return null;
  }

  Widget _buildBottomButton(DialogoParte parte) {
    final bool esUltimaParte = currentIndex == widget.leccion.dialogos!.length - 1;
    final bool mostrarMensajeFinal = esUltimaParte && hasAnswered;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mostrarMensajeFinal)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF34C759).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.book_fill,
                      color: Color(0xFF34C759),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Historia completada!',
                    style: TextStyle(
                      color: Color(0xFF34C759),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if (!parte.esNarracion && parte.traduccion != null)
                IconButton(
                  icon: Icon(
                    CupertinoIcons.text_bubble,
                    color: showTranslation ? const Color(0xFF007AFF) : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      showTranslation = !showTranslation;
                    });
                    if (showTranslation) {
                      _scrollToBottom();
                    }
                  },
                ),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xFF007AFF),
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () {
                    setState(() {
                      if (parte.pregunta != null) {
                        if (!hasAnswered) {
                          if (selectedOption != null) {
                            hasAnswered = true;
                            _scrollToBottom();
                          }
                        } else {
                          if (mostrarMensajeFinal) {
                            Navigator.of(context).pop();
                          } else if (currentIndex < widget.leccion.dialogos!.length - 1) {
                            currentIndex++;
                            showTranslation = false;
                            selectedOption = null;
                            hasAnswered = false;
                          }
                        }
                      } else {
                        if (currentIndex < widget.leccion.dialogos!.length - 1) {
                          currentIndex++;
                          showTranslation = false;
                          selectedOption = null;
                          hasAnswered = false;
                        }
                      }
                    });
                  },
                  child: Text(
                    mostrarMensajeFinal ? 'Terminar' : _getButtonText(parte),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getButtonText(DialogoParte parte) {
    if (parte.pregunta != null) {
      if (!hasAnswered) {
        if (selectedOption == null) return 'Elige una respuesta';
        return 'Comprobar';
      }
      return 'Continuar';
    }
    return 'Continuar';
  }
} 