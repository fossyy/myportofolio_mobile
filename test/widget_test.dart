import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

const cardNames = [
  'Lihat Portofolio',
  'Tambah Proyek',
  'Tambah Pengalaman',
  'Tambah Edukasi',
  'Logout',
];

ApiClient buildMockApiClient({List<Map<String, dynamic>>? projects}) {
  final sampleProjects =
      projects ??
      [
        {
          'id': 1,
          'title': 'Portfolio API',
          'description': 'Django REST Framework backend for portfolio.',
          'source_url': 'https://github.com/fossyy/myportofolio',
          'live_url': 'https://bagas-aulia-myportofolio.pws.cs.ui.ac.id',
          'star_count': 3,
          'is_starred': false,
          'starred_by_names': 'alice, bob',
        },
      ];

  final mockClient = MockClient((request) async {
    if (request.method == 'GET' && request.url.path == '/api/v1/projects/') {
      return http.Response(jsonEncode(sampleProjects), 200);
    }
    if (request.method == 'POST' && request.url.path == '/api/v1/projects/') {
      if (request.headers['Authorization'] != 'Token test-token') {
        return http.Response('{"detail":"Invalid token."}', 401);
      }
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      return http.Response(
        jsonEncode({
          'id': 2,
          'title': body['title'],
          'description': body['description'],
          'source_url': body['source_url'] ?? '',
          'live_url': body['live_url'] ?? '',
          'star_count': 0,
          'is_starred': false,
          'starred_by_names': '',
        }),
        201,
      );
    }
    if (request.method == 'POST' && request.url.path == '/api/v1/auth/token/') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      if (body['username'] == 'owner' && body['password'] == 'secret') {
        return http.Response(jsonEncode({'token': 'test-token'}), 200);
      }
      return http.Response(
        jsonEncode({
          'non_field_errors': ['Unable to log in.'],
        }),
        400,
      );
    }
    if (request.method == 'POST' &&
        request.url.path == '/api/v1/auth/logout/') {
      return http.Response('', 204);
    }
    return http.Response('Not Found', 404);
  });

  return ApiClient(client: mockClient, baseUrl: 'http://localhost:8000');
}

void main() {
  testWidgets('menampilkan identitas dan menu portofolio', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

    expect(find.text('2506656545'), findsOneWidget);
    expect(find.text('Bagas Aulia Rezki'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);
    expect(find.byType(ItemCard), findsNWidgets(5));
    for (final name in cardNames) {
      expect(find.text(name), findsOneWidget);
    }
  });

  testWidgets('setiap kartu memakai warna yang berbeda', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

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
    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

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

    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

    expect(tester.takeException(), isNull);
    for (final name in cardNames) {
      expect(find.text(name), findsOneWidget);
    }
  });

  testWidgets('daftar proyek dapat diakses publik dan membuka detail', (
    tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

    await tester.tap(find.text('Lihat Portofolio'));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectListScreen), findsOneWidget);
    expect(find.text('Portfolio API'), findsOneWidget);

    await tester.tap(find.text('Portfolio API'));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectDetailScreen), findsOneWidget);
    expect(
      find.text('Django REST Framework backend for portfolio.'),
      findsOneWidget,
    );
    expect(find.text('https://github.com/fossyy/myportofolio'), findsOneWidget);
  });

  testWidgets('tambah proyek meminta login lalu mengirim proyek ke API', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 720);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    final loginFields = find.byType(TextFormField);
    await tester.enterText(loginFields.at(0), 'owner');
    await tester.enterText(loginFields.at(1), 'secret');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectFormPage), findsOneWidget);

    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Title tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Description tidak boleh kosong!'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portfolio Mobile');
    await tester.enterText(fields.at(1), 'Aplikasi portofolio pribadi.');
    await tester.enterText(fields.at(2), 'https://github.com/fossyy/mobile');
    await tester.enterText(fields.at(3), 'https://example.com/project');

    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Portfolio Mobile'), findsWidgets);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'drawer menampilkan Login saat belum login dan Logout setelahnya',
    (tester) async {
      await tester.pumpWidget(
        MyApp(apiClient: buildMockApiClient(), initialToken: 'test-token'),
      );

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text('Logout'), findsWidgets);

      await tester.tap(find.widgetWithText(ListTile, 'Logout'));
      await tester.pumpAndSettle();
      expect(find.text('Berhasil logout.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ListTile, 'Login'), findsOneWidget);
    },
  );

  testWidgets(
    'drawer membuka form pengalaman dan edukasi serta kembali ke Home',
    (tester) async {
      await tester.pumpWidget(MyApp(apiClient: buildMockApiClient()));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();

      expect(find.byType(ExperienceFormPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Education'));
      await tester.pumpAndSettle();
      expect(find.byType(EducationFormPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.byType(MyHomePage), findsOneWidget);
    },
  );
}
