import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

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
      home: const ExperienceFormPage(),
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

Future<void> pickDay(WidgetTester tester, String label, String day) async {
  await tapVisible(tester, field(label));
  await tester.tap(find.text(day));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

Future<void> fillRequired(WidgetTester tester) async {
  await tester.enterText(field('Judul / Posisi'), 'Software Engineer Intern');
  await tester.enterText(field('Organisasi'), 'Fasilkom UI');
  await tester.enterText(field('Deskripsi'), 'Membangun aplikasi Flutter.');
}

void main() {
  testWidgets('memakai Scaffold, AppBar bertema, drawer, dan tombol Simpan', (
    tester,
  ) async {
    await pumpForm(tester);

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    final context = tester.element(find.byType(ExperienceFormPage));
    expect(appBar.backgroundColor, Theme.of(context).colorScheme.primary);
    expect(find.text('Add Experience Form'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
  });

  testWidgets('menolak isian wajib yang kosong atau hanya spasi', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(field('Judul / Posisi'), '   ');
    await tapVisible(tester, find.text('Simpan'));

    expect(find.text('Judul tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Organisasi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tanggal mulai wajib dipilih!'), findsOneWidget);
    expect(
      find.text('Pilih tanggal selesai atau aktifkan "Masih berlangsung"!'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('memeriksa batas panjang dan format URL', (tester) async {
    await pumpForm(tester);

    await tester.enterText(field('Judul / Posisi'), 'a' * 256);
    await tester.enterText(field('Proyek (opsional)'), 'p' * 256);
    await tester.enterText(field('URL Thumbnail (opsional)'), 'bukan-url');
    await tapVisible(tester, find.text('Simpan'));

    expect(find.text('Judul maksimal 255 karakter!'), findsOneWidget);
    expect(find.text('Proyek maksimal 255 karakter!'), findsOneWidget);
    expect(
      find.text(
        'URL thumbnail harus berupa URL http:// atau https:// yang valid!',
      ),
      findsOneWidget,
    );

    await tester.enterText(
      field('URL Thumbnail (opsional)'),
      'ftp://example.com/a.png',
    );
    await tapVisible(tester, find.text('Simpan'));
    expect(
      find.text(
        'URL thumbnail harus berupa URL http:// atau https:// yang valid!',
      ),
      findsOneWidget,
    );
  });

  testWidgets('menolak tanggal selesai sebelum tanggal mulai', (tester) async {
    await pumpForm(tester);
    await fillRequired(tester);

    await pickDay(tester, 'Tanggal Mulai', '20');
    await pickDay(tester, 'Tanggal Selesai', '10');
    await tapVisible(tester, find.text('Simpan'));

    expect(
      find.text('Tanggal selesai tidak boleh sebelum tanggal mulai!'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('menampilkan ringkasan lalu mengosongkan form setelah OK', (
    tester,
  ) async {
    await pumpForm(tester);
    await fillRequired(tester);

    await tapVisible(tester, find.byType(DropdownButtonFormField<String>));
    await tester.tap(find.text('Internship').last);
    await tester.pumpAndSettle();

    await tester.enterText(field('Proyek (opsional)'), 'MyPortfolio');
    await tester.enterText(field('Teknologi (opsional)'), 'Flutter, , Django ');
    await tester.enterText(
      field('URL Thumbnail (opsional)'),
      'https://example.com/thumb.png',
    );
    await pickDay(tester, 'Tanggal Mulai', '10');
    await tapVisible(tester, find.text('Masih berlangsung'));

    final endField = tester.widget<TextFormField>(field('Tanggal Selesai'));
    expect(endField.enabled, isFalse);

    await tapVisible(tester, find.text('Simpan'));

    final dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);
    expect(find.text('Pengalaman berhasil disimpan!'), findsOneWidget);
    for (final text in [
      'Software Engineer Intern',
      'Fasilkom UI',
      'Internship',
      'Membangun aplikasi Flutter.',
      'MyPortfolio',
      'Flutter, Django',
      'https://example.com/thumb.png',
    ]) {
      expect(
        find.descendant(of: dialog, matching: find.text(text)),
        findsOneWidget,
      );
    }
    expect(
      find.descendant(of: dialog, matching: find.textContaining('— Present')),
      findsOneWidget,
    );

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(ExperienceFormPage), findsOneWidget);
    final title = tester.widget<TextFormField>(field('Judul / Posisi'));
    expect(title.controller!.text, isEmpty);
    expect(find.text('Full-Time'), findsOneWidget);
  });

  testWidgets('tombol Simpan tetap terjangkau di layar sempit', (tester) async {
    await pumpForm(tester, size: const Size(320, 480));

    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Simpan').hitTestable(), findsOneWidget);
  });
}
