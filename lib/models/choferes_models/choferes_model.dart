import '../../core/enums/choferes_status_enum.dart';

class ChoferesModel{
  final String choferId;
  final String choferNationalId;
  final dynamic averageCargoDeficit;
  final DateTime averageTimeDeficit;
  final ChoferesStatusEnum choferesStatusEnum;
  final double rating;
  final int numberOfTrips;
  final String firstName;
  final String lastName;
  final String rankingColor;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const ChoferesModel({
    required this.choferId,
    required this.choferNationalId,
    required this.averageCargoDeficit,
    required this.averageTimeDeficit,
    required this.rating,
    required this.numberOfTrips,
    required this.choferesStatusEnum,
    required this.firstName,
    required this.lastName,
    required this.rankingColor,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoferesModel &&
          runtimeType == other.runtimeType &&
          choferId == other.choferId &&
          choferesStatusEnum == other.choferesStatusEnum &&
          choferNationalId == other.choferNationalId &&
          averageCargoDeficit == other.averageCargoDeficit &&
          averageTimeDeficit == other.averageTimeDeficit &&
          rating == other.rating &&
          numberOfTrips == other.numberOfTrips &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          searchTags == other.searchTags &&
          rankingColor == other.rankingColor);

  @override
  int get hashCode =>
      choferId.hashCode ^
      choferNationalId.hashCode ^
      averageCargoDeficit.hashCode ^
      averageTimeDeficit.hashCode ^
      choferesStatusEnum.hashCode ^
      rating.hashCode ^
      numberOfTrips.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      searchTags.hashCode ^
      rankingColor.hashCode;

  @override
  String toString() {
    return 'ChoferesModel{' +
        ' choferId: $choferId,' +
        ' choferNationalId: $choferNationalId,' +
        ' averageCargoDeficit: $averageCargoDeficit,' +
        ' averageTimeDeficit: $averageTimeDeficit,' +
        ' choferesStatusEnum: $choferesStatusEnum,' +
        ' rating: $rating,' +
        ' numberOfTrips: $numberOfTrips,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' searchTags: $searchTags,' +
        ' rankingColor: $rankingColor,' +
        '}';
  }

  ChoferesModel copyWith({
    String? choferId,
    String? choferNationalId,
    double? averageCargoDeficit,
    DateTime? averageTimeDeficit,
    ChoferesStatusEnum? choferesStatusEnum,
    double? rating,
    int? numberOfTrips,
    String? firstName,
    String? lastName,
    String? rankingColor,
    Map<String, dynamic>? searchTags
  }) {
    return ChoferesModel(
      choferId: choferId ?? this.choferId,
      choferNationalId: choferNationalId ?? this.choferNationalId,
      choferesStatusEnum: choferesStatusEnum ?? this.choferesStatusEnum,
      averageCargoDeficit: averageCargoDeficit ?? this.averageCargoDeficit,
      averageTimeDeficit: averageTimeDeficit ?? this.averageTimeDeficit,
      rating: rating ?? this.rating,
      numberOfTrips: numberOfTrips ?? this.numberOfTrips,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rankingColor: rankingColor ?? this.rankingColor,
      searchTags: searchTags ?? this.searchTags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'choferId': this.choferId,
      'choferNationalId': this.choferNationalId,
      'averageCargoDeficit': this.averageCargoDeficit,
      'choferesStatusEnum': this.choferesStatusEnum.type,
      'averageTimeDeficit': this.averageTimeDeficit.millisecondsSinceEpoch,
      'rating': this.rating,
      'numberOfTrips': this.numberOfTrips,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'rankingColor': this.rankingColor,
      'searchTags': this.searchTags,
    };
  }

  factory ChoferesModel.fromMap(Map<String, dynamic> map) {
    return ChoferesModel(
      choferId: map['choferId'] as String,
      choferNationalId: map['choferNationalId'] as String,
      averageCargoDeficit: map['averageCargoDeficit'] as dynamic,
      choferesStatusEnum: (map['choferesStatusEnum'] as String).toChoferesStatusEnum(),
      averageTimeDeficit: DateTime.fromMillisecondsSinceEpoch(map['averageTimeDeficit']),
      rating: map['rating'] as double,
      numberOfTrips: map['numberOfTrips'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      rankingColor: map['rankingColor'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}