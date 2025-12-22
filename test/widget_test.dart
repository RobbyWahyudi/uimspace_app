// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:uimspace_app/main.dart';

void main() {
  testWidgets('UIMSpace app launches with bottom navigation', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UIMSpaceApp());

    // Verify that bottom navigation items are present
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Kelas Saya'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);

    // Verify that the home page title is shown
    expect(find.text('Halaman Beranda'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches pages', (WidgetTester tester) async {
    await tester.pumpWidget(const UIMSpaceApp());

    // Initially on home page
    expect(find.text('Halaman Beranda'), findsOneWidget);

    // Tap on "Kelas Saya"
    await tester.tap(find.text('Kelas Saya'));
    await tester.pumpAndSettle();

    // Verify we're on the courses page
    expect(find.text('Halaman Kelas Saya'), findsOneWidget);

    // Tap on "Profil"
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();

    // Verify we're on the profile page
    expect(find.text('Halaman Profil'), findsOneWidget);
  });
}
