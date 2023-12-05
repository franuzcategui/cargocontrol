import '../../../../core/enums/account_type.dart';

class UserModel{
  final String uid;
  final String name;
  final String email;
  final AccountTypeEnum accountType;
  final DateTime createdAt;
  final String fcmToken;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.accountType,
    required this.createdAt,
    required this.fcmToken,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          accountType == other.accountType &&
          createdAt == other.createdAt &&
          fcmToken == other.fcmToken &&
          searchTags == other.searchTags);

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      accountType.hashCode ^
      createdAt.hashCode ^
      fcmToken.hashCode ^
      searchTags.hashCode;

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    AccountTypeEnum? accountType,
    DateTime? createdAt,
    String? fcmToken,
    Map<String, dynamic>? searchTags,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      fcmToken: fcmToken ?? this.fcmToken,
      searchTags: searchTags ?? this.searchTags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'accountType': accountType.type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'fcmToken': fcmToken,
      'searchTags': searchTags,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      accountType: (map['accountType'] as String).toAccountTypeEnum(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      fcmToken: map['fcmToken'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
    );
  }
}
