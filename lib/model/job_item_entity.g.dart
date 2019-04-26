// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobItemEntity _$JobItemEntityFromJson(Map<String, dynamic> json) {
  return JobItemEntity(
      json['jobTitle'] as String,
      json['location'] as String,
      json['educationLevel'] as String,
      json['experienceYears'] as String,
      json['salaryFrom'] as int,
      json['salaryTo'] as int,
      json['publishedOn'] as String,
      json['companyId'] as String,
      json['companyName'] as String,
      json['companyType'] as String,
      json['companySize'] as String,
      json['statement'] as String,
      json['logoId'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$JobItemEntityToJson(JobItemEntity instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'location': instance.location,
      'educationLevel': instance.educationLevel,
      'experienceYears': instance.experienceYears,
      'salaryFrom': instance.salaryFrom,
      'salaryTo': instance.salaryTo,
      'publishedOn': instance.publishedOn,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'companyType': instance.companyType,
      'companySize': instance.companySize,
      'statement': instance.statement,
      'logoId': instance.logoId,
      'id': instance.id
    };
