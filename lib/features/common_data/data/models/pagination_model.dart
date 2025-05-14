class PaginationModel {
  bool? hasMorePages;
  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;
  String? path;

  PaginationModel({
    this.hasMorePages,
    this.total,
    this.lastPage,
    this.perPage,
    this.currentPage,
    this.path,
  });

  @override
  String toString() {
    return 'PaginationModel(hasMorePages: $hasMorePages, total: $total, lastPage: $lastPage, perPage: $perPage, currentPage: $currentPage, path: $path)';
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      hasMorePages: json['hasMorePages'] as bool?,
      total: json['total'] as int?,
      lastPage: json['last_page'] as int?,
      perPage: json['per_page'] as int?,
      currentPage: json['current_page'] as int?,
      path: json['path'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'hasMorePages': hasMorePages,
        'total': total,
        'last_page': lastPage,
        'per_page': perPage,
        'current_page': currentPage,
        'path': path,
      };
}
