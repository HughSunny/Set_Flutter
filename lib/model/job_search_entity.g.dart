// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSearchEntity _$JobSearchEntityFromJson(Map<String, dynamic> json) {
  return JobSearchEntity(json['jobTitle'] as String, json['id'] as String,
      json['companyId'] as String, json['companyName'] as String);
}

Map<String, dynamic> _$JobSearchEntityToJson(JobSearchEntity instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'id': instance.id,
      'companyId': instance.companyId,
      'companyName': instance.companyName
    };
