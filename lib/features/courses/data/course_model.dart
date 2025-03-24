class CourseModel {
  final String name;
  final String desc;
  final String level;
  final String time;
  final String imageUrl;
  final String url;
  final String source;
  final String sourceLogo;
  final String type;
  final String reward;
  final List<String> skills;

  CourseModel({

    required this.name,
    required this.desc,
  required  this.level,required this.time, 
    required this.imageUrl,
    required this.url,
    required this.source,
    required this.sourceLogo,
    required this.type,
    required this.reward,
    required this.skills,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'],
      desc: map['desc'],
      level: map['level'],
      time: map['time'],
      imageUrl: map['imageUrl'],
      url: map['url'],
      source: map['source'],
      sourceLogo: map['sourceLogo'],
      type: map['type'],
      reward: map['reward'],
      skills: List<String>.from(map['skills']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desc': desc,
      'level':level,
      'time':time,
      'imageUrl': imageUrl,
      'url': url,
      'source': source,
      'sourceLogo': sourceLogo,
      'type': type,
      'reward': reward,
      'skills': skills,
    };
  }
}