import 'package:json_annotation/json_annotation.dart';

part 'job_item_entity.g.dart';


@JsonSerializable()
class JobItemEntity extends Object {

  @JsonKey(name: 'jobTitle')
  String jobTitle;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'educationLevel')
  String educationLevel;

  @JsonKey(name: 'experienceYears')
  String experienceYears;

  @JsonKey(name: 'salaryFrom')
  int salaryFrom;

  @JsonKey(name: 'salaryTo')
  int salaryTo;

  @JsonKey(name: 'publishedOn')
  String publishedOn;

  @JsonKey(name: 'companyId')
  String companyId;

  @JsonKey(name: 'companyName')
  String companyName;

  @JsonKey(name: 'companyType')
  String companyType;

  @JsonKey(name: 'companySize')
  String companySize;

  @JsonKey(name: 'statement')
  String statement;

  @JsonKey(name: 'logoId')
  String logoId;

  @JsonKey(name: 'id')
  String id;

  JobItemEntity(this.jobTitle,this.location,this.educationLevel,this.experienceYears,this.salaryFrom,this.salaryTo,this.publishedOn,this.companyId,this.companyName,this.companyType,this.companySize,this.statement,this.logoId,this.id,);

  factory JobItemEntity.fromJson(Map<String, dynamic> srcJson) => _$JobItemEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$JobItemEntityToJson(this);

}
