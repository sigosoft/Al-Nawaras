import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/membership_plans_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_no_data.dart';

class MembershipPlansScreen extends StatelessWidget {
  const MembershipPlansScreen({super.key});

  /// Turns the API duration ("Hourly", "Daily", "Monthly"...) into the unit
  /// shown after "per", e.g. "per hour". Unknown values are shown as-is.
  static String _periodUnit(BuildContext context, dynamic period) {
    final s = S.of(context);
    final p = (period ?? 'month').toString().trim().toLowerCase();
    if (p.startsWith('hour')) return s.periodHour;
    if (p.startsWith('dai') || p.startsWith('day')) return s.periodDay;
    if (p.startsWith('week')) return s.periodWeek;
    if (p.startsWith('month')) return s.periodMonth;
    if (p.startsWith('year') || p.startsWith('annual')) return s.periodYear;
    return p;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<MembershipPlansController>(
      init: MembershipPlansController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: S.of(context).membershipPlans,
            centerTitle: false,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.025),
                      Text(
                        S.of(context).choosePlanNeeds,
                        style: const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: height * 0.025),
                      // Render each plan card
                      if (controller.isLoading)
                        SizedBox(
                          height: height * 0.4,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFE30613),
                            ),
                          ),
                        )
                      else if (controller.plans.isEmpty)
                        SizedBox(
                          height: height * 0.4,
                          child: Center(
                            child: CustomNoData(
                              message: S.of(context).noPlansFound,
                            ),
                          ),
                        )
                      else
                        ...controller.plans.asMap().entries.map((entry) {
                          int idx = entry.key;
                          var plan = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: _buildPlanCard(
                              context,
                              plan,
                              idx,
                              controller,
                              height,
                              width,
                            ),
                          );
                        }),
                      // Room to scroll the last plan clear of the help button.
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    Map<String, dynamic> plan,
    int index,
    MembershipPlansController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF00B2FF),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(15),
                topEnd: Radius.circular(15),
              ),
            ),
            child: Text(
              plan['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: plan['price'],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${S.of(context).per} ${_periodUnit(context, plan['period'])}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () => controller.onSelectPlan(index),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00B2FF),
                        side: const BorderSide(
                          color: Color(0xFF00B2FF),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: const Size(40, 40),
                      ),
                      child: Text(
                        S.of(context).select,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                ...List<Widget>.from(
                  plan['features'].map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.green,
                            shadows: const [
                              Shadow(
                                color: Colors.green,
                                offset: Offset(0.5, 0),
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Colors.green,
                                offset: Offset(-0.5, 0),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
