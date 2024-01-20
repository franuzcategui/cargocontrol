class NotificationModel{
  final String title;
  final String notificationId;
  final String description;
  final DateTime createdAt;
  final String screenName;

//<editor-fold desc="Data Methods">
  const NotificationModel({
    required this.title,
    required this.notificationId,
    required this.description,
    required this.createdAt,
    required this.screenName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          notificationId == other.notificationId &&
          description == other.description &&
          createdAt == other.createdAt &&
          screenName == other.screenName);

  @override
  int get hashCode =>
      title.hashCode ^
      notificationId.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      screenName.hashCode;

  @override
  String toString() {
    return 'NotificationModel{' +
        ' title: $title,' +
        ' notificationId: $notificationId,' +
        ' description: $description,' +
        ' createdAt: $createdAt,' +
        ' screenName: $screenName,' +
        '}';
  }

  NotificationModel copyWith({
    String? title,
    String? notificationId,
    String? description,
    DateTime? createdAt,
    String? screenName,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      notificationId: notificationId ?? this.notificationId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      screenName: screenName ?? this.screenName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'notificationId': this.notificationId,
      'description': this.description,
      'createdAt': this.createdAt.millisecondsSinceEpoch,
      'screenName': this.screenName,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      notificationId: map['notificationId'] as String,
      description: map['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']) ,
      screenName: map['screenName'] as String,
    );
  }

//</editor-fold>
}