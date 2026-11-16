# MyPortfolio Mobile

Nama: Bagas Aulia Rezki
NPM: 2506656545
Kelas: PBP E

Aplikasi mobile portofolio pribadi yang dibuat dengan Flutter. Proyek ini melanjutkan pekerjaan myportofolio yang dari python kemaren :).

## Fitur

- Tiga kartu identitas untuk NPM, nama, dan kelas.
- Tiga tombol aksi: Lihat Portofolio, Tambah Proyek, dan Logout.
- Setiap tombol punya warna berbeda dan menampilkan SnackBar saat ditekan.
- Halaman Tentang yang bisa dibuka dari ikon info di AppBar.
- Layout bisa digulir dan jumlah kolom menyesuaikan lebar layar.
- Data profil dan menu masih statis di dalam kode. Aplikasi tidak memerlukan backend.

Ketiga tombol aksi saat ini hanya menampilkan SnackBar sesuai instruksi tugas. Halaman daftar portofolio dan form tambah data belum dibuat.

## Struktur Proyek

```text
lib/
  main.dart         # bootstrap aplikasi dan MaterialApp
  menu.dart         # halaman utama, InfoCard, ItemCard, dan ItemHomepage
  about_page.dart   # halaman Tentang
test/
  widget_test.dart  # pengujian widget
```

## Cara Menjalankan

Pastikan Flutter sudah terpasang. Proyek ini memakai Flutter 3.47.9 dan Dart 3.13.7.

```bash
flutter pub get
flutter devices
flutter run
```

Untuk menjalankan di browser, gunakan:

```bash
flutter run -d chrome
```

Untuk perangkat lain, salin ID dari keluaran `flutter devices`, lalu jalankan `flutter run -d <id-perangkat>`. Pada Android, emulator atau perangkat fisik harus aktif lebih dulu.

## Pemeriksaan Kode

```bash
flutter analyze
flutter test
```

`flutter analyze` harus selesai tanpa issue. `flutter test` mengecek identitas pemilik, pesan SnackBar, warna kartu, halaman Tentang, dan layout pada layar sempit.

## Dokumentasi Progres Mingguan

### Minggu 8: Tutorial 08 (11 November 2026)

- Membuat proyek Flutter `myportofolio_mobile` dan menyiapkan struktur awal (`443db23`).
- Memisahkan halaman menu dari `main.dart` ke `lib/menu.dart`.
- Mengubah `MyHomePage` menjadi `StatelessWidget`.
- Menambahkan `InfoCard` untuk identitas dan `ItemCard` untuk aksi, lengkap dengan SnackBar.

### Tugas 7: Basic Flutter (9 sampai 16 November 2026)

- Mengerjakan perubahan di branch `feat/assignment-7` dengan commit terpisah untuk data, warna, dan UI.
- Mengganti data contoh dengan data aseli (`3babb7f`).
- Menambahkan atribut `color` pada `ItemHomepage` dan memberi warna berbeda untuk setiap kartu aksi (`50f45c7`).
- Menambahkan layout yang bisa digulir, penyesuaian jumlah kolom, dan halaman Tentang (`7eeb140`).
- Menambahkan pengujian untuk identitas, SnackBar, warna kartu, halaman Tentang, dan layout layar sempit.
- Menulis dokumentasi proyek dan jawaban pertanyaan reflektif di README ini.

## AI disclosure

Saya tidak menggunakan AI. Seluruh implementasi dan dokumentasi pada tugas ini dikerjakan secara mandiri.

## Tugas 7

1. **Widget tree dan hubungan induk-anak**

   Widget tree adalah susunan widget yang membentuk tampilan aplikasi. Setiap widget menyimpan konfigurasi, lalu metode `build` mengembalikan widget lain sebagai anaknya. Di proyek ini akarnya adalah `MaterialApp`, lalu `MyHomePage`, `Scaffold`, `AppBar`, dan isi body. Body berisi `SafeArea`, `SingleChildScrollView`, `Column`, deretan `InfoCard`, dan `GridView` berisi `ItemCard`.

   Hubungan induk-anak bekerja dengan cara containment, bukan inheritance. Induk memberi batas ruang (constraints) kepada anak, anak menentukan ukuran, lalu induk mengatur posisi anak. Data juga mengalir ke bawah lewat constructor, misalnya `MyHomePage` mengirim `title` dan `content` ke `InfoCard`, serta objek `ItemHomepage` ke `ItemCard`. Sebaliknya, anak bisa memanggil aksi ke atas lewat callback atau API seperti `ScaffoldMessenger.of(context)`.

   Flutter menyimpan widget tree sebagai deskripsi yang tidak berubah. Saat state berubah, Flutter membuat widget baru, membandingkannya dengan element tree, lalu memperbarui render object yang perlu berubah. Karena itu, widget sendiri bukan tempat menyimpan state yang berubah-ubah.

2. **Widget yang dipakai dan fungsinya**

   Saya membagi widget yang saya pakai langsung di kode menjadi widget halaman, layout, dan tampilan. Tabel berikut merangkum fungsinya.

   | Widget | Fungsi |
   | --- | --- |
   | `MyApp` | Widget akar proyek yang mengembalikan `MaterialApp` dan mengatur tema aplikasi. |
   | `MaterialApp` | Menyiapkan tema, navigasi, dan halaman awal aplikasi Material. |
   | `MyHomePage` | Halaman menu utama yang menyimpan data pemilik dan daftar aksi. |
   | `Scaffold` | Kerangka halaman dengan AppBar, body, dan tempat SnackBar. |
   | `AppBar` | Bilah atas dengan judul dan tombol menuju halaman Tentang. |
   | `AboutPage` | Halaman statis berisi informasi aplikasi dan pemilik. |
   | `SafeArea` | Menjauhkan konten dari notch, status bar, dan area sistem. |
   | `SingleChildScrollView` | Membuat isi halaman menu bisa digulir. |
   | `ListView` | Menampilkan daftar bagian pada halaman Tentang. |
   | `Column` | Menyusun anak secara vertikal. |
   | `Row` | Menyusun anak secara horizontal. |
   | `Expanded` | Mengisi sisa ruang pada Row atau Column. |
   | `IntrinsicHeight` | Menyamakan tinggi kartu identitas dalam satu Row. |
   | `LayoutBuilder` | Membaca lebar layar untuk memilih 2 atau 3 kolom. |
   | `Padding` | Memberi jarak di dalam widget. |
   | `SizedBox` | Memberi jarak tetap antar-widget. |
   | `Center` | Menempatkan anak di tengah. |
   | `GridView.builder` | Membuat grid tombol aksi dari daftar `items`. |
   | `Text` | Menampilkan teks. |
   | `Icon` | Menampilkan ikon pada kartu dan halaman Tentang. |
   | `IconButton` | Tombol ikon info di AppBar. |
   | `Card` | Wadah bergaya kartu untuk identitas dan bagian Tentang. |
   | `Material` | Memberi warna latar dan efek material pada `ItemCard`. |
   | `InkWell` | Menangani ketukan dan ripple pada kartu aksi. |
   | `InfoCard` | Widget buatan sendiri untuk satu pasangan label dan nilai. |
   | `ItemCard` | Widget buatan sendiri untuk satu aksi portofolio. |
   | `_InfoRow` | Baris label dan nilai pada halaman Tentang. |
   | `_FeatureRow` | Baris ikon dan teks fitur pada halaman Tentang. |
   | `SnackBar` | Pesan singkat setelah tombol aksi ditekan. |
   | `ScaffoldMessenger` | Mengatur antrean SnackBar. Diakses lewat `.of(context)`, bukan ditulis langsung di kode kita. |
   | `Navigator` | Mengelola tumpukan halaman. Dipakai lewat `.of(context)` untuk membuka `AboutPage`. |
   | `MaterialPageRoute` | Rute yang dipakai saat membuka halaman Tentang. Ini route, bukan widget tampilan. |
   | `Theme` | Widget inherited dari `MaterialApp` yang menyediakan warna dan tipografi. Diakses lewat `Theme.of(context)`. |
   | `ItemHomepage` | Model data, bukan widget. Menyimpan nama, ikon, dan warna untuk `ItemCard`. |

   Selain itu ada objek konfigurasi yang bukan widget, yaitu `ThemeData`, `ColorScheme`, `TextStyle`, `EdgeInsets`, `BorderRadius`, `Colors`, `Icons`, `FontWeight`, dan `TextAlign`. AppBar di `AboutPage` juga membuat tombol kembali secara otomatis.

3. **Fungsi MaterialApp**

   `MaterialApp` adalah widget akar yang menyiapkan aplikasi dengan gaya Material Design. Di proyek ini, `MyApp.build` mengembalikan `MaterialApp` yang mengatur `title`, `theme`, dan `home: MyHomePage()`. Dari widget ini, seluruh halaman mendapat `ThemeData` yang sama, navigator untuk berpindah halaman, `ScaffoldMessenger` untuk SnackBar, serta pengaturan locale dan arah teks.

   `MaterialApp` biasanya dipakai sebagai root karena aplikasi butuh satu tempat untuk konfigurasi global. Kalau tema, navigasi, dan pengaturan bahasa dipasang terpisah di banyak tempat, perilakunya mudah tidak konsisten. Dengan `MaterialApp`, `Theme.of(context)` dan `Navigator.of(context)` bisa dipanggil dari widget mana pun di bawahnya. `MaterialApp` sendiri tidak menggambar halaman. Ia membungkus `WidgetsApp` dan menyediakan konfigurasi Material untuk halaman di dalam `home`.

   `MaterialApp` tidak wajib dipakai kalau aplikasi memakai gaya Cupertino atau hanya `WidgetsApp`, tetapi untuk aplikasi dengan komponen Material, widget ini memberi default yang lengkap. Tanpa `MaterialApp`, saya harus menyusun sendiri `WidgetsApp`, tema, navigator, dan pengaturan bahasa.

4. **StatelessWidget dan StatefulWidget**

   `StatelessWidget` adalah widget yang konfigurasinya tidak berubah setelah dibuat. Semua data berasal dari constructor atau sumber di luar widget, dan `build` hanya menyusun tampilan dari data itu. Stateless bukan berarti tidak pernah dibangun ulang. Widget ini tetap bisa rebuild saat induk atau InheritedWidget berubah, tetapi ia tidak punya state internal yang bisa diubah lewat `setState`. Contoh di proyek ini adalah `MyHomePage`, `InfoCard`, `ItemCard`, dan `AboutPage`. `MyHomePage` tetap stateless karena NPM, nama, kelas, dan daftar menu tidak berubah selama halaman terbuka.

   `StatefulWidget` memiliki objek `State` yang bertahan antar-rebuild. State bisa diubah lewat `setState`, dan perubahan itu memicu `build` ulang. Widget ini punya siklus hidup seperti `initState`, `didUpdateWidget`, dan `dispose`, sehingga cocok untuk input form, data dari API, animasi, timer, atau kontrol scroll.

   Saya memilih `StatelessWidget` selama tampilan hanya bergantung pada data tetap atau data yang dikirim induk. Saya memilih `StatefulWidget` kalau widget harus menyimpan nilai yang berubah sendiri, misalnya isi form tambah proyek atau status loading. SnackBar tidak membuat `MyHomePage` perlu stateful karena antrean SnackBar dikelola oleh `ScaffoldMessenger`.

5. **BuildContext**

   `BuildContext` adalah pegangan ke posisi sebuah widget di widget tree. Secara teknis, context terhubung dengan elemen tempat widget itu dipasang. Lewat context, widget bisa mencari data dari ancestor, seperti tema, ukuran layar, navigator, atau scaffold messenger.

   Di metode `build(BuildContext context)`, context menunjukkan lokasi widget yang sedang dibangun. Contohnya, `Theme.of(context)` di `MyHomePage` mencari `Theme` terdekat dari `MaterialApp`. `ScaffoldMessenger.of(context)` di `ItemCard` mencari pengelola SnackBar di atasnya. `Navigator.of(context)` di AppBar dipakai untuk membuka `AboutPage`, dan `Theme.of(context)` di `AboutPage` mengambil warna yang sama.

   Context hanya valid selama widget masih terpasang. Saya tidak menyimpannya untuk dipakai nanti, terutama setelah `await`. Kalau perlu memakai context setelah operasi async, saya harus memastikan widget masih mounted, misalnya dengan `context.mounted` atau `mounted` pada `State`. Context juga mencari ke atas, bukan ke bawah, jadi anak bisa menemukan ancestor, tetapi induk tidak bisa mencari anak lewat context.

6. **Hot reload dan hot restart**

   Hot reload mengirim perubahan kode Dart ke aplikasi yang sedang berjalan dalam mode debug. Flutter membangun ulang widget tree dan mempertahankan state, posisi scroll, serta halaman yang sedang terbuka. Saya memakai hot reload untuk perubahan teks, warna, padding, atau susunan widget karena hasilnya langsung terlihat tanpa kehilangan state.

   Hot restart juga menjalankan ulang kode Dart, tetapi state dan riwayat navigasi direset. Aplikasi kembali ke halaman awal. Hot restart dipakai saat perubahan ada di `main()`, inisialisasi di `initState`, variabel global atau static, atau ketika hot reload meninggalkan state lama yang tidak sesuai. Full restart (berhenti lalu menjalankan ulang aplikasi) diperlukan saat perubahan menyentuh kode native, plugin, `pubspec.yaml` dan dependency, `AndroidManifest.xml`, `Info.plist`, atau konfigurasi build. Perubahan seperti itu tidak cukup ditangani oleh hot reload karena bagian native atau dependency belum ikut dimuat ulang.

   Di proyek ini, perubahan tampilan menu dan halaman Tentang cukup dengan hot reload. Kalau saya mengubah cara data awal dibuat atau menambah package baru, saya memakai hot restart atau menjalankan ulang `flutter run` agar kode dan dependency benar-benar dimuat dari awal. Hot reload dan hot restart hanya tersedia di mode debug. Build release harus dibuat ulang.
