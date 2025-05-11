import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto_model.dart';
import '../providers/producto_provider.dart';

class ProductoCard extends StatelessWidget {
  final ProductItem producto;
  const ProductoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            producto.productImage,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(
          producto.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('\$${producto.productPrice} CLP'),
        onTap: () => _mostrarDetalle(context, producto),
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, ProductItem producto) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(producto.productName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  producto.productImage,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                ),
                const SizedBox(height: 10),
                Text('Precio: \$${producto.productPrice} CLP'),
                Text('Estado: ${producto.productState}'),
              ],
            ),
            actions: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _mostrarFormularioEditar(context, producto);
                    },
                    child: const Text('Editar'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Confirmar eliminación'),
                              content: const Text(
                                '¿Estás seguro/a de que deseas eliminar este producto?',
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
                                    Navigator.pop(context);
                                    await Provider.of<ProductProvider>(
                                      context,
                                      listen: false,
                                    ).eliminarProducto(producto.productId);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sí, eliminar'),
                                ),
                              ],
                            ),
                      );
                    },
                    child: const Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  void _mostrarFormularioEditar(BuildContext context, ProductItem producto) {
    final nombreController = TextEditingController(text: producto.productName);
    final precioController = TextEditingController(
      text: producto.productPrice.toString(),
    );
    final imagenController = TextEditingController(text: producto.productImage);
    final estadoController = TextEditingController(text: producto.productState);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Editar producto'),
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
                    decoration: const InputDecoration(
                      labelText: 'URL de imagen',
                    ),
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
                  final productoEditado = ProductItem(
                    productId: producto.productId,
                    productName: nombreController.text,
                    productPrice: int.tryParse(precioController.text) ?? 0,
                    productImage: imagenController.text,
                    productState: estadoController.text,
                  );

                  await Provider.of<ProductProvider>(
                    context,
                    listen: false,
                  ).editarProducto(productoEditado);

                  Navigator.pop(context);
                },
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
    );
  }
}
