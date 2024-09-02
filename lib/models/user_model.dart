import 'package:fit_med/statics.dart';

enum UserType { vert, breeder }

abstract class UserModel {
  final UserType userType;
  final int id;
  final String name;
  final String? certificateImage,
      experienceCertificateImage,
      address,
      region,
      specialization,
      photo,
      mobile,
      email;
  final int? categoryId;
  UserModel(
      {required this.userType,
      required this.id,
      required this.name,
      this.certificateImage,
      this.experienceCertificateImage,
      this.address,
      this.region,
      this.specialization,
      this.photo,
      this.email,
      this.mobile,
      this.categoryId});
}

class VeterinaryModel extends UserModel {
  VeterinaryModel({
    super.userType = UserType.vert,
    required super.id,
    required super.name,
    super.certificateImage,
    super.experienceCertificateImage,
    super.address,
    super.specialization,
    super.photo,
    super.email,
  });

  factory VeterinaryModel.fromdata({data}) {
    return VeterinaryModel(
      id: data['id'],
      name: data['name'],
      certificateImage: data['certificate_image'] == null
          ? null
          : "http://$khostName/${data['certificate_image']}",
      experienceCertificateImage: data['experience_certificate_image'] == null
          ? null
          : "http://$khostName/${data['experience_certificate_image']}",
      address: data['address'],
      specialization: data['Specialization'],
      photo: data['photo'] == null ? null : "http://$khostName${data['photo']}",
      email: data['email'],
    );
  }

  factory VeterinaryModel.local({required VeterinaryModel data}) {
    return VeterinaryModel(
        id: data.id,
        name: data.name,
        certificateImage: data.certificateImage,
        experienceCertificateImage: data.experienceCertificateImage,
        address: data.address,
        specialization: data.specialization,
        photo: data.photo,
        email: data.email);
  }
}

class BreederModel extends UserModel {
  BreederModel(
      {super.userType = UserType.breeder,
      required super.id,
      required super.name,
      super.region,
      super.mobile,
      super.categoryId});

  factory BreederModel.fromdata({data}) {
    return BreederModel(
        id: data['id'],
        name: data['name'],
        region: data['region'],
        mobile: data['mobile'],
        categoryId: data['category_id']);
  }

  factory BreederModel.local({required BreederModel data}) {
    return BreederModel(
        id: data.id,
        name: data.name,
        region: data.region,
        mobile: data.mobile,
        categoryId: data.categoryId);
  }
}
