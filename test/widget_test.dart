import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hw/main.dart';

void main() {
  testWidgets('Student Form app loads properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudentFormApp());

    // Verify that the title appears.
    expect(find.text('نموذج بيانات الطالب'), findsWidgets);
  });
}
