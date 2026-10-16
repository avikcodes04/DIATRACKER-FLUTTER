import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DiaTrackApp(),
      ),
    );

    // Verify DiaTracker title or login is present
    expect(find.text('DiaTracker'), findsWidgets);
  });
}
