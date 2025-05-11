import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/proveedor_model.dart';
import '../providers/proveedor_provider.dart';

class ProveedorCard extends StatelessWidget {
  final ProveedorItem proveedor;
  const ProveedorCard({super.key, required this.proveedor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE0F7FA),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              proveedor.providerName + ' ' + proveedor.providerLastName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Correo: ${proveedor.providerMail}'),
            Text('Estado: ${proveedor.providerState}'),
            Text('ID: ${proveedor.providerId}'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    final nombreController = TextEditingController(
                      text: proveedor.providerName,
                    );
                    final apellidoController = TextEditingController(
                      text: proveedor.providerLastName,
                    );
                    final correoController = TextEditingController(
                      text: proveedor.providerMail,
                    );
                    final estadoController = TextEditingController(
                      text: proveedor.providerState,
                    );

                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Editar proveedor'),
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
                                  controller: apellidoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Apellido',
                                  ),
                                ),
                                TextField(
                                  controller: correoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Correo',
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
                                  final proveedorEditado = ProveedorItem(
                                    providerId: proveedor.providerId,
                                    providerName: nombreController.text,
                                    providerLastName: apellidoController.text,
                                    providerMail: correoController.text,
                                    providerState: estadoController.text,
                                  );
                                  await Provider.of<ProveedorProvider>(
                                    context,
                                    listen: false,
                                  ).editarProveedor(proveedorEditado);
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
                            title: const Text('Eliminar proveedor'),
                            content: const Text(
                              '¿Estás seguro/a de eliminar este proveedor?',
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
                                  await Provider.of<ProveedorProvider>(
                                    context,
                                    listen: false,
                                  ).eliminarProveedor(proveedor.providerId);
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
