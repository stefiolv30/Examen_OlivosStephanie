import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/categoria_model.dart';
import '../providers/categoria_provider.dart';
import '../widgets/categoria_card.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nombreController = TextEditingController();
          final estadoController = TextEditingController();

          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Agregar Categoría'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nombreController,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      TextField(
                        controller: estadoController,
                        decoration: const InputDecoration(labelText: 'Estado'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final nuevaCategoria = CategoriaItem(
                          categoryId: 0,
                          categoryName: nombreController.text,
                          categoryState: estadoController.text,
                        );
                        await Provider.of<CategoriaProvider>(
                          context,
                          listen: false,
                        ).agregarCategoria(nuevaCategoria);
                        Navigator.pop(context);
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future:
            Provider.of<CategoriaProvider>(
              context,
              listen: false,
            ).cargarCategorias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(' Error al cargar categorías:\n${snapshot.error}'),
            );
          }

          final categorias = Provider.of<CategoriaProvider>(context).categorias;

          if (categorias.isEmpty) {
            return const Center(child: Text('No hay categorías disponibles'));
          }

          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              return CategoriaCard(categoria: categorias[index]);
            },
          );
        },
      ),
    );
  }
}
