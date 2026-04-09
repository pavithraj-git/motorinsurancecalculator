import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/screen/calculator/bike/two_wheeler_passenger_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/electric_car_complete_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_national_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_new_india_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_oriental_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_united_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/e_rickshaw/e_rickshaw_goods_private_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/ambulance_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/misc_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/trailer_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/taxi/electric_taxi_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/taxi/taxi_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_goods_public_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_pcv_more_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_pcv_screen.dart';
import '../../common/color_constant.dart';
import '../../controller/dashboard_controller.dart';
import 'bike/electric_two_wheeler_screen.dart';
import 'bike/two_wheeler_premium_screen.dart';
import 'bus/bus_screen.dart';
import 'bus/electric_bus_screen.dart';
import 'bus/electric_school_bus_screen.dart';
import 'bus/school_bus_screen.dart';
import 'car/private_car_1od_1tp_screen.dart';
import 'car/private_car_1od_3tp_screen.dart';
import 'car/private_car_complete_screen.dart';
import 'car/private_car_comprehensive_screen.dart';
import 'car/private_car_saod_screen.dart';
import 'car/private_car_tp_screen.dart';
import 'e_rickshaw/e_rickshaw_goods_public_screen.dart';
import 'e_rickshaw/e_rickshaw_passenger_screen.dart';
import 'goods_carring/carrying_public_screen.dart';
import 'heavy_vehicle/hearses_screen.dart';
import 'heavy_vehicle/tractor_screen.dart';
import 'heavy_vehicle/trailer_TP_screen.dart';
import 'heavy_vehicle/trailer_comprehensive_screen.dart';
import 'heavy_vehicle/trailer_misc_screen.dart';

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  final DashboardController dash = Get.put(DashboardController());

  // Idle float controller — shared across all icons
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _navigate(BuildContext context, dynamic item, int index) {
    if (item?.id == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TwoWheelerPremiumScreen(title: item?.title)));
    } else if (item?.id == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TwoWheelerPremiumScreen(title: item?.title)));
    } else if (item?.id == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TwoWheelerPassengerScreen(title: item?.title)));
    } else if (item?.id == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricTwoWheelerScreen(title: item?.title)));
    } else if (item?.id == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricTwoWheelerScreen(title: item?.title)));
    } else if (item?.id == 6) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCar1OD1TPScreen(title: item?.title)));
    } else if (item?.id == 7) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCar1OD3TPScreen(title: item?.title)));
    } else if (item?.id == 8) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCarCompleteScreen(title: item?.title)));
    } else if (item?.id == 9) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricCarCompleteScreen(title: item?.title, bikeCC: "1780")));
    } else if (item!.id! >= 14 && item.id! <= 17) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CarryingPublicScreen(title: item?.title, bikeCC: index == 13 ? "16049" : index == 14 ? "13642" : index == 15 ? "16049" : "7233")));
    } else if (item?.id == 18) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TaxiScreen(title: item?.title, bikeCC: "6040")));
    } else if (item?.id == 19) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricTaxiScreen(title: item?.title, bikeCC: "8945")));
    } else if (item?.id == 20) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => BusScreen(title: item?.title, bikeCC: "14343")));
    } else if (item?.id == 21) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricBusScreen(title: item?.title, bikeCC: "12192")));
    } else if (item?.id == 22) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SchoolBusScreen(title: item?.title, bikeCC: "12192")));
    } else if (item?.id == 23) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricSchoolBusScreen(title: item?.title, bikeCC: "11670")));
    } else if (item?.id == 24 || item?.id == 25) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ThreeWheelerGoodsPublicScreen(title: item?.title, bikeCC: index == 23 ? "4492" : "3922")));
    } else if (item?.id == 26) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ThreeWheelerPCVScreen(title: item?.title, bikeCC: "2371")));
    } else if (item?.id == 27) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ThreeWheelerPCVMoreScreen(title: item?.title, bikeCC: "6763")));
    } else if (item?.id == 28) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ERickshawGoodsPrivateScreen(title: item?.title, bikeCC: "3211")));
    } else if (item?.id == 29) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ERickshawGoodsPublicScreen(title: item?.title, bikeCC: "3139")));
    } else if (item?.id == 30) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ERickshawPassengerScreen(title: item?.title, bikeCC: "1539")));
    } else if (item?.id == 31) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AmbulanceScreen(title: item?.title, bikeCC: "7267")));
    } else if (item?.id == 34) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HearsesScreen(title: item?.title, bikeCC: "1645")));
    } else if (item?.id == 35) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TractorScreen(title: item?.title, bikeCC: "1645")));
    } else if (item?.id == 36) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MISCScreen(title: item?.title, bikeCC: "7267")));
    } else if (item?.id == 37) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCarSAODScreen(title: item?.title)));
    } else if (item?.id == 38) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCarComprehensiveScreen(title: item?.title)));
    } else if (item?.id == 39) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PrivateCarTPScreen(title: item?.title)));
    } else if (item?.id == 40) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TrailerComprehensiveScreen(title: item?.title)));
    } else if (item?.id == 41) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TrailerTPScreen(title: item?.title)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F1EB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F1EB),
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Calculator",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: dash.dashboardList?.length ?? 0,
          separatorBuilder: (_, __) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final item = dash.dashboardList?[index];
            // Stagger delay per item (capped so last items don't wait too long)
            final staggerDelay = Duration(milliseconds: (index * 60).clamp(0, 500));

            return _PremiumListItem(
              item: item,
              index: index,
              floatAnimation: _floatAnimation,
              staggerDelay: staggerDelay,
              onTap: () => _navigate(context, item, index),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PREMIUM LIST ITEM — handles its own entrance
// ─────────────────────────────────────────────
class _PremiumListItem extends StatefulWidget {
  final dynamic item;
  final int index;
  final Animation<double> floatAnimation;
  final Duration staggerDelay;
  final VoidCallback onTap;

  const _PremiumListItem({
    required this.item,
    required this.index,
    required this.floatAnimation,
    required this.staggerDelay,
    required this.onTap,
  });

  @override
  State<_PremiumListItem> createState() => _PremiumListItemState();
}

class _PremiumListItemState extends State<_PremiumListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Staggered entrance
    Future.delayed(widget.staggerDelay, () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) {
              setState(() => _pressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _pressed = false),
            child: AnimatedScale(
              scale: _pressed ? 0.97 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_pressed ? 0.04 : 0.07),
                      blurRadius: _pressed ? 4 : 12,
                      offset: Offset(0, _pressed ? 1 : 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      // ── Premium Animated Icon ──
                      _PremiumIcon(
                        imagePath: "${widget.item?.image}",
                        floatAnimation: widget.floatAnimation,
                        index: widget.index,
                      ),

                      const SizedBox(width: 14),

                      // ── Title ──
                      Expanded(
                        child: Text(
                          "${widget.item?.title}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                            color: Color(0xFF1A1A1A),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),

                      // ── Chevron ──
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: _pressed
                              ? const Color(0xFFF0EBE3)
                              : ColorConstant.darkRedColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 13,
                          color: _pressed
                              ? const Color(0xFF8A7060)
                              : const Color(0xFFB5A898),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PREMIUM ICON — shimmer + float + spring pop
// ─────────────────────────────────────────────
class _PremiumIcon extends StatefulWidget {
  final String imagePath;
  final Animation<double> floatAnimation;
  final int index;

  const _PremiumIcon({
    required this.imagePath,
    required this.floatAnimation,
    required this.index,
  });

  @override
  State<_PremiumIcon> createState() => _PremiumIconState();
}

class _PremiumIconState extends State<_PremiumIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnim;
  late Animation<double> _springScale;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Shimmer sweeps once on entrance
    _shimmerAnim = Tween<double>(begin: -1.0, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Spring pop scale
    _springScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.elasticOut),
    );

    Future.delayed(
      Duration(milliseconds: 200 + (widget.index * 55).clamp(0, 500)),
          () {
        if (mounted) _shimmerController.forward();
      },
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_shimmerController, widget.floatAnimation]),
      builder: (context, child) {
        // Float Y offset — offset phase per index so icons float out-of-sync
        final phase = (widget.index % 3) / 3.0;
        final floatVal = widget.floatAnimation.value;
        final floatOffset = Offset(0, floatVal * (phase < 0.33 ? 1.0 : phase < 0.66 ? 0.6 : 0.3));

        return Transform.translate(
          offset: floatOffset,
          child: Transform.scale(
            scale: _springScale.value,
            child: SizedBox(
              width: 58,
              height: 58,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ── Icon background container ──
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF8F2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorConstant.darkRedColor,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.darkRedColor.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  // ── Icon image ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        widget.imagePath,
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // ── Shimmer sweep (entrance only) ──
                  if (_shimmerController.value < 1.0)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Transform.translate(
                          offset: Offset(58 * _shimmerAnim.value, 0),
                          child: Container(
                            width: 24,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.55),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}