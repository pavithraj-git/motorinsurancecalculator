import 'package:flutter/material.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _avatarScale;
  late Animation<double> _fadeSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _avatarScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    _fadeSlide = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getInitials() {
    final name = MyApp.userData?["name"] ?? "";
    final parts = name.trim().split(" ");
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return "?";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            _buildHeroSection(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: FadeTransition(
                  opacity: _fadeSlide,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.15),
                      end: Offset.zero,
                    ).animate(_fadeSlide),
                    child: _buildInfoCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: _HeroClipper(),
          child: Container(
            height: 255,
            color: const Color(0xFFC0272D),
            child: Column(
              children: [
                // AppBar row
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 22),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Avatar
                ScaleTransition(
                  scale: _avatarScale,
                  child: _PulseAvatar(initials: _getInitials()),
                ),

                const SizedBox(height: 10),

                // Name
                FadeTransition(
                  opacity: _fadeSlide,
                  child: Text(
                    MyApp.userData?["name"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Badge
                FadeTransition(
                  opacity: _fadeSlide,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Premium Member",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    final rows = [
      _RowData(
        icon: Icons.person_outline_rounded,
        label: "Name",
        value: MyApp.userData?["name"] ?? "-",
      ),
      _RowData(
        icon: Icons.mail_outline_rounded,
        label: "Email",
        value: MyApp.userData?["mail"] ?? "-",
      ),
      _RowData(
        icon: Icons.phone_outlined,
        label: "Phone",
        value: MyApp.userData?["phone"] ?? "-",
      ),
      _RowData(
        icon: Icons.map_outlined,
        label: "State",
        value: MyApp.userData?["state"] ?? "-",
      ),
      _RowData(
        icon: Icons.location_city_outlined,
        label: "City",
        value: MyApp.userData?["city"] ?? "-",
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC0272D).withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card header
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFC0272D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "PERSONAL INFO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // Staggered row items
          ...rows.asMap().entries.map((entry) {
            final delay = 0.4 + entry.key * 0.08;
            final itemAnim = CurvedAnimation(
              parent: _controller,
              curve: Interval(
                delay.clamp(0.0, 1.0),
                (delay + 0.3).clamp(0.0, 1.0),
                curve: Curves.easeOut,
              ),
            );
            return AnimatedBuilder(
              animation: itemAnim,
              builder: (context, child) => FadeTransition(
                opacity: itemAnim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-0.15, 0),
                    end: Offset.zero,
                  ).animate(itemAnim),
                  child: child,
                ),
              ),
              child: _buildRowItem(
                entry.value,
                isLast: entry.key == rows.length - 1,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRowItem(_RowData data, {required bool isLast}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDEAEA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  data.icon,
                  color: const Color(0xFFC0272D),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.label,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFAAAAAA),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 0.5,
            indent: 66,
            color: Color(0xFFF0F0F0),
          ),
      ],
    );
  }
}

// ─── Pulse Avatar ─────────────────────────────────────────────────────────────

class _PulseAvatar extends StatefulWidget {
  final String initials;
  const _PulseAvatar({required this.initials});

  @override
  State<_PulseAvatar> createState() => _PulseAvatarState();
}

class _PulseAvatarState extends State<_PulseAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _ring;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _ring = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ring,
      builder: (context, child) {
        return Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.25),
                blurRadius: _ring.value,
                spreadRadius: _ring.value * 0.5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.15),
        ),
        child: Center(
          child: Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                widget.initials,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC0272D),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Hero Clipper ─────────────────────────────────────────────────────────────

class _HeroClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 36);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 10,
      size.width,
      size.height - 36,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_HeroClipper oldClipper) => false;
}

// ─── Row Data Model ───────────────────────────────────────────────────────────

class _RowData {
  final IconData icon;
  final String label;
  final String value;
  const _RowData({
    required this.icon,
    required this.label,
    required this.value,
  });
}