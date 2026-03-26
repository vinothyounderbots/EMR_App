// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emr_application/main.dart';
import 'package:emr_application/feature/view/login_page.dart';
import 'package:emr_application/core/custom_widgets/custom_text_form_field.dart';

void main() {
  testWidgets('EMR Application launch test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const EMRApp());

    // Verify that the MaterialApp is created
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Verify that we start with the LoginPage
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Login page elements test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const EMRApp());
    await tester.pumpAndSettle();

    // Verify that text form fields for login are present
    expect(find.byType(CustomTextFormField), findsAtLeast(2)); // Patient ID and Password fields
    
    // Verify patient ID field exists
    expect(find.widgetWithText(CustomTextFormField, 'Patient ID'), findsOneWidget);
    
    // Verify password field exists
    expect(find.widgetWithText(CustomTextFormField, 'Password'), findsOneWidget);

    // Test login form interaction
    await tester.enterText(find.byType(CustomTextFormField).first, 'test_patient');
    await tester.enterText(find.byType(CustomTextFormField).last, 'password123');
    await tester.pump();

    // Verify text was entered correctly
    expect(find.text('test_patient'), findsOneWidget);
  });
}
