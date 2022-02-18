class Todos {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });


  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
