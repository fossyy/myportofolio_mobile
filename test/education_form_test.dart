import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

Future<void> pumpForm(WidgetTester tester, {Size size = const Size(360, 720)}) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  return tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const EducationFormPage(),
    ),
  );
}

Finder field(String label) => find.widgetWithText(TextFormField, label);

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('memakai Scaffold, AppBar bertema, drawer, dan tombol Simpan', (
    tester,
  ) async {
    await pumpForm(tester);

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    final context = tester.element(find.byType(EducationFormPage));
    expect(appBar.backgroundColor, Theme.of(context).colorScheme.primary);
    expect(find.text('Add Education Form'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
  });

  testWidgets('menolak isian wajib yang kosong atau hanya spasi', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(field('Kualifikasi'), '   ');
    await tapVisible(tester, find.text('Simpan'));

    expect(find.text('Kualifikasi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Institusi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tahun mulai tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tahun selesai tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('memeriksa batas panjang, rentang tahun, dan urutan tahun', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(field('Kualifikasi'), 'a' * 256);
    await tester.enterText(field('Institusi'), 'Universitas Indonesia');
    await tester.enterText(field('Tahun Mulai'), '0999');
    await tester.enterText(field('Tahun Selesai'), '2029');
    await tapVisible(tester, find.text('Simpan'));

    expect(find.text('Kualifikasi maksimal 255 karakter!'), findsOneWidget);
    expect(
      find.text('Tahun mulai harus berupa tahun antara 1000 dan 9999!'),
      findsOneWidget,
    );

    await tester.enterText(field('Kualifikasi'), 'S1 Ilmu Komputer');
    await tester.enterText(field('Tahun Mulai'), '2025');
    await tester.enterText(field('Tahun Selesai'), '2020');
    await tapVisible(tester, find.text('Simpan'));

    expect(
      find.text('Tahun selesai tidak boleh sebelum tahun mulai!'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('input tahun hanya menerima angka maksimal empat digit', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(field('Tahun Mulai'), '20a25x9');
    await tester.pump();

    final startYear = tester.widget<TextFormField>(field('Tahun Mulai'));
    expect(startYear.controller!.text, '2025');
  });

  testWidgets('menampilkan ringkasan lalu mengosongkan form setelah OK', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(field('Kualifikasi'), '  S1 Ilmu Komputer ');
    await tester.enterText(field('Institusi'), 'Universitas Indonesia');
    await tester.enterText(field('Tahun Mulai'), '2025');
    await tapVisible(tester, find.text('Masih berlangsung'));

    final endYear = tester.widget<TextFormField>(field('Tahun Selesai'));
    expect(endYear.enabled, isFalse);

    await tapVisible(tester, find.text('Simpan'));

    final dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);
    expect(find.text('Edukasi berhasil disimpan!'), findsOneWidget);
    for (final text in [
      'S1 Ilmu Komputer',
      'Universitas Indonesia',
      '2025 — Present',
    ]) {
      expect(
        find.descendant(of: dialog, matching: find.text(text)),
        findsOneWidget,
      );
    }

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(EducationFormPage), findsOneWidget);
    final qualification = tester.widget<TextFormField>(field('Kualifikasi'));
    expect(qualification.controller!.text, isEmpty);
    final endYearAfter = tester.widget<TextFormField>(field('Tahun Selesai'));
    expect(endYearAfter.enabled, isTrue);
  });

  testWidgets('menampilkan periode dengan tahun selesai', (tester) async {
    await pumpForm(tester);

    await tester.enterText(field('Kualifikasi'), 'SMA IPA');
    await tester.enterText(field('Institusi'), 'SMAN 1');
    await tester.enterText(field('Tahun Mulai'), '2022');
    await tester.enterText(field('Tahun Selesai'), '2025');
    await tapVisible(tester, find.text('Simpan'));

    expect(find.text('2022 — 2025'), findsOneWidget);
  });

  testWidgets('tombol Simpan tetap terjangkau di layar sempit', (tester) async {
    await pumpForm(tester, size: const Size(320, 480));

    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Simpan').hitTestable(), findsOneWidget);
  });
}
