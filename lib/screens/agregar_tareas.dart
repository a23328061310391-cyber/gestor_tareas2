import 'package:flutter/material.dart';

class AgregarTarea extends StatefulWidget {
  const AgregarTarea({super.key});

  @override
  State<AgregarTarea> createState() => _AgregarTareaState();
}

class _AgregarTareaState extends State<AgregarTarea> {
  final TextEditingController controlador = TextEditingController();

  void guardarTarea() {
    String texto = controlador.text.trim();

    if (texto.isNotEmpty) {
      Navigator.pop(context, texto);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 8),
              Text('Escribe una tarea primero'),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '✏️ Nueva Tarea',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ── Ícono decorativo ──────────────────────────────────────
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_note_rounded,
                  size: 44,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              '¿Qué necesitas hacer?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // ── Campo de texto ────────────────────────────────────────
            TextField(
              controller: controlador,
              autofocus: true,
              maxLines: 3,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Ej: Estudiar Flutter...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.task_alt,
                  color: Color(0xFF6C63FF),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF6C63FF),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Botón guardar ─────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: guardarTarea,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Guardar tarea',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Botón cancelar ────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                label: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6C63FF),
                  side: const BorderSide(color: Color(0xFF6C63FF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}