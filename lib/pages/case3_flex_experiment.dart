import 'package:flutter/material.dart';

/// 案例三：弹性分配实验
/// 三栏 2:1:1 布局 + 一栏内容超长时的表现
class Case3FlexExperiment extends StatefulWidget {
  const Case3FlexExperiment({super.key});

  @override
  State<Case3FlexExperiment> createState() => _Case3FlexExperimentState();
}

class _Case3FlexExperimentState extends State<Case3FlexExperiment> {
  bool _longText = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // 控制开关
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.toggle_off_outlined),
              const SizedBox(width: 8),
              const Text('让中间栏内容超长：', style: TextStyle(fontWeight: FontWeight.w500)),
              const Spacer(),
              Switch(
                value: _longText,
                onChanged: (v) => setState(() => _longText = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Expanded 版（正确写法）
        _buildSection(
          title: '✅ Expanded 2:1:1（推荐）',
          subtitle: 'Expanded 强制按 flex 比例分配剩余空间',
          content: Row(
            children: [
              Expanded(flex: 2, child: _panel('flex:2', Colors.blue, Colors.blue.shade500)),
              Expanded(
                flex: 1,
                child: _panel(
                  _longText
                      ? '这是一段非常非常长的文本内容，用来测试当某一栏内容远超预期长度时，Expanded 是否能正确约束尺寸而不溢出'
                      : 'flex:1',
                  Colors.green,
                  Colors.green.shade500,
                ),
              ),
              Expanded(flex: 1, child: _panel('flex:1', Colors.orange, Colors.orange.shade500)),
            ],
          ),
        ),

        // Flexible 版（对比）
        const SizedBox(height: 12),
        _buildSection(
          title: '🔍 Flexible 2:1:1（允许子项小于分配空间）',
          subtitle: 'Flexible ≠ Expanded，空间富余时不会强制撑满',
          content: Row(
            children: [
              Flexible(flex: 2, child: _panel('flex:2', Colors.blue, Colors.blue.shade300)),
              Flexible(
                flex: 1,
                child: _panel(
                  _longText
                      ? '超长文本测试 Flexible 的行为差异'
                      : 'flex:1',
                  Colors.green,
                  Colors.green.shade300,
                ),
              ),
              Flexible(flex: 1, child: _panel('flex:1', Colors.orange, Colors.orange.shade300)),
            ],
          ),
        ),

        // ❌ 错误示范：没有 Expanded
        const SizedBox(height: 12),
        _buildSection(
          title: '❌ 错误示范：Row 直接放三个 Container',
          subtitle: '没有 Expanded → 内容挤成一团或溢出（黄黑警告）',
          content: Row(
            children: [
              _panel('A', Colors.blueGrey, Colors.blueGrey.shade400),
              _panel(
                _longText ? '超长超长超长超长超长超长超长' : 'B',
                Colors.redAccent,
                Colors.redAccent.shade200,
              ),
              _panel('C', Colors.purple, Colors.purple.shade300),
            ],
          ),
        ),

        // Column + Expanded 骨架演示
        const SizedBox(height: 12),
        _buildSection(
          title: '📐 Column 骨架 + Expanded 吃掉剩余高度',
          subtitle: 'Header / Expanded(ListView) / BottomBar 经典结构',
          content: SizedBox(
            height: 260,
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.blue.shade400,
                  alignment: Alignment.center,
                  child: const Text('Header', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      8,
                      (i) => ListTile(
                        leading: CircleAvatar(child: Text('${i + 1}')),
                        title: Text('列表项 ${i + 1}'),
                        subtitle: const Text('Expanded 让这部分吃掉剩余高度'),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.orange.shade400,
                  alignment: Alignment.center,
                  child: const Text('BottomBar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _panel(String text, Color bgColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(10),
      height: 90,
      color: bgColor,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
