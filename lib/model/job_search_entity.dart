import 'package:json_annotation/json_annotation.dart';

part 'job_search_entity.g.dart';


@JsonSerializable()
class JobSearchEntity extends Object {

  @JsonKey(name: 'jobTitle')
  String jobTitle;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'companyId')
  String companyId;

  @JsonKey(name: 'companyName')
  String companyName;

  JobSearchEntity(this.jobTitle,this.id,this.companyId,this.companyName,);

  factory JobSearchEntity.fromJson(Map<String, dynamic> srcJson) => _$JobSearchEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$JobSearchEntityToJson(this);

}
