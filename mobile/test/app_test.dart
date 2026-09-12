import 'package:flutter_test/flutter_test.dart';
import 'package:luminary/main.dart';

void main() {
  testWidgets('home presents the golden-path CTA', (tester) async {
    await tester.pumpWidget(const LuminaryApp());
    expect(find.text('What are you making today?'), findsOneWidget);
    expect(find.text('Add a product'), findsOneWidget);
  });
}
