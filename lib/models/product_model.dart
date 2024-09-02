import 'package:fit_med/statics.dart';

enum ProductType { medicine, food }

abstract class ProductModel {
  final int id;
  final ProductType productType;
  final String name;
  final String? category, type, usage, composition;
  final String? img;
  final double? price;
  final DateTime? expirationDate;
  double count;

  ProductModel(
      {required this.id,
      required this.name,
      this.count = 1,
      this.category,
      this.type,
      this.usage,
      this.composition,
      this.img,
      this.price,
      this.expirationDate,
      required this.productType});
}

class MedicineModel extends ProductModel {
  MedicineModel(
      {super.productType = ProductType.medicine,
      required super.id,
      required super.name,
      super.category,
      super.type,
      super.usage,
      super.composition,
      super.expirationDate,
      super.img,
      super.price,
      super.count});

  factory MedicineModel.fromdata({data}) {
    return MedicineModel(
        productType: ProductType.medicine,
        id: data['id'],
        name: data['name'],
        img: data['image'] == null ? null : "http://$khostName${data['image']}",
        expirationDate: data['expiration_date'],
        category: data['category'],
        type: data['type_of_medicine'],
        price: data['price'] == null ? null : double.parse(data['price']),
        usage: data['usage'],
        composition: data['Composition'],
        count: data['count'] ?? 1);
  }

  factory MedicineModel.local({required MedicineModel data}) {
    return MedicineModel(
        name: data.name,
        id: data.id,
        category: data.category,
        type: data.type,
        usage: data.usage,
        composition: data.composition,
        expirationDate: data.expirationDate,
        img: data.img,
        price: data.price,
        count: data.count);
  }
}

class FoodModel extends ProductModel {
  FoodModel(
      {super.productType = ProductType.food,
      required super.id,
      required super.name,
      super.category,
      super.usage,
      super.composition,
      super.expirationDate,
      super.img,
      super.count,
      super.price});

  factory FoodModel.fromdata({data}) {
    return FoodModel(
        productType: ProductType.food,
        id: data['id'],
        name: data['name'],
        category: data['category'],
        usage: data['usage'],
        composition: data['composition'],
        expirationDate: data['expirationDate'],
        img: data['image'] == null ? null : "http://$khostName${data['image']}",
        price: data['price'] == null ? null : double.parse(data['price']),
        count: data['count'] ?? 1);
  }

  factory FoodModel.local({required FoodModel data}) {
    return FoodModel(
        id: data.id,
        name: data.name,
        category: data.category,
        usage: data.usage,
        composition: data.composition,
        expirationDate: data.expirationDate,
        img: data.img,
        price: data.price,
        count: data.count);
  }
}
