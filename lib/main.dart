import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/controllers/chatItems_provider.dart';
import 'package:fit_med/controllers/audiorecorder_provider.dart';
import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/controllers/dropdown_provider.dart';
import 'package:fit_med/controllers/textformfield_provider.dart';
import 'package:fit_med/controllers/pickImage_provider.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/views/addpost.dart';
import 'package:fit_med/views/cart.dart';
import 'package:fit_med/views/chats/basiclayout_chats.dart';
import 'package:fit_med/views/chatting.dart';
import 'package:fit_med/views/diseases.dart';
import 'package:fit_med/views/doctors.dart';
import 'package:fit_med/views/feed.dart';
import 'package:fit_med/views/homepage.dart';
import 'package:fit_med/views/interface.dart';
import 'package:fit_med/views/medicin.dart';
import 'package:fit_med/views/search.dart';
import 'package:fit_med/views/showDisease.dart';
import 'package:fit_med/views/showproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarItemProvider>(
            create: (context) => BottomBarItemProvider()),
        ChangeNotifierProvider<ChooseLocationProvider>(
            create: (context) => ChooseLocationProvider()),
        ChangeNotifierProvider<BottombarChatsITemProvider>(
            create: (context) => BottombarChatsITemProvider()),
        ChangeNotifierProvider<CartItemsProvider>(
            create: (context) => CartItemsProvider()),
        ChangeNotifierProvider<CounterProvider>(
            create: (context) => CounterProvider()),
        ChangeNotifierProvider<ChatItemsProvider>(
            create: (context) => ChatItemsProvider()),
        ChangeNotifierProvider<PickimageProvider>(
            create: (context) => PickimageProvider()),
        ChangeNotifierProvider<TFMProvider>(create: (context) => TFMProvider()),
        ChangeNotifierProvider<ARProvider>(create: (context) => ARProvider()),
        ChangeNotifierProvider<ShowMoreProvider>(
            create: (context) => ShowMoreProvider()),
        ChangeNotifierProvider<ChooseTypeofKProvider>(
            create: (context) => ChooseTypeofKProvider()),
        ChangeNotifierProvider<CompleteSaleProvider>(
            create: (context) => CompleteSaleProvider()),
      ],
      child: FitMed(),
    ),
  );
}

class FitMed extends StatelessWidget {
  const FitMed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.selectedTheme,
      initialRoute: InterFace.routeName,
      routes: {
        InterFace.routeName: (context) => const InterFace(),
        HomePage.routeName: (context) => const HomePage(),
        Veters.routeName: (context) => const Veters(),
        Medicine.routeName: (context) => const Medicine(),
        const ShowMedicine().routeName: (context) => const ShowMedicine(),
        const ShowFood().routeName: (context) => const ShowFood(),
        Showdisease.routeName: (context) => const Showdisease(),
        BasiclayoutChats.routeName: (context) => const BasiclayoutChats(),
        AddPost.routeName: (context) => const AddPost(),
        Search.routeName: (context) => const Search(),
        Cart.routeName: (context) => const Cart(),
        Diseases.routeName: (context) => const Diseases(),
        Chatting.routeName: (context) => const Chatting(),
        Feed.routeName: (context) => const Feed()
      },
    );
  }
}
