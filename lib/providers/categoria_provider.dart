import 'package:flutter/material.dart';
import '../models/categoria_model.dart';
import '../services/categoria_service.dart';

class CategoriaProvider extends ChangeNotifier {
  final CategoriaService _categoriaService = CategoriaService();
  List<CategoriaItem> categorias = [];

  Future<void> cargarCategorias() async {
    await _categoriaService.loadCategorias();
    categorias = _categoriaService.categorias;
    notifyListeners();
  }

  Future<void> agregarCategoria(CategoriaItem categoria) async {
    await _categoriaService.agregarCategoria(categoria);
    await cargarCategorias();
  }

  Future<void> editarCategoria(CategoriaItem categoria) async {
    await _categoriaService.editarCategoria(categoria);
    await cargarCategorias();
  }

  Future<void> eliminarCategoria(int id) async {
    await _categoriaService.eliminarCategoria(id);
    await cargarCategorias();
  }
}
