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
      id: json['id'],
      title: json['title'],
      content: json['content'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  } 
}