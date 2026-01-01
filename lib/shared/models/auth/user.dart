import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User{
  const factory User({
    required String id,
    required String nickname,
    required String birthYear,
    required int gender,
    required String createdAt,
    required String updatedAt,
    @Default('ko-KR') String locale,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}

/// 앱에서 쓰는 성별 Enum
enum Gender {
  female,
  male,
  other,
}
