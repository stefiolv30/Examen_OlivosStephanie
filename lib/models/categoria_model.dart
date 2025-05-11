class CategoriaItem {
  final int categoryId;
  final String categoryName;
  final String categoryState;

  CategoriaItem({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  factory CategoriaItem.fromMap(Map<String, dynamic> json) => CategoriaItem(
    categoryId: json['category_id'],
    categoryName: json['category_name'],
    categoryState: json['category_state'],
  );
}
