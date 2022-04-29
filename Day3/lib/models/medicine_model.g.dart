// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineModel _$MedicineModelFromJson(Map<String, dynamic> json) =>
    MedicineModel(
      id: json['id'] as int?,
      name: json['drugName'] as String?,
      description: json['drugDescription'] as String?,
      dosage: (json['drugDosage'] as num?)?.toDouble(),
      type: json['drugType'] as String?,
      timeList: (json['scheduledTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateList: (json['scheduledDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as int
    );

Map<String, dynamic> _$MedicineModelToJson(MedicineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drugName': instance.name,
      'drugDescription': instance.description,
      'drugDosage': instance.dosage,
      'drugType': instance.type,
      'scheduledTimes': instance.timeList,
      'scheduledDays': instance.dateList,
      'status' : instance.status,
    };
