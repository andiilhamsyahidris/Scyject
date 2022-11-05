class ActivityModel {
  String id;
  final String title;
  final String date;
  bool value;

  ActivityModel({
    this.id = '',
    required this.title,
    required this.date,
    this.value = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'value': value,
      };
  static ActivityModel fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'],
        title: json['title'],
        date: json['date'],
        value: json['value'],
      );
}
