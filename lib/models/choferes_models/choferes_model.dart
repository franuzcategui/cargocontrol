import '../../core/enums/choferes_status_enum.dart';

class ChoferesModel {
  final String choferId;
  final String choferNationalId;
  final dynamic averageCargoDeficit;
  final dynamic averageCargoDeficitPercentage;
  final dynamic worstCargoDeficit;
  final dynamic worstCargoDeficitPercentage;
  final ChoferesStatusEnum choferesStatusEnum;
  final double rating;
  final int numberOfTrips;
  final String firstName;
  final String lastName;
  final String rankingColor;
  final Map<String, dynamic> searchTags;
  final DateTime createdAt;
  final Duration averageTimeDeficit;
  final Duration worstTimeDeficit;

//<editor-fold desc="Data Methods">
  const ChoferesModel({
    required this.choferId,
    required this.choferNationalId,
    required this.averageCargoDeficit,
    required this.averageCargoDeficitPercentage,
    required this.worstCargoDeficit,
    required this.worstCargoDeficitPercentage,
    required this.choferesStatusEnum,
    required this.rating,
    required this.numberOfTrips,
    required this.firstName,
    required this.lastName,
    required this.rankingColor,
    required this.searchTags,
    required this.createdAt,
    required this.averageTimeDeficit,
    required this.worstTimeDeficit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoferesModel &&
          runtimeType == other.runtimeType &&
          choferId == other.choferId &&
          choferNationalId == other.choferNationalId &&
          averageCargoDeficit == other.averageCargoDeficit &&
          averageCargoDeficitPercentage ==
              other.averageCargoDeficitPercentage &&
          worstCargoDeficit == other.worstCargoDeficit &&
          worstCargoDeficitPercentage == other.worstCargoDeficitPercentage &&
          choferesStatusEnum == other.choferesStatusEnum &&
          rating == other.rating &&
          numberOfTrips == other.numberOfTrips &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          rankingColor == other.rankingColor &&
          searchTags == other.searchTags &&
          createdAt == other.createdAt &&
          averageTimeDeficit == other.averageTimeDeficit &&
          worstTimeDeficit == other.worstTimeDeficit);

  @override
  int get hashCode =>
      choferId.hashCode ^
      choferNationalId.hashCode ^
      averageCargoDeficit.hashCode ^
      averageCargoDeficitPercentage.hashCode ^
      worstCargoDeficit.hashCode ^
      worstCargoDeficitPercentage.hashCode ^
      choferesStatusEnum.hashCode ^
      rating.hashCode ^
      numberOfTrips.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      rankingColor.hashCode ^
      searchTags.hashCode ^
      createdAt.hashCode ^
      averageTimeDeficit.hashCode ^
      worstTimeDeficit.hashCode;

  @override
  String toString() {
    return 'ChoferesModel{' +
        ' choferId: $choferId,' +
        ' choferNationalId: $choferNationalId,' +
        ' averageCargoDeficit: $averageCargoDeficit,' +
        ' averageCargoDeficitPercentage: $averageCargoDeficitPercentage,' +
        ' worstCargoDeficit: $worstCargoDeficit,' +
        ' worstCargoDeficitPercentage: $worstCargoDeficitPercentage,' +
        ' choferesStatusEnum: $choferesStatusEnum,' +
        ' rating: $rating,' +
        ' numberOfTrips: $numberOfTrips,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' rankingColor: $rankingColor,' +
        ' searchTags: $searchTags,' +
        ' createdAt: $createdAt,' +
        ' averageTimeDeficit: $averageTimeDeficit,' +
        ' worstTimeDeficit: $worstTimeDeficit,' +
        '}';
  }

  ChoferesModel copyWith({
    String? choferId,
    String? choferNationalId,
    dynamic? averageCargoDeficit,
    dynamic? averageCargoDeficitPercentage,
    dynamic? worstCargoDeficit,
    dynamic? worstCargoDeficitPercentage,
    ChoferesStatusEnum? choferesStatusEnum,
    double? rating,
    int? numberOfTrips,
    String? firstName,
    String? lastName,
    String? rankingColor,
    Map<String, dynamic>? searchTags,
    DateTime? createdAt,
    Duration? averageTimeDeficit,
    Duration? worstTimeDeficit,
  }) {
    return ChoferesModel(
      choferId: choferId ?? this.choferId,
      choferNationalId: choferNationalId ?? this.choferNationalId,
      averageCargoDeficit: averageCargoDeficit ?? this.averageCargoDeficit,
      averageCargoDeficitPercentage:
          averageCargoDeficitPercentage ?? this.averageCargoDeficitPercentage,
      worstCargoDeficit: worstCargoDeficit ?? this.worstCargoDeficit,
      worstCargoDeficitPercentage:
          worstCargoDeficitPercentage ?? this.worstCargoDeficitPercentage,
      choferesStatusEnum: choferesStatusEnum ?? this.choferesStatusEnum,
      rating: rating ?? this.rating,
      numberOfTrips: numberOfTrips ?? this.numberOfTrips,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rankingColor: rankingColor ?? this.rankingColor,
      searchTags: searchTags ?? this.searchTags,
      createdAt: createdAt ?? this.createdAt,
      averageTimeDeficit: averageTimeDeficit ?? this.averageTimeDeficit,
      worstTimeDeficit: worstTimeDeficit ?? this.worstTimeDeficit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'choferId': this.choferId,
      'choferNationalId': this.choferNationalId,
      'averageCargoDeficit': this.averageCargoDeficit,
      'averageCargoDeficitPercentage': this.averageCargoDeficitPercentage,
      'worstCargoDeficit': this.worstCargoDeficit,
      'worstCargoDeficitPercentage': this.worstCargoDeficitPercentage,
      'choferesStatusEnum': this.choferesStatusEnum.type,
      'rating': this.rating,
      'numberOfTrips': this.numberOfTrips,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'rankingColor': this.rankingColor,
      'searchTags': this.searchTags,
      'createdAt': this.createdAt.millisecondsSinceEpoch,
      'averageTimeDeficit': this.averageTimeDeficit.inMilliseconds,
      'worstTimeDeficit': this.worstTimeDeficit.inMilliseconds,
    };
  }

  factory ChoferesModel.fromMap(Map<String, dynamic> map) {
    return ChoferesModel(
      choferId: map['choferId'] as String,
      choferNationalId: map['choferNationalId'] as String,
      averageCargoDeficit: map['averageCargoDeficit'] as dynamic,
      averageCargoDeficitPercentage:
          map['averageCargoDeficitPercentage'] as dynamic,
      worstCargoDeficit: map['worstCargoDeficit'] as dynamic,
      worstCargoDeficitPercentage:
          map['worstCargoDeficitPercentage'] as dynamic,
      choferesStatusEnum:
      (map['choferesStatusEnum'] as String).toChoferesStatusEnum(),
      rating: map['rating'] as double,
      numberOfTrips: map['numberOfTrips'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      rankingColor: map['rankingColor'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      averageTimeDeficit: Duration(milliseconds: map['averageTimeDeficit']),
      worstTimeDeficit: Duration(milliseconds: map['worstTimeDeficit']),
    );
  }

//</editor-fold>
}

/*



  Map<String, dynamic> toMap() {
    return {
      'choferId': this.choferId,
      'choferNationalId': this.choferNationalId,
      'averageCargoDeficit': this.averageCargoDeficit,
      'worstCargoDeficit': this.worstCargoDeficit,
      'choferesStatusEnum': this.choferesStatusEnum.type,
      'rating': this.rating,
      'numberOfTrips': this.numberOfTrips,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'rankingColor': this.rankingColor,
      'searchTags': this.searchTags,
      'createdAt': this.createdAt.millisecondsSinceEpoch,
      'averageTimeDeficit': this.averageTimeDeficit.inMilliseconds,
      'worstTimeDeficit': this.worstTimeDeficit.inMilliseconds,
    };
  }

  factory ChoferesModel.fromMap(Map<String, dynamic> map) {
    return ChoferesModel(
      choferId: map['choferId'] as String,
      choferNationalId: map['choferNationalId'] as String,
      averageCargoDeficit: map['averageCargoDeficit'] as dynamic,
      worstCargoDeficit: map['worstCargoDeficit'] as dynamic,
      choferesStatusEnum:
          (map['choferesStatusEnum'] as String).toChoferesStatusEnum(),
      rating: map['rating'] as double,
      numberOfTrips: map['numberOfTrips'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      rankingColor: map['rankingColor'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      averageTimeDeficit: Duration(milliseconds: map['averageTimeDeficit']),
      worstTimeDeficit: Duration(milliseconds: map['worstTimeDeficit']),
    );
  }


 */
