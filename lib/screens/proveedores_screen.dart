import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/proveedor_model.dart';
import '../providers/proveedor_provider.dart';
import '../widgets/proveedor_card.dart';

class ProveedoresScreen extends StatelessWidget {
  const ProveedoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nombreController = TextEditingController();
          final apellidoController = TextEditingController();
          final correoController = TextEditingController();
          final estadoController = TextEditingController();

          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Agregar proveedor'),
                  content: SingleChildScrollView(
                    child: Column(
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
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final nuevoProveedor = ProveedorItem(
                          providerId: 0,
                          providerName: nombreController.text,
                          providerLastName: apellidoController.text,
                          providerMail: correoController.text,
                          providerState: estadoController.text,
                        );
                        await Provider.of<ProveedorProvider>(
                          context,
                          listen: false,
                        ).agregarProveedor(nuevoProveedor);
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
            Provider.of<ProveedorProvider>(
              context,
              listen: false,
            ).cargarProveedores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(' Error al cargar proveedores:\n${snapshot.error}'),
            );
          }

          final proveedores =
              Provider.of<ProveedorProvider>(context).proveedores;

          print(' Proveedores cargados: ${proveedores.length}');

          if (proveedores.isEmpty) {
            return const Center(child: Text('No hay proveedores disponibles'));
          }

          return ListView.builder(
            itemCount: proveedores.length,
            itemBuilder: (context, index) {
              return ProveedorCard(proveedor: proveedores[index]);
            },
          );
        },
      ),
    );
  }
}
