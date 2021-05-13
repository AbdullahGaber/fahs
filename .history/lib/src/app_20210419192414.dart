import 'dart:async';
import 'package:fahs/src/screens/mainScreens/home_screen.dart';
import 'package:fahs/src/screens/profile/profile_screen.dart';
import 'package:fahs/src/screens/user/order/my_orders_screen.dart';
import 'package:fahs/src/screens/user/order/order_details_screen.dart';
import 'package:fahs/src/screens/user/providers/provider_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './logic/providers/auth/logout_provider.dart';
import './logic/providers/auth/phone_verfication_provider.dart';
import './logic/providers/auth/resend_code_provider.dart';
import './logic/providers/auth/reset_password_phone_provider.dart';
import './logic/providers/auth/reset_password_provider.dart';
import './logic/providers/auth/reset_password_verfication_provider.dart';
import './logic/providers/auth/signup_provider.dart';
import './logic/providers/changeData/change_password_provider.dart';
import './logic/providers/changeData/change_phone_provider.dart';
import './logic/providers/changeData/change_phone_verfication_provider.dart';
import './logic/providers/changeData/change_user_data_provider.dart';
import './logic/providers/chat/my_conversations_provider.dart';
import './logic/providers/chat/create_chat_provider.dart';
import './logic/providers/general/about_us_provider.dart';
import './logic/providers/general/cities_provider.dart';
import './logic/providers/general/complaints_provider.dart';
import './logic/providers/general/histories_provider.dart';
import './logic/providers/general/product_by_id_provider.dart';
import './logic/providers/general/search_provider.dart';
import './logic/providers/general/splash_provider.dart';
import './logic/providers/general/notifications/notifications_provider.dart';
import './logic/providers/general/regions_provider.dart';
import './logic/providers/general/settings_provider.dart';
import './logic/providers/general/terms_provider.dart';
import './logic/providers/general/user_by_id_provider.dart';
import './logic/providers/provider/order/commissions_provider.dart';
import './logic/providers/user/favorites/my_favourites_products.dart';
import './logic/providers/user/favorites/my_favourites_providers.dart';
import './logic/providers/user/order/post_order_provider.dart';
import './logic/providers/provider/products/products_provider.dart';
import './logic/providers/provider/property_provider.dart';
import './logic/providers/user/order/my_orders_provider.dart';
import './screens/mainScreens/splash_screen.dart';
import './logic/providers/auth/login_provider.dart';
import './logic/providers/auth/mobile_register_provider.dart';
import './logic/providers/general/shared_preferences_provider.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer timer;
  UserByIdProvider userByIdProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (widget.prefs.get('type') == 'مزود خدمة') {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // auth Provider
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LogoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MobileRegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PhoneVerficationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResendCodeProvider(),
        ),

        //....

        //reset password
        ChangeNotifierProvider(
          create: (_) => ResetPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordPhoneProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordVerficationProvider(),
        ),
        //...

        // change Data..
        ChangeNotifierProvider(
          create: (_) => ChangePhoneProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChangePhoneVerficationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChangePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChangeUserDataProvider(),
        ),
        //...
        // chat
        ChangeNotifierProvider(
          create: (_) => MyConversationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateChatProvider(),
        ),
        //...

        // main Providers...
        ChangeNotifierProvider(
          create: (_) => SharedPreferencesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductByIdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegionsProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ComplaintsProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CitiesProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => TermsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AboutUsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => HistoriesProvider(),
        ),
        //...

        // provider

        ChangeNotifierProvider(
          create: (_) => PropertyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CommissionsProvider(),
        ),
        // ...

        // user
        ChangeNotifierProvider(
          create: (_) => PostOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyOrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyFavouriteProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyFavouriteProvider(),
        ),
        //...
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "فحص السيارات",
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Color(0xff98D651),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OrderDetailsScreen(),
        // home: Splash(
        //   isLoggedIn: widget.prefs.containsKey('token'),
        //   prefs: widget.prefs,
        // ),
      ),
    );
  }
}
