import 'package:flutter/cupertino.dart';

class CupertinoSettingsPage extends StatefulWidget {
  const CupertinoSettingsPage({super.key});

  @override
  State<CupertinoSettingsPage> createState() => _CupertinoSettingsPageState();
}

class _CupertinoSettingsPageState extends State<CupertinoSettingsPage> {
  bool _chatBackup = false;

  DateTime _birthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Settings'),
            ),
            child: ListView(
              children: _builderSettingsChildren(context),
            ));
      },
    );
  }

  List<Widget> _builderSettingsChildren(BuildContext context) {
    return [
      // 绘制表单里面到单选按钮
      _buildChatBackup(),
      // 绘制样式单选项
      _builderChatWallpaper(context),
      // 绘制删除确认提示框
      _builderDeleteAccount(context),
      Center(
        child: CupertinoButton.filled(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ),
    ];
  }

  Center _builderDeleteAccount(BuildContext context) {
    return Center(
        child: CupertinoButton(
            child: const Text('Delete Account'),
            onPressed: () {
              showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text(
                              'Are you sure you want to delete your account?'),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                // do something
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            )
                          ]));
            }));
  }

  Center _builderChatWallpaper(BuildContext context) {
    return Center(
      child: CupertinoButton(
        child: const Text('Chat Wallpaper'),
        onPressed: () {
          showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Select Wallpaper Theme'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Dark'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Light'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]));
        },
      ),
    );
  }

  CupertinoFormSection _buildChatBackup() {
    return CupertinoFormSection(
        header: const Text('Account Details'),
        children: [
          CupertinoFormRow(
            prefix: const Text('Chat Backup'),
            child: CupertinoSwitch(
              value: _chatBackup,
              onChanged: (bool value) {
                setState(() {
                  _chatBackup = value;
                });
              },
            ),
          ),
          CupertinoFormRow(
            prefix: const Text('birthday'),
            child: CupertinoButton(
              onPressed: () => {
                _showDialog(CupertinoDatePicker(
                  backgroundColor: CupertinoColors.white,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  initialDateTime: _birthDate,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      _birthDate = newDateTime;
                    });
                    // Navigator.pop(context);
                  },
                ))
              },
              child: Text(
                '${_birthDate.year}-${_birthDate.month}-${_birthDate.day}',
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
          ),
        ]);
  }

  _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
