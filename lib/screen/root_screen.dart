import 'package:flutter/material.dart';
import 'package:memovoca/screen/wordlist_screen.dart';
import 'package:memovoca/screen/mywordlist_screen.dart';
import 'package:memovoca/screen/setting_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}


class _RootScreenState extends State<RootScreen> with
TickerProviderStateMixin{
  TabController? controller;
  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);  // ➋

    controller!.addListener(tabListener);
  }
  tabListener() {  // ➋ listener로 사용할 함수
    setState(() {});
  }
  @override
  dispose(){
    controller!.removeListener(tabListener); // ➌ listener에 등록한 함수 등록 취소
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단어 암기 앱'),
      ),
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),

      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren(){
    return [
      WordListScreen(),
      MyWordListScreen(),
      SettingScreen(),
    ];
  }

  BottomNavigationBar renderBottomNavigation(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: controller!.index,
      onTap: (int index) {  // ➎ 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Book',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}