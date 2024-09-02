import 'package:fit_med/widgets/customAppbar.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  static String routeName = "AddPost";
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: const CustomAppBar(title: "إضافة منشور"),
          ),
          drawer: Drawer(),
        ),
      ),
    );
  }
}
