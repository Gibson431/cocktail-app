import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/favourites.dart';
import 'pages/search.dart';
import 'pages/settings.dart';
import 'styles.dart';

// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  //  await Hive.openBox('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final settings = Hive.box('settings');

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = settings.get('darkMode', defaultValue: false);
    return MaterialApp(
      // initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Loading(),
        '/main': (context) => const Main(),
      },
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2);
  }

  static const List<Tab> _tabs = [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.search), text: 'Search'),
    Tab(icon: Icon(Icons.star), text: 'Favorites'),
    Tab(icon: Icon(Icons.settings), text: 'Settings'),
  ];

  static final List<Widget> _views = [
    const Home(),
    const Search(),
    const Favourites(),
    const Settings(),
  ];
  TabBar _tabBar(BuildContext context) => TabBar(
        labelColor: Theme.of(context).colorScheme.onPrimary,
        indicatorPadding: const EdgeInsets.all(5),
        indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)),
        tabs: _tabs,
        isScrollable: false,
        physics: const BouncingScrollPhysics(),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: _views,
        ),
        bottomNavigationBar: ColoredBox(
            color: Theme.of(context).colorScheme.primary,
            child: _tabBar(context)),
      ),
    );
  }
}
