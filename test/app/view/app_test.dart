import 'package:flutter_test/flutter_test.dart';
import 'package:rugmi/app/app.dart';
import 'package:rugmi/services/service_locator.dart';
import 'package:rugmi/views/home_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders HomeScreen', (tester) async {
      await tester.pumpWidget(const App());
      setupServiceLocator();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
