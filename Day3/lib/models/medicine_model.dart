import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

@JsonSerializable()
class MedicineModel {
  int? id;
  final String? name;
  final String? description;
  final double? dosage;
  final String? type;
  final List<String>? timeList;
  final List<String>? dateList;
  final int? status;

  MedicineModel({
    required this.id,
    required this.name,
    required this.description,
    required this.dosage,
    required this.type,
    required this.timeList,
    required this.dateList,
    required this.status,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => _$MedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          dosage == other.dosage &&
          type == other.type &&
          timeList == other.timeList &&
          dateList == other.dateList &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      dosage.hashCode ^
      type.hashCode ^
      timeList.hashCode ^
      dateList.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'MedicineModel{id: $id, name: $name, description: $description, dosage: $dosage, type: $type, timeList: $timeList, dateList: $dateList, status: $status}';
  }
}