import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

void main() {
  testWidgets('menampilkan identitas dan menu portofolio', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506656545'), findsOneWidget);
    expect(find.text('Bagas Aulia Rezki'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);
    expect(find.byType(ItemCard), findsNWidgets(3));
    expect(find.text('Lihat Portofolio'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('setiap tombol menampilkan SnackBar sesuai namanya', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    for (final name in const ['Lihat Portofolio', 'Tambah Proyek', 'Logout']) {
      await tester.tap(find.text(name));
      await tester.pumpAndSettle();

      expect(find.text('Kamu telah menekan tombol $name!'), findsOneWidget);

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      if (name == 'Tambah Proyek') {
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
      }
    }
  });

  testWidgets('setiap kartu memakai warna yang berbeda', (tester) async {
    await tester.pumpWidget(const MyApp());

    final cards = tester.widgetList<ItemCard>(find.byType(ItemCard)).toList();
    final colors = cards.map((card) => card.item.color).toSet();
    expect(colors.length, cards.length);

    for (var index = 0; index < cards.length; index++) {
      final material = tester.widget<Material>(
        find
            .descendant(
              of: find.byType(ItemCard).at(index),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(material.color, cards[index].item.color);
    }
  });

  testWidgets('membuka halaman Tentang dari AppBar', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byTooltip('Tentang aplikasi'));
    await tester.pumpAndSettle();

    expect(find.text('Tentang Aplikasi'), findsOneWidget);
    expect(find.text('2506656545'), findsOneWidget);
    expect(find.text('Bagas Aulia Rezki'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('layout tetap aman di layar sempit', (tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(tester.takeException(), isNull);
    expect(find.text('Lihat Portofolio'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('drawer berpindah antara halaman utama dan form proyek', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('My Portfolio'), findsOneWidget);

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(find.text('Add Project Form'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('tombol Tambah Proyek membuka form dan dapat kembali', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(ProjectFormPage))).canPop(),
      isTrue,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets('form memvalidasi dan menampilkan data proyek', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portfolio Mobile');
    await tester.enterText(fields.at(1), 'Aplikasi portofolio pribadi.');
    await tester.enterText(fields.at(2), 'Flutter');

    await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mobile Development').last);
    await tester.pumpAndSettle();

    await tester.enterText(fields.at(3), 'https://example.com/project');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Proyek: Portfolio Mobile'), findsOneWidget);
    expect(
      find.text('Deskripsi: Aplikasi portofolio pribadi.'),
      findsOneWidget,
    );
    expect(find.text('Kategori: Mobile Development'), findsOneWidget);
    expect(find.text('Teknologi: Flutter'), findsOneWidget);
    expect(find.text('Tautan: https://example.com/project'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
