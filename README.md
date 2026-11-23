# MyPortfolio Mobile

Nama: Bagas Aulia Rezki
NPM: 2506656545
Kelas: PBP E

Aplikasi mobile portofolio pribadi yang dibuat dengan Flutter. Proyek ini melanjutkan pekerjaan myportofolio yang dari python kemaren :).

## Fitur

- Tiga kartu identitas untuk NPM, nama, dan kelas.
- Lima kartu aksi: Lihat Portofolio, Tambah Proyek, Tambah Pengalaman, Tambah Edukasi, dan Logout.
- Setiap kartu punya warna berbeda dan menampilkan SnackBar saat ditekan. Kartu Tambah Proyek, Tambah Pengalaman, dan Tambah Edukasi juga membuka formulirnya dengan `Navigator.push()`.
- Drawer dengan opsi Home, Add Project, Add Experience, dan Add Education. Drawer yang sama dipakai di halaman utama dan semua halaman formulir.
- Formulir Tambah Pengalaman yang mengikuti model `Experience` di web portofolio: judul, organisasi, kategori, deskripsi, proyek, teknologi, URL thumbnail, tanggal mulai, dan tanggal selesai.
- Formulir Tambah Edukasi yang mengikuti model `Education` di web portofolio: kualifikasi, institusi, tahun mulai, dan tahun selesai.
- Validasi isian wajib, isian yang hanya berisi spasi, batas panjang, format URL, rentang tahun, serta urutan tanggal dan tahun.
- Dialog ringkasan muncul setelah semua isian lolos validasi. Tombol OK menutup dialog dan mengosongkan formulir.
- Halaman Tentang yang bisa dibuka dari ikon info di AppBar.
- Layout bisa digulir, sehingga tombol Simpan tetap bisa dijangkau di layar sempit atau saat papan ketik tampil.
- Data profil dan menu masih statis di dalam kode. Isian formulir belum dikirim ke backend.

## Struktur Proyek

```text
lib/
  main.dart                   # bootstrap aplikasi dan MaterialApp
  models/
    education.dart            # data edukasi dan format periode
    experience.dart           # data pengalaman, pilihan kategori, dan format periode
  screens/
    menu.dart                 # halaman utama, InfoCard, dan ItemHomepage
    about_page.dart           # halaman Tentang
    project_form.dart         # formulir Tambah Proyek (Tutorial 09)
    experience_form.dart      # formulir Tambah Pengalaman
    education_form.dart       # formulir Tambah Edukasi
  utils/
    validators.dart           # validator bersama untuk isian wajib, panjang, URL, dan tahun
    date_format.dart          # format tanggal tanpa package tambahan
  widgets/
    left_drawer.dart          # drawer navigasi yang dipakai semua halaman
    project_card.dart         # ItemCard untuk kartu aksi
    summary_dialog.dart       # AlertDialog ringkasan isian formulir
test/
  widget_test.dart            # pengujian halaman utama, kartu, drawer, dan navigasi
  experience_form_test.dart   # pengujian formulir Tambah Pengalaman
  education_form_test.dart    # pengujian formulir Tambah Edukasi
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

### Pengujian Manual Tugas 8

1. Jalankan `flutter run -d chrome`.
2. Buka Tambah Pengalaman dan Tambah Edukasi dari kartu aksi, lalu kembali dengan tombol kembali.
3. Buka kedua formulir dari drawer, lalu pilih Home untuk kembali ke halaman utama.
4. Kosongkan salah satu isian wajib atau isi dengan spasi, lalu tekan Simpan. Pesan kesalahan harus muncul di kolom terkait.
5. Lengkapi isian, tekan Simpan, dan pastikan dialog menampilkan data yang baru dimasukkan. Tekan OK untuk kembali ke formulir.
6. Ulangi dengan mode perangkat selebar ponsel di DevTools Chrome untuk memastikan tombol Simpan tetap bisa dijangkau.

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

### Minggu 9: Tutorial 09 (18 November 2026)

- Memindahkan halaman ke `lib/screens/` dan widget ke `lib/widgets/` (`0095efe`).
- Menambahkan `LeftDrawer` dengan opsi Home dan Add Project.
- Membuat formulir Tambah Proyek dengan `Form`, `GlobalKey<FormState>`, validator, dan `AlertDialog`.
- Kartu Tambah Proyek membuka formulir dengan `Navigator.push()`.

### Tugas 8: Navigation, Layouts, Forms, and Input Elements (16 sampai 23 November 2026)

- Mengerjakan perubahan di branch `feat/assignment-8` dengan commit terpisah untuk setiap bagian.
- Memindahkan halaman Tentang ke `lib/screens/` (`ea9b8a9`).
- Menambahkan atribut `page` pada `ItemHomepage`, sehingga kartu tidak lagi memeriksa nama untuk membuka halaman (`90ae428`).
- Membuat formulir Tambah Pengalaman dengan date picker, dropdown kategori, validasi URL, dan validasi urutan tanggal (`a6da06d`).
- Membuat formulir Tambah Edukasi dengan input tahun, validasi rentang tahun, dan validasi urutan tahun (`7eb2df6`).
- Menambahkan opsi Add Experience dan Add Education di drawer (`7fd266d`).
- Menambahkan kartu Tambah Pengalaman dan Tambah Edukasi di halaman utama (`ff539a4`).
- Menambahkan pengujian widget untuk navigasi, validasi, dialog ringkasan, dan layar sempit.
- Menulis jawaban pertanyaan reflektif Tugas 8 di README ini.

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

### Tugas 8
1. `Navigator` menyimpan halaman dalam bentuk tumpukan (stack). `Navigator.push()` menaruh route baru di atas tumpukan, jadi halaman lama tetap ada di bawahnya dan pengguna bisa kembali ke sana. `Navigator.pushReplacement()` juga membuka route baru, tetapi route yang sedang aktif dibuang dulu, sehingga tumpukan tidak bertambah dan tidak ada halaman lama untuk dituju saat menekan kembali. `Navigator.pop()` membuang route paling atas dan menampilkan route di bawahnya. Method ini juga dipakai untuk menutup dialog, misalnya tombol OK di dialog ringkasan.

   Kartu aksi membuka formulir dengan `Navigator.push()`. Di `ItemCard`, kalau `item.page` tidak null, kartu memanggil `Navigator.push(context, MaterialPageRoute(builder: (context) => page))`. Karena halaman utama masih ada di bawah formulir, tombol kembali bawaan perangkat (atau tombol back di browser) menjalankan `pop` dan membawa pengguna kembali ke halaman utama. AppBar formulir menampilkan ikon menu, bukan tombol kembali, karena halaman formulir memakai drawer.

   Opsi Home di `LeftDrawer` memanggil `Navigator.pushReplacement()` dengan `MyHomePage()`. Halaman formulir yang sedang terbuka diganti dengan halaman utama yang baru, jadi pengguna tiba di halaman utama tanpa menumpuk halaman formulir di belakangnya. Opsi Add Project, Add Experience, dan Add Education juga memakai `pushReplacement`, sehingga berpindah-pindah lewat drawer tidak membuat tumpukan route makin panjang. Cara ini juga yang saya pakai untuk menguji alur kembali di Chrome.

2. Setiap halaman memakai susunan yang sama: `Scaffold` sebagai kerangka, `AppBar` di atas, `drawer: const LeftDrawer()` di samping, dan isi halaman di `body`. `Scaffold` sudah menyediakan tempat untuk AppBar, drawer, body, dan SnackBar, jadi saya tidak perlu mengatur posisi bagian-bagian itu sendiri di setiap halaman. `AppBar` selalu menampilkan judul halaman dengan gaya yang sama. Kalau halaman punya drawer, AppBar otomatis menampilkan ikon menu untuk membukanya. Ikon ini didahulukan daripada tombol kembali, jadi halaman yang dibuka dengan `push` tetap bisa ditutup lewat tombol kembali bawaan perangkat atau browser. Karena semua halaman memakai widget `LeftDrawer` yang sama, daftar opsinya selalu sama. Saat saya menambah Add Experience dan Add Education, cukup mengubah satu berkas dan perubahannya langsung terlihat di semua halaman.

   Contoh warna tema yang dipakai di lebih dari satu halaman adalah `Theme.of(context).colorScheme.primary`. Warna ini berasal dari `ColorScheme.fromSeed(seedColor: Colors.indigo)` di `main.dart`. Warna yang sama dipakai untuk latar AppBar di halaman utama, halaman Tentang, formulir Tambah Pengalaman, dan formulir Tambah Edukasi, juga untuk header drawer dan tombol Simpan. Kalau warna seed di `main.dart` diganti, semua bagian itu ikut berubah tanpa mengubah setiap halaman.

3. Formulir saya susun dalam satu kolom: `SafeArea`, lalu `Form`, `SingleChildScrollView`, `Center`, `ConstrainedBox`, dan `Column`. Satu kolom paling mudah dibaca di layar ponsel karena pengguna cukup mengisi dari atas ke bawah, dan urutan isiannya mengikuti urutan field di model Django. `CrossAxisAlignment.stretch` membuat setiap input dan tombol Simpan selebar layar, sehingga mudah diketuk. `ConstrainedBox` dengan lebar maksimal 600 piksel menjaga formulir tidak terlalu lebar saat dibuka di Chrome desktop. Tombol Simpan ada di akhir isi yang bisa digulir, bukan di posisi tetap, supaya tidak menutupi input saat papan ketik tampil.

   Widget pengatur jarak seperti `SizedBox(height: 16.0)` di antara input dan `padding: EdgeInsets.all(16.0)` di `SingleChildScrollView` memberi ruang yang konsisten. Jarak ini membuat label, pesan kesalahan, dan batas tiap input tidak saling berdempetan, dan isi formulir tidak menempel ke tepi layar. `SingleChildScrollView` adalah widget penggulirnya. Saat layar pendek atau papan ketik tampil, `Scaffold` mengecilkan area body, dan tanpa penggulir `Column` akan overflow lalu tombol Simpan tidak bisa dijangkau. Dengan penggulir, pengguna tinggal menggulir ke bawah. `keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag` juga menutup papan ketik saat pengguna menggulir. Pengujian `tombol Simpan tetap terjangkau di layar sempit` memastikan tombol tetap bisa diketuk di layar 320×480.

4. `GlobalKey<FormState>` adalah kunci yang dipasang di widget `Form` dan menjadi pegangan ke state formulir tersebut. Lewat `_formKey.currentState`, tombol Simpan bisa memanggil method milik formulir seperti `validate()` dan `reset()` tanpa harus menyimpan referensi setiap input satu per satu. Validator adalah fungsi di setiap `TextFormField` atau `DropdownButtonFormField` yang menerima nilai isian, lalu mengembalikan `null` kalau valid atau teks pesan kesalahan kalau tidak valid. Validator yang dipakai bersama saya kumpulkan di `lib/utils/validators.dart`. `validate()` menjalankan semua validator di dalam `Form`, menampilkan pesan kesalahan di bawah kolom yang gagal, dan mengembalikan `true` hanya kalau semua isian valid. Saat tombol Simpan ditekan, `_submit()` memanggil `_formKey.currentState!.validate()`. Kalau hasilnya `false`, fungsi berhenti dan dialog tidak muncul. Kalau `true`, data dibaca dari controller, dibuat menjadi objek `Experience` atau `Education`, lalu ditampilkan di `AlertDialog` lewat `showDialog()`.

   Contoh nilai yang ditolak adalah tahun mulai `0999` di formulir Tambah Edukasi. Input tahun memakai `TextInputType.number`, `FilteringTextInputFormatter.digitsOnly`, dan `maxLength: 4`, tetapi `0999` tetap terdiri dari empat angka sehingga lolos dari semua pembatas itu. Validator menolaknya dengan pesan "Tahun mulai harus berupa tahun antara 1000 dan 9999!" karena model `Education` memakai `MinValueValidator(1000)`. Contoh lain adalah tahun selesai `2020` dengan tahun mulai `2025`, atau URL thumbnail `bukan-url` walaupun papan ketiknya sudah `TextInputType.url`. Jenis input dan papan ketik hanya mengatur tombol apa yang muncul. Di Chrome atau saat pengguna menempel teks, aturan itu bisa dilewati, dan papan ketik tidak bisa mengecek aturan model seperti rentang angka, format URL, isian yang hanya berisi spasi, batas 255 karakter, atau urutan tanggal yang bergantung pada isian lain. Karena itu, validator tetap diperlukan sebagai pemeriksaan terakhir sebelum data dianggap sah.
