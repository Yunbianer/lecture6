import 'package:flutter/material.dart';

/// 案例四：层叠角标
/// 场景1：头像徽标（在线状态）
/// 场景2：图片浮层文字（底部渐变遮罩 + 标题）
class Case4StackBadge extends StatelessWidget {
  const Case4StackBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // 场景1：头像右下角徽标（在线状态点）
        _section(
          title: '场景1：头像徽标（Stack + Positioned）',
          subtitle: '典型用法：在线状态、消息红点、等级徽章',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 在线状态点
              _avatarWithDot(
                avatarColor: Colors.blueAccent,
                dotColor: Colors.green,
                label: '在线',
              ),
              // 离线灰色点
              _avatarWithDot(
                avatarColor: Colors.grey,
                dotColor: Colors.grey.shade500,
                label: '离线',
              ),
              // 消息红点
              _avatarWithBadge(
                avatarColor: Colors.deepPurple,
                badgeCount: 5,
                label: '消息',
              ),
              // 等级徽章
              _avatarWithBanner(
                avatarColor: Colors.orangeAccent,
                bannerText: 'VIP',
                label: '等级',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 场景2：图片浮层文字
        _section(
          title: '场景2：图片浮层文字（渐变遮罩 + 标题）',
          subtitle: '底图 + Positioned 渐变层 + Positioned 文字',
          child: Column(
            children: [
              _imageOverlayCard(
                title: 'Flutter 布局原理',
                subtitle: '约束传递三句话',
                icon: Icons.widgets,
                bgColor: const Color(0xFF1976D2),
              ),
              const SizedBox(height: 12),
              _imageOverlayCard(
                title: 'Dart 异步编程',
                subtitle: 'Future / async / await',
                icon: Icons.bolt,
                bgColor: const Color(0xFF388E3C),
              ),
              const SizedBox(height: 12),
              _imageOverlayCard(
                title: '状态管理',
                subtitle: 'Provider / Riverpod / Bloc',
                icon: Icons.account_tree,
                bgColor: const Color(0xFF7B1FA2),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Stack 注意事项说明
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 6),
                  Text('翻车警告', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                ],
              ),
              SizedBox(height: 6),
              Text(
                '• Stack 里非 Positioned 子组件参与 Stack 尺寸计算\n'
                '• Positioned 子组件不参与尺寸计算\n'
                '• 想让 Stack 撑满屏幕，先放 SizedBox.expand 或让底图 fit: BoxFit.cover',
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _section({
    required String title,
    required String subtitle,
    required Widget child,
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
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  /// 头像 + 右下角小圆点（在线/离线）
  Widget _avatarWithDot({
    required Color avatarColor,
    required Color dotColor,
    required String label,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, // 关键：允许子组件溢出 Stack 边界
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: avatarColor,
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 头像 + 右上角消息数字徽标
  Widget _avatarWithBadge({
    required Color avatarColor,
    required int badgeCount,
    required String label,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: avatarColor,
              child: const Icon(Icons.email, color: Colors.white, size: 28),
            ),
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 99 ? '99+' : '$badgeCount',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 头像 + 底部等级横幅
  Widget _avatarWithBanner({
    required Color avatarColor,
    required String bannerText,
    required String label,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: avatarColor,
              child: const Icon(Icons.workspace_premium, color: Colors.white, size: 28),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    bannerText,
                    style: const TextStyle(color: Colors.black54, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 图片浮层卡片：底图（渐变色模拟图片） + 底部渐变遮罩 + Positioned 文字
  Widget _imageOverlayCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
  }) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand, // 让非 Positioned 子项撑满 Stack
        children: [
          // 底图：渐变色容器模拟图片
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [bgColor, bgColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, size: 60, color: Colors.white.withValues(alpha: 0.4)),
            ),
          ),
          // 底部渐变遮罩层（Positioned，不参与尺寸计算）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
          // 浮层文字（Positioned 在遮罩之上）
          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
