class ToDoModel {
  String id;
  String title;
  String description;
  bool completed;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }


  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  @override
  String toString() {
    return 'ToDoModel{id: $id, title: $title, description: $description, '
        
        'completed: $completed}';
  }
}