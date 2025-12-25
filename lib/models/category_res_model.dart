class CategoryListRes {
  List<CategoryListQuery>? categories;

  CategoryListRes({this.categories});

  factory CategoryListRes.fromJson(Map<String, dynamic> json) {
    return CategoryListRes(
      categories: json['categoryListQuery'] != null
          ? List<CategoryListQuery>.from(
        json['categoryListQuery'].map((x) => CategoryListQuery.fromJson(x)),
      )
          : [],
    );
  }
}

class CategoryListQuery {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CategoryListQuery({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryListQuery.fromJson(Map<String, dynamic> json) {
    return CategoryListQuery(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


