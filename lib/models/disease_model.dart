import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/statics.dart';

class DiseaseModel {
  final int id;
  final String name;
  final String? details, causes, symptoms, prevention, type, treatment;
  final String? image;
  final MedicineModel? medicine;

  DiseaseModel(
      {required this.id,
      required this.name,
      this.type,
      this.details,
      this.causes,
      this.symptoms,
      this.prevention,
      this.treatment,
      this.image,
      this.medicine});

  factory DiseaseModel.loacal(DiseaseModel data) {
    return DiseaseModel(
      id: data.id,
      name: data.name,
      type: data.type,
      details: data.details,
      causes: data.causes,
      symptoms: data.symptoms,
      prevention: data.prevention,
      treatment: data.treatment,
      image: data.image,
      medicine: data.medicine,
    );
  }
  factory DiseaseModel.fromdata(data) {
    return DiseaseModel(
        id: data['id'],
        name: data['name'],
        type: data['type'],
        details: data['details'],
        causes: data['causes'],
        symptoms: data['symptoms'],
        prevention: data['prevention'],
        treatment: data['treatment'],
        image:
            data['image'] == null ? null : "http://$khostName${data['image']}",
        medicine: data['medicine']);
  }
}
