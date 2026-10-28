import 'package:flutter/material.dart';
import 'pages/case1_profile_card.dart';
import 'pages/case2_alignment_scenarios.dart';
import 'pages/case3_flex_experiment.dart';
import 'pages/case4_stack_badge.dart';
import 'pages/case5_container_beautify.dart';
import 'pages/case6_constraint_lab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 实践指南六',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Case1ProfileCard(),
    Case2AlignmentScenarios(),
    Case3FlexExperiment(),
    Case4StackBadge(),
    Case5ContainerBeautify(),
    Case6ConstraintLab(),
  ];

  List<String> get _titles => const [
        '案例一：个人名片',
        '案例二：六种对齐',
        '案例三：弹性分配',
        '案例四：层叠角标',
        '案例五：容器美化',
        '案例六：约束实验',
      ];

  List<IconData> get _icons => const [
        Icons.person,
        Icons.horizontal_distribute,
        Icons.view_week,
        Icons.layers,
        Icons.card_giftcard,
        Icons.science,
      ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: List.generate(_titles.length, (i) {
          return NavigationDestination(
            icon: Icon(_icons[i]),
            label: '案例${i + 1}',
          );
        }),
      ),
    );
  }
}
