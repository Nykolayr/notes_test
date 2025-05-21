class Note {
  final int id;
  final String title;
  final String summary;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.summary,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Note copyWith({
    int? id,
    String? title,
    String? summary,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Note.initial() {
    return Note(
      id: -1,
      title: '',
      summary: '',
      createdAt: DateTime.now(),
    );
  }
}
