import 'package:flutter/material.dart';

/// 案例六：约束传递实验
/// "撑不满"与"溢出"两大高频现象复现 + 修复
class Case6ConstraintLab extends StatelessWidget {
  const Case6ConstraintLab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // 约束三句话
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.blue),
                  SizedBox(width: 6),
                  Text('Flutter 布局三句话', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '1️⃣ 父组件把约束（最大/最小宽高）传给子组件\n'
                '2️⃣ 子组件在约束内报告自己的尺寸\n'
                '3️⃣ 父组件决定子组件位置',
                style: TextStyle(fontSize: 12, height: 1.8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 实验1：撑不满（松约束 + 子按内容尺寸）
        _experiment(
          title: '实验1：为什么"撑不满"？',
          cause: 'Center / Column 等父给的是松约束（0 ≤ w ≤ maxWidth），子按自身内容尺寸报告',
          bad: Center(
            child: Container(
              color: Colors.redAccent.shade100,
              height: 40,
              alignment: Alignment.center,
              child: const Text('Container 只按内容大小'),
            ),
          ),
          good: Center(
            child: Container(
              width: double.infinity, // ← 关键：明确要撑满
              color: Colors.greenAccent.shade100,
              height: 40,
              alignment: Alignment.center,
              child: const Text('width: double.infinity 撑满了'),
            ),
          ),
          fix: '✅ 修复：width: double.infinity 或用 Expanded / SizedBox.expand',
        ),

        // 实验2：溢出（Column 里 ListView + 固定元素）
        const SizedBox(height: 16),
        _experiment(
          title: '实验2：为什么"溢出"？（RenderFlex 黄黑警告）',
          cause: 'Column 是紧约束（高度=屏幕），内部 ListView 想无限展开 → 超限',
          bad: SizedBox(
            height: 200,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue.shade200,
                  alignment: Alignment.center,
                  child: const Text('固定高度 Header'),
                ),
                // ❌ 没有 Expanded —— ListView 不知道能占多少
                ListView(
                  children: List.generate(10, (i) => ListTile(title: Text('项目 $i'))),
                ),
                Container(
                  height: 40,
                  color: Colors.orange.shade200,
                  alignment: Alignment.center,
                  child: const Text('固定高度 Footer'),
                ),
              ],
            ),
          ),
          good: SizedBox(
            height: 200,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue.shade200,
                  alignment: Alignment.center,
                  child: const Text('固定高度 Header'),
                ),
                // ✅ Expanded 吃掉剩余高度
                Expanded(
                  child: ListView(
                    children: List.generate(10, (i) => ListTile(title: Text('项目 $i'))),
                  ),
                ),
                Container(
                  height: 40,
                  color: Colors.orange.shade200,
                  alignment: Alignment.center,
                  child: const Text('固定高度 Footer'),
                ),
              ],
            ),
          ),
          fix: '✅ 修复：ListView 外包 Expanded 或 Flexible',
        ),

        // 实验3：Row 里单个子项超长挤爆邻居
        const SizedBox(height: 16),
        _experiment(
          title: '实验3：Row 里 Text 太长挤爆邻居',
          cause: 'Row 给子项的是松约束（可以无限宽），长文本无限扩张',
          bad: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple.shade100,
                child: const Text('左边短'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.shade100,
                child: const Text(
                  '中间有一段非常非常非常非常非常长的文本',
                  overflow: TextOverflow.ellipsis, // 只有在约束内才生效
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple.shade100,
                child: const Text('右边短'),
              ),
            ],
          ),
          good: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple.shade100,
                child: const Text('左边短'),
              ),
              Expanded(
                // ✅ 关键：Expanded 给中间项加约束
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green.shade100,
                  child: const Text(
                    '中间有一段非常非常非常非常非常长的文本，现在被 Expanded 约束住了',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple.shade100,
                child: const Text('右边短'),
              ),
            ],
          ),
          fix: '✅ 修复：把长内容那个子项用 Expanded 包起来',
        ),
      ],
    );
  }

  Widget _experiment({
    required String title,
    required String cause,
    required Widget bad,
    required Widget good,
    required String fix,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text('💡 根因：$cause', style: TextStyle(color: Colors.grey[700], fontSize: 11, height: 1.5)),
          const SizedBox(height: 10),
          _miniLabel('❌ 修复前'),
          Container(
            height: 120,
            color: Colors.grey.shade100,
            child: bad,
          ),
          const SizedBox(height: 10),
          _miniLabel('✅ 修复后'),
          Container(
            height: 120,
            color: Colors.grey.shade100,
            child: good,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(fix, style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _miniLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
