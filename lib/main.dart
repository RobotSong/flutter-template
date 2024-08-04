import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:share/chats.dart';
import 'package:share/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // runApp(const MyApp());
  const app = MyApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(app));

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoSimpleHomePage(),
      localizationsDelegates: [
        // 国际化配置，会自动在 ${FLUTTER_PROJECT}/.dart_tool/flutter_gen/gen_l10n. 文件
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh'),
        Locale('en'),
      ],
    );
  }
}

class CupertinoSimpleHomePage extends StatefulWidget {
  const CupertinoSimpleHomePage({super.key});

  @override
  _CupertinoSimpleHomePageState createState() =>
      _CupertinoSimpleHomePageState();
}

class _CupertinoSimpleHomePageState extends State<CupertinoSimpleHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          currentIndex: 1,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone), label: 'Calls'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble), label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings'),
          ]),
      tabBuilder: (BuildContext context, int index) {
        late final Widget result;
        switch (index) {
          case 0:
            result = CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Calls'),
                  ),
                  child: Center(
                    child: Text('Calls'),
                  ),
                );
              },
            );
            break;
          case 1:
            result = const CupertinoChatsPage();
            break;
          case 2:
            result = const CupertinoSettingsPage();
            break;
        }
        return result;
      },
    );
  }
}
