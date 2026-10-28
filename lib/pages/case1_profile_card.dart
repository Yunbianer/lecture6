import 'package:flutter/material.dart';

/// 课堂案例：profile_card 个人名片页
/// 步骤一：搭建骨架与对齐，本步只处理结构，不做装饰
class Case1ProfileCard extends StatelessWidget {
  const Case1ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            _ProfileHeader(),
            SizedBox(height: 24),
            _StatsCard(),
            SizedBox(height: 24),
            _TagsCard(),
            SizedBox(height: 24),
            _ActionButtons(),
          ],
        ),
      ),
    );
  }
}

/// 头像区：CircleAvatar + 姓名/签名两行 Text
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 36, color: Colors.white),
        ),
        const SizedBox(width: 16),
        // Expanded 约束文字宽度，避免长文本把头像挤出屏幕
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter 学习者',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '专注基础组件与布局系统',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 统计条：三个数字块各包 Expanded，均分 Row 宽度
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _statItem('项目', '12'),
        _statItem('Star', '86'),
        _statItem('关注', '24'),
      ],
    );
  }

  Widget _statItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

/// 标签云：Wrap 按行流动排列，空间不足自动换行
class _TagsCard extends StatelessWidget {
  const _TagsCard();

  static const List<String> _tags = [
    'Flutter',
    'Dart',
    'UI 布局',
    '基础组件',
    '状态管理',
    '路由',
    '异步',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '技术标签',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in _tags)
              Text(
                tag,
                style: const TextStyle(fontSize: 13, color: Colors.blueAccent),
              ),
          ],
        ),
      ],
    );
  }
}

/// 操作按钮区：两个按钮各包 Expanded，等宽排列
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mail_outline, size: 18),
            label: const Text('联系我'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.star_border, size: 18),
            label: const Text('关注'),
          ),
        ),
      ],
    );
  }
}
