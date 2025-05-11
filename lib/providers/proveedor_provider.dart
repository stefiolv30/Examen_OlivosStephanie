import 'package:flutter/material.dart';
import '../models/proveedor_model.dart';
import '../services/proveedor_service.dart';

class ProveedorProvider extends ChangeNotifier {
  final ProveedorService _proveedorService = ProveedorService();
  List<ProveedorItem> proveedores = [];

  Future<void> cargarProveedores() async {
    await _proveedorService.loadProveedores();
    proveedores = _proveedorService.proveedores;
    notifyListeners();
  }

  Future<void> agregarProveedor(ProveedorItem proveedor) async {
    await _proveedorService.agregarProveedor(proveedor);
    await cargarProveedores();
  }

  Future<void> editarProveedor(ProveedorItem proveedor) async {
    await _proveedorService.editarProveedor(proveedor);
    await cargarProveedores();
  }

  Future<void> eliminarProveedor(int id) async {
    await _proveedorService.eliminarProveedor(id);
    await cargarProveedores();
  }
}
