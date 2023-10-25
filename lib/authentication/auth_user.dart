import 'package:cargocontrol/utils/form_validators/user_type.dart';
import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String? email;
  final String? userType;
  final bool emailVerified;

  const AuthUser({
    required this.id,
    this.email,
    this.userType,
    this.emailVerified = false,
  });

  static const empty = AuthUser(id: '');
  bool get isEmpty => this == AuthUser.empty;

  @override
  List<Object?> get props => [email, id, userType, emailVerified];
}
