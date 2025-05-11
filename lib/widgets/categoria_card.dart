import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/categoria_model.dart';
import '../providers/categoria_provider.dart';

class CategoriaCard extends StatelessWidget {
  final CategoriaItem categoria;

  const CategoriaCard({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3F0FF),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.category, size: 50),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoria.categoryName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('Estado: ${categoria.categoryState}'),
                      Text('ID: ${categoria.categoryId}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text(categoria.categoryName),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('ID: ${categoria.categoryId}'),
                                Text('Estado: ${categoria.categoryState}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    final nombreController = TextEditingController(
                      text: categoria.categoryName,
                    );
                    final estadoController = TextEditingController(
                      text: categoria.categoryState,
                    );

                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Editar Categoría'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nombreController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre',
                                  ),
                                ),
                                TextField(
                                  controller: estadoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Estado',
                                  ),
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
                                  final categoriaEditada = CategoriaItem(
                                    categoryId: categoria.categoryId,
                                    categoryName: nombreController.text,
                                    categoryState: estadoController.text,
                                  );
                                  await Provider.of<CategoriaProvider>(
                                    context,
                                    listen: false,
                                  ).editarCategoria(categoriaEditada);
                                  Navigator.pop(context);
                                },
                                child: const Text('Guardar'),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: Text(
                              '¿Eliminar categoría "${categoria.categoryName}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  await Provider.of<CategoriaProvider>(
                                    context,
                                    listen: false,
                                  ).eliminarCategoria(categoria.categoryId);
                                  Navigator.pop(context);
                                },
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
