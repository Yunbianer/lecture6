import 'package:flutter/material.dart';

/// 案例二：六种对齐场景逐一实现
/// 主/交叉轴对齐组合实验
class Case2AlignmentScenarios extends StatelessWidget {
  const Case2AlignmentScenarios({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _scenario(
          title: '场景1：mainAxis = center, crossAxis = center',
          subtitle: '水平居中 + 垂直居中',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        _scenario(
          title: '场景2：mainAxis = spaceBetween',
          subtitle: '两端对齐，首尾贴边',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        _scenario(
          title: '场景3：mainAxis = spaceAround',
          subtitle: '每个元素两侧等距',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        _scenario(
          title: '场景4：mainAxis = start, crossAxis = start',
          subtitle: '左上角对齐',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        _scenario(
          title: '场景5：mainAxis = end, crossAxis = end',
          subtitle: '右下角对齐',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
        _scenario(
          title: '场景6：mainAxis = center, crossAxis = stretch',
          subtitle: '交叉轴拉伸撑满（子项高度自适应容器）',
          scenario: _Scenario(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ],
    );
  }

  Widget _scenario({
    required String title,
    required String subtitle,
    required _Scenario scenario,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 10),
          // Row 演示区
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.blueGrey.shade50,
            child: Row(
              mainAxisAlignment: scenario.mainAxisAlignment,
              crossAxisAlignment: scenario.crossAxisAlignment,
              children: [
                _box(color: Colors.redAccent, label: 'A', height: 30),
                _box(color: Colors.greenAccent, label: 'BB', height: 50),
                _box(color: Colors.orangeAccent, label: 'CCC', height: 40),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text('↕ 上面是 Row（水平主轴）', style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 6),
          // Column 演示区（翻转视角）
          SizedBox(
            height: 180,
            child: Row(
              children: [
                const RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    '下面是 Column（垂直主轴）→',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    color: Colors.amber.shade50,
                    child: Column(
                      mainAxisAlignment: scenario.mainAxisAlignment,
                      crossAxisAlignment: scenario.crossAxisAlignment,
                      children: [
                        _box(color: Colors.redAccent, label: 'A', height: 24, horizontal: true),
                        _box(color: Colors.greenAccent, label: 'BB', height: 36, horizontal: true),
                        _box(color: Colors.orangeAccent, label: 'CCC', height: 30, horizontal: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _box({
    required Color color,
    required String label,
    required double height,
    bool horizontal = false,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: color,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

class _Scenario {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const _Scenario({required this.mainAxisAlignment, required this.crossAxisAlignment});
}
