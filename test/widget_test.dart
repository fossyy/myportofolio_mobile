import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';

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
}
