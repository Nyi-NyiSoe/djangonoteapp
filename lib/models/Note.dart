class Note{
  final int id;
  final String title;
  final String content;
  final DateTime created;
  final DateTime updated;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.created,
    required this.updated,
  });

factory Note.fromJson(Map<String, dynamic> json){
  return Note(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    content: json['content'] ?? '',
    created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
    updated: json['updated'] != null ? DateTime.parse(json['updated']) : DateTime.now(),
  );
}
}