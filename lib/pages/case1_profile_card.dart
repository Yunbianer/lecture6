import 'package:flutter/material.dart';

/// 课堂案例：profile_card 个人名片页
///
/// 步骤一（骨架与对齐）：
/// - Column 自上而下组织页面；头像与姓名用 Row 水平排列
/// - 统计条三个数字块各包一层 Expanded，均分 Row 的剩余宽度
/// - 标签云用 Wrap 自动换行
///
/// 步骤二（容器美化）：
/// - Container + BoxDecoration 实现圆角、阴影与留白
/// - Stack + Positioned 实现头像右下角的在线状态徽标
///
/// 步骤三（设计稿对照）：
/// - 间距统一取 4 的倍数（4/8/12/16/20/24）
/// - 宽屏下限制最大宽度，窄屏下文字省略，运行无 RenderFlex 溢出
class Case1ProfileCard extends StatelessWidget {
  const Case1ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProfileHeader(),
                  SizedBox(height: 16),
                  _StatsCard(),
                  SizedBox(height: 16),
                  _TagsCard(),
                  SizedBox(height: 20),
                  _ActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 卡片统一装饰：白底 + 16 圆角 + 轻阴影，避免每个卡片重复书写
const BoxDecoration _cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ],
);

/// 头像区：CircleAvatar + 姓名/签名两行 Text + Stack 在线状态徽标
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration,
      child: Row(
        children: [
          // Stack 层叠：头像是底层，状态点用 Positioned 定位到右下角
          Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 36, color: Colors.white),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Expanded 约束文字宽度，长文本不会把头像挤出屏幕
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter 学习者',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '专注基础组件与布局系统',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 统计条：三个 Expanded 数字块均分宽度，中间用 1px 分隔线
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: _cardDecoration,
      child: Row(
        children: [
          _statItem('项目', '12'),
          _divider(),
          _statItem('Star', '86'),
          _divider(),
          _statItem('关注', '24'),
        ],
      ),
    );
  }

  /// 每个数字块都用 Expanded：Row 给的是松约束，
  /// 不加 Expanded 时子项只按内容宽度排布，无法三等分统计条。
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

  Widget _divider() {
    return Container(width: 1, height: 32, color: Colors.black12);
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
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
              for (final tag in _tags) _TagChip(label: tag),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, color: Colors.blueAccent),
      ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.star_border, size: 18),
            label: const Text('关注'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              side: const BorderSide(color: Colors.blueAccent),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
