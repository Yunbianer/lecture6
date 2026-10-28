import 'package:flutter/material.dart';

/// 案例五：容器美化卡片
/// Padding / Container / BoxDecoration / ClipRRect / ClipOval / FittedBox
class Case5ContainerBeautify extends StatelessWidget {
  const Case5ContainerBeautify({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // 卡片套路（背下来直接用！）
        _section(
          title: '📦 卡片套路（Container + BoxDecoration）',
          subtitle: '圆角 + 阴影 + 留白，最常用的美化模板',
          child: _cardSkeleton(),
        ),
        const SizedBox(height: 16),

        // 不同剪裁效果
        _section(
          title: '✂️ 剪裁三剑客',
          subtitle: 'ClipRRect 圆角 / ClipOval 圆 / ClipPath 自定义',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _clipDemo(
                label: 'ClipRRect 圆角',
                clipper: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _coloredBox(Colors.blue),
                ),
              ),
              _clipDemo(
                label: 'ClipOval 圆',
                clipper: ClipOval(child: _coloredBox(Colors.green)),
              ),
              _clipDemo(
                label: 'ClipPath 三角',
                clipper: ClipPath(
                  clipper: _TriangleClipper(),
                  child: _coloredBox(Colors.orange),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // FittedBox 缩放策略
        _section(
          title: '🔍 FittedBox 缩放策略',
          subtitle: '空间不足时按策略缩放子组件，避免溢出',
          child: Row(
            children: [
              _fittedBoxDemo('contain', BoxFit.contain),
              _fittedBoxDemo('fill', BoxFit.fill),
              _fittedBoxDemo('scaleDown', BoxFit.scaleDown),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 翻车警告
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 6),
                  Text('翻车警告', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
              SizedBox(height: 6),
              Text(
                '❌ Container 同时设置 color 和 decoration 会编译报错\n'
                '✅ color 要放进 decoration: BoxDecoration(color: ...)\n\n'
                '❌ 嵌套 Container 三层以上就该抽组件了',
                style: TextStyle(fontSize: 12, height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _section({required String title, required String subtitle, required Widget child}) {
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
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  /// 文档里的"卡片套路"完整示例
  Widget _cardSkeleton() {
    // 构造三个卡片并排展示不同层级
    return Column(
      children: [
        _buildCard(
          icon: Icons.star,
          iconColor: Colors.amber,
          title: '收藏夹',
          subtitle: '12 个项目',
        ),
        const SizedBox(height: 10),
        _buildCard(
          icon: Icons.folder,
          iconColor: Colors.blueAccent,
          title: '工作目录',
          subtitle: '3 个待完成',
        ),
        const SizedBox(height: 10),
        _buildCard(
          icon: Icons.download,
          iconColor: Colors.greenAccent,
          title: '下载记录',
          subtitle: '最近 7 天',
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    // ⭐ 文档卡片套路模板：
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 左侧图标（单独用 Container 做圆形背景）
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          // 中间文字（Expanded 占剩余空间）
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          // 右侧箭头
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _clipDemo({required String label, required Widget clipper}) {
    return Column(
      children: [
        SizedBox(width: 70, height: 70, child: clipper),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _coloredBox(Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: 0.5)],
        ),
      ),
    );
  }

  Widget _fittedBoxDemo(String label, BoxFit fit) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              color: Colors.grey.shade200,
              child: Text(fit.toString().split('.').last, style: const TextStyle(fontSize: 10)),
            ),
            Expanded(
              child: FittedBox(
                fit: fit,
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.blueAccent.withValues(alpha: 0.6),
                  alignment: Alignment.center,
                  child: const Text(
                    '大',
                    style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 自定义三角剪裁器
class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
