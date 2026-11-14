import 'package:al_nawaras/generated/l10n.dart';
import 'package:al_nawaras/view/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<MethodCall> hapticCalls;

  setUp(() {
    hapticCalls = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'HapticFeedback.vibrate') hapticCalls.add(call);
      return null;
    });
  });

  Future<List<int>> pumpBar(WidgetTester tester, {int current = 0}) async {
    final taps = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: current,
            onTap: taps.add,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return taps;
  }

  testWidgets('tapping another tab switches and gives a selection haptic', (
    tester,
  ) async {
    final taps = await pumpBar(tester);
    await tester.tap(find.text('Bookings'));
    await tester.pump();

    expect(taps, [1]);
    expect(hapticCalls, hasLength(1));
    expect(
      hapticCalls.single.arguments,
      'HapticFeedbackType.selectionClick',
    );
  });

  testWidgets('tapping the current tab does nothing', (tester) async {
    final taps = await pumpBar(tester, current: 2);
    await tester.tap(find.text('Services'));
    await tester.pump();

    expect(taps, isEmpty);
    expect(hapticCalls, isEmpty);
  });

  testWidgets('shows all four tabs', (tester) async {
    await pumpBar(tester);
    for (final label in ['Home', 'Bookings', 'Services', 'Profile']) {
      expect(find.text(label), findsOneWidget);
    }
  });
}
