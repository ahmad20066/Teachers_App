class SubjectModel {
  final String id;
  final String subject_name;
  final String image;
  SubjectModel(
      {required this.id, required this.subject_name, required this.image});
  @override
  bool operator ==(Object other) => other is SubjectModel && other.id == id;
  @override
  int get hashCode => id.hashCode;
  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
      id: json['_id'],
      subject_name: json['subject_name'],
      image: json['image']);
  toJson() => {'subject_name': subject_name};
}
