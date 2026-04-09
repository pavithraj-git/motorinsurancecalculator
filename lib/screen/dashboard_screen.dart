import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:motorinsurancecalculator/screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/color_constant.dart';
import '../controller/dashboard_controller.dart';
import '../main.dart';
import 'calculator/calculation_screen.dart';
import 'login_screen.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DashboardController dash = Get.put(DashboardController());

  late AnimationController _controller;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  initFun() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    if (token == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      MyApp.userData = decodedToken;
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: Stack(
          children: [
            // ── Red wave header background ─────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.darkRedColor,
                      const Color(0xFFB71C1C),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 60,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── HEADER ────────────────────────────────────────────────
                _buildHeader(context),

                // ── GREETING ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.80),
                            fontSize: 14,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Your Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                // ── CALCULATOR CARD ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildCalculatorCard(context),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── SECTION LABEL ─────────────────────────────────────────
                // FadeTransition(
                //   opacity: _fadeAnimation,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 24),
                //     child: Row(
                //       children: [
                //         Container(
                //           width: 4,
                //           height: 18,
                //           decoration: BoxDecoration(
                //             color: ColorConstant.darkRedColor,
                //             borderRadius: BorderRadius.circular(4),
                //           ),
                //         ),
                //         const SizedBox(width: 10),
                //         const Text(
                //           'Quick Tools',
                //           style: TextStyle(
                //             color: Color(0xFF1A1A2E),
                //             fontSize: 16,
                //             fontWeight: FontWeight.w700,
                //             letterSpacing: -0.2,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //
                // const SizedBox(height: 14),
                //
                // // ── STAT CARDS ROW ────────────────────────────────────────
                // FadeTransition(
                //   opacity: _fadeAnimation,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: _StatCard(
                //             icon: Icons.bolt_rounded,
                //             label: 'Fast',
                //             sub: 'Instant results',
                //           ),
                //         ),
                //         const SizedBox(width: 12),
                //         Expanded(
                //           child: _StatCard(
                //             icon: Icons.verified_outlined,
                //             label: 'Accurate',
                //             sub: 'Precise estimates',
                //           ),
                //         ),
                //         const SizedBox(width: 12),
                //         Expanded(
                //           child: _StatCard(
                //             icon: Icons.lock_outline,
                //             label: 'Secure',
                //             sub: 'Data protected',
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 19,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          _HeaderIconButton(
            icon: Icons.person_outline_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
          _HeaderIconButton(
            icon: Icons.logout_rounded,
            onTap: () => logoutDialog(context),
          ),
        ],
      ),
    );
  }

  // ── CALCULATOR CARD ───────────────────────────────────────────────────────
  Widget _buildCalculatorCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) => CalculatorScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.darkRedColor.withOpacity(0.10),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Subtle corner red triangle
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  size: const Size(100, 100),
                  painter: _CornerAccentPainter(
                    color: ColorConstant.darkRedColor.withOpacity(0.05),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Animated rotating icon
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 66,
                                height: 66,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorConstant.darkRedColor,
                                      const Color(0xFFB71C1C),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConstant.darkRedColor
                                          .withOpacity(0.35),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  child: const Icon(
                                    Icons.calculate,
                                    size: 34,
                                    color: Colors.white,
                                  ),
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _controller.value * 2 * math.pi,
                                      child: child,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),

                        const Spacer(),

                        // Open chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color:
                            ColorConstant.darkRedColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Open',
                                style: TextStyle(
                                  color: ColorConstant.darkRedColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorConstant.darkRedColor,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Insurance\nCalculator',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -0.6,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Estimate your motor insurance\npremium in seconds.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13.5,
                        height: 1.55,
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade100,
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Tap to calculate',
                          style: TextStyle(
                            color: ColorConstant.darkRedColor.withOpacity(0.55),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── LOGOUT DIALOG ─────────────────────────────────────────────────────────
  void logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 40,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ColorConstant.darkRedColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: ColorConstant.darkRedColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF1A1A2E),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('token');
                          MyApp.userData = null;
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorConstant.darkRedColor,
                                const Color(0xFFB71C1C),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.darkRedColor
                                    .withOpacity(0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── HEADER ICON BUTTON ────────────────────────────────────────────────────────
class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.28),
            width: 1,
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ── STAT CARD ─────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: ColorConstant.darkRedColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: ColorConstant.darkRedColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            sub,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 10.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CORNER ACCENT PAINTER ─────────────────────────────────────────────────────
class _CornerAccentPainter extends CustomPainter {
  final Color color;
  const _CornerAccentPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerAccentPainter old) => false;
}