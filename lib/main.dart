import 'package:flutter/material.dart';
import 'screens/amostra_view.dart';
import 'style.dart';

void main() {
  runApp(const MyApp());
}

const HomeRoute = '/';
const AmostraRoute = '/amostra';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Displasia CAD',
      onGenerateRoute: _routes(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(toolbarTextStyle: AppBarTextStyle),
        textTheme: TextTheme(
          headline1: TitleTextStyle,
          headline2: SubTitleTextStyle,
          bodyText1: Body1TextStyle,
          caption: CaptionTextStyle,
        ),
      ),
      home: const MyHomePage(title: 'Displasia CAD'),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      Widget screen;
      switch (settings.name) {
        case HomeRoute:
          screen = const MyHomePage(title: 'Displasia CAD');
          break;
        case AmostraRoute:
          screen = Amostra(arguments['color']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const Placeholder();
        break;
      case 1:
        page = Amostra(colorScheme.surfaceVariant);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.list_rounded),
                        label: 'Amostras',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list_rounded),
                        label: Text('Amostras'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
