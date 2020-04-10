// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid19.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Covid19 _$Covid19FromJson(Map<String, dynamic> json) {
  return Covid19(
    confirmed: json['confirmed'] as Map<String, dynamic>,
    recovered: json['recovered'] as Map<String, dynamic>,
    deaths: json['deaths'] as Map<String, dynamic>,
    lastUpdate: json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String),
  );
}

Map<String, dynamic> _$Covid19ToJson(Covid19 instance) => <String, dynamic>{
      'confirmed': instance.confirmed,
      'recovered': instance.recovered,
      'deaths': instance.deaths,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
    };
