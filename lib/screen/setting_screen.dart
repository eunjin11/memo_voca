import 'package:flutter/material.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
  }

  class _SettingScreenState extends State<SettingScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('테마 설정'),
            subtitle: Text('밝은 모드 또는 어두운 모드를 선택하세요.'),
            trailing: Switch(
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                });
                // Implement theme change functionality here
              },
            ),
            // onTap: () {
            //   // Navigate to theme settings page
            // },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('계정 정보'),
            subtitle: Text('로그인한 계정 정보를 확인하고 관리하세요.'),
            onTap: () {
              // Navigate to account information page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('북마크 초기화'),
            subtitle: Text('북마크한 단어의 기록을 초기화하세요.'),
            onTap: () {
              // Implement functionality to reset memorization records
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text('데이터 동기화'),
            subtitle: Text('클라우드와 로컬 데이터를 동기화하세요.'),
            onTap: () {
              // Implement functionality to sync data with cloud
            },
          ),
        ],
      ),
    );
  }
}

