import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto_model.dart';
import '../providers/producto_provider.dart';

void mostrarFormularioAgregar(BuildContext context) {
  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final imagenController = TextEditingController();
  final estadoController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Agregar producto'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imagenController,
                decoration: const InputDecoration(labelText: 'URL de imagen'),
              ),
              TextField(
                controller: estadoController,
                decoration: const InputDecoration(labelText: 'Estado'),
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
              final producto = ProductItem(
                productId: 0,
                productName: nombreController.text,
                productPrice: int.tryParse(precioController.text) ?? 0,
                productImage: imagenController.text,
                productState: estadoController.text,
              );
              await Provider.of<ProductProvider>(
                context,
                listen: false,
              ).agregarProducto(producto);
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}
