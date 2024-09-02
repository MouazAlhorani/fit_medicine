import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/statics.dart';

class GroupModel {
  final int id;
  final List<UserModel> members;
  final String? groupname;
  final String? groupprofile;

  GroupModel({
    required this.id,
    required this.groupname,
    this.groupprofile,
    this.members = const [],
  });
  factory GroupModel.fromdata({data}) {
    return GroupModel(
        id: data['id'],
        groupname: data['name'],
        groupprofile:
            data['image'] == null ? null : "http://$khostName/${data['image']}",
        members: data['members']);
  }
}
