class ActivityModel {
  String id;
  final String title;
  final String date;

  ActivityModel({
    this.id = '',
    required this.title,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
      };
  static ActivityModel fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'],
        title: json['title'],
        date: json['date'],
      );
}
