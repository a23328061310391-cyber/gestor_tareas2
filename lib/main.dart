import 'package:flutter/material.dart';
import 'models/tarea.dart';
import 'screens/agregar_tareas.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}  

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  List<Tarea> tareas = [];

  Future<void> agregarTarea() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarTarea(),
      ),
    );

    if (resultado != null) {
      setState(() {
        tareas.add(Tarea(resultado.toString()));
      });
    }
  }

  void completarTarea(int index) {
    setState(() {
      tareas[index].completada = !tareas[index].completada;
    });
  }

  void eliminarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  int get _completadas => tareas.where((t) => t.completada).length;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '📝 Mis Tareas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$_completadas/${tareas.length} completadas',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ],
      ),

      // ── Barra de progreso ──────────────────────────────────────────
      body: Column(
        children: [
          if (tareas.isNotEmpty)
            Container(
              color: const Color(0xFF6C63FF),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progreso',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: tareas.isEmpty
                          ? 0
                          : _completadas / tareas.length,
                      minHeight: 10,
                      backgroundColor: Colors.white30,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),

          // ── Lista de tareas ────────────────────────────────────────
          Expanded(
            child: tareas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          '¡Sin tareas por ahora!',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Toca el botón + para agregar una',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = tareas[index];
                      return Dismissible(
                        key: Key(tarea.titulo + index.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => eliminarTarea(index),
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete_outline,
                              color: Colors.white, size: 28),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: tarea.completada ? 0 : 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: tarea.completada
                              ? Colors.grey.shade100
                              : Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: GestureDetector(
                              onTap: () => completarTarea(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: tarea.completada
                                      ? const Color(0xFF6C63FF)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: tarea.completada
                                        ? const Color(0xFF6C63FF)
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: tarea.completada
                                    ? const Icon(Icons.check,
                                        color: Colors.white, size: 18)
                                    : null,
                              ),
                            ),
                            title: Text(
                              tarea.titulo,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: tarea.completada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tarea.completada
                                    ? Colors.grey
                                    : Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              tarea.completada ? '✅ Completada' : '⏳ Pendiente',
                              style: TextStyle(
                                fontSize: 12,
                                color: tarea.completada
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline,
                                  color: Colors.red.shade300),
                              onPressed: () => eliminarTarea(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ── Botón flotante ─────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: agregarTarea,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva tarea',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}