import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class User {
  final String name;

  final Color color;

  User(this.name, this.color);

  @override
  String toString() {
    return 'User{name: $name, color: $color}';
  }
}

final List<User> _users = [
  User('Anan', CupertinoColors.systemBlue),
  User('Boxes', CupertinoColors.systemPink),
  User('Jim', CupertinoColors.systemGreen),
  User('Calls', CupertinoColors.systemPurple),
  User('Joe', CupertinoColors.systemBlue),
  User('Henry', CupertinoColors.systemPink),
  User('Jim', CupertinoColors.systemGreen),
];


class CupertinoChatsPage extends StatefulWidget {
  const CupertinoChatsPage({super.key});

  @override
  State<CupertinoChatsPage> createState() =>
      _CupertinoChatsPageState();
}

class _CupertinoChatsPageState extends State<CupertinoChatsPage> {

  bool _isNetwork = false;

  List<User> _filterUsers = _users;

  // text field controller for search
  // 响应式文本组建变动控制器
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _changeLoading();
    return CupertinoTabView(
      builder: (context) {
        debugPrint('phone have Network: $_isNetwork');
        final slivers = List<Widget>.empty(growable: true);
        if (!_isNetwork) {
          slivers.add(CupertinoSliverNavigationBar(
            largeTitle: Text(AppLocalizations.of(context)!.chat),
            leading: Text(
              'Edit',
              style: TextStyle(color: CupertinoColors.link),
            ),
            middle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(
                  width: 8,
                ),
                Text('Waiting for network...')
              ],
            ),
          ));
        } else {
          slivers.add(CupertinoSliverNavigationBar(
            largeTitle: Text(AppLocalizations.of(context)!.chat),
          ));
        }
        slivers.add(SliverToBoxAdapter(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ClipRect(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CupertinoSearchTextField(
                  controller: _controller,
                  onChanged: (value) {
                    _updateUserList(value);
                  },
                  onSubmitted: (value) {
                    _updateUserList(value);
                  },
                  onSuffixTap: () {
                    _updateUserList('');
                  },
                ),
              ),
            ),
          ),
        ));

        slivers.add(CupertinoUserPage(_filterUsers));
        return CustomScrollView(
          slivers: slivers,
        );
      },
    );
  }

  void _updateUserList(String value) {
    debugPrint(value);
    if (value.isEmpty) {
      setState(() {
        _filterUsers = _users;
      });
      _controller.text = '';
      return;
    }

    setState(() {
      _filterUsers = _users
          .where(
              (user) => user.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
  // wait timeout change loading status
  void _changeLoading() async {
    if (_isNetwork) {
      return;
    }

    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _isNetwork = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CupertinoUserPage extends StatelessWidget {
  final List<User> _filteredUsers;

  const CupertinoUserPage(this._filteredUsers, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _userTile(_filteredUsers[index]);
          },
          childCount: _filteredUsers.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5.0,
        ));
  }

  Widget _userTile(User user) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Icon(
          CupertinoIcons.circle_filled,
          color: user.color,
          size: 60,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          user.name,
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
