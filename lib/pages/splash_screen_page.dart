// Mengimpor pustaka kontrol waktu dan timer asinkron bawaan bahasa Dart
import 'dart:async';

// Mengimpor pustaka antarmuka Material Design utama Flutter
import 'package:flutter/material.dart';

// Mengimpor halaman navigasi utama (MainNavigationPage) sebagai tujuan perpindahan layar
import 'main_navigation_page.dart';

// Komponen/Widget SplashScreenPage turunan StatefulWidget: Mengelola status timer hitung mundur
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

// Kelas pengelola state, timer asinkron, dan logika navigasi Splash Screen
class _SplashScreenPageState extends State<SplashScreenPage> {
  // --- DEKLARASI VARIABEL STATE & TIMER ---
  // Deklarasi variabel durasi hitung mundur dalam satuan detik (Nilai awal: 5 detik)
  int _durasiDetik = 20;
  // Deklarasi variabel objek timer asinkron (Nullable '?' karena belum dibuat saat kelas diinisialisasi)
  Timer? _timer;

  // Method initState: Siklus hidup (lifecycle) yang dieksekusi otomatis satu kali saat widget pertama dipasang
  @override
  void initState() {
    super.initState();
    // Memulai fungsi penghitung waktu mundur otomatis saat layar splash screen terbuka
    _mulaiHitungMundur();
  }

  // --- FUNGSI LOGIKA HITUNG MUNDUR & NAVIGASI OTOMATIS ---
  void _mulaiHitungMundur() {
    // KONTROL PERULANGAN WAKTU ASINKRON: Mengeksekusi fungsi callback setiap interval 1 detik secara berulang
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // --- KONTROL PERCABANGAN LOGIKA EVALUASI TIMER ---
      // Percabangan Kondisi 1: Jika waktu durasi masih lebih besar dari 1 detik
      if (_durasiDetik > 1) {
        // KONTROL LOGIKA STATE MANAGEMENT: Mengurangi angka durasi dan memperbarui angka di layar
        setState(() {
          _durasiDetik--; // Operasi decrement (mengurangi nilai variabel _durasiDetik sebanyak 1)
        });
      }
      // Percabangan Kondisi 2: Jika waktu durasi telah habis (mencapai angka 1 / selesai)
      else {
        _timer?.cancel(); // Menghentikan perulangan objek timer agar tidak berjalan lagi
        // KONTROL PERCABANGAN KEAMANAN WIDGET TREE (SAFETY CHECK):
        // Memastikan widget masih terpasang di memori sebelum memicu navigasi agar tidak menyebabkan error crash
        if (!mounted) return;
        // LOGIKA NAVIGASI PERPINDAHAN HALAMAN SATU ARAH:
        // Mengganti layar Splash Screen dengan MainNavigationPage menggunakan Navigator.pushReplacement()
        // agar pengguna tidak dapat menekan tombol kembali (Back) untuk kembali ke Splash Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationPage()),
        );
      }
    });
  }

  // Method dispose: Siklus hidup (lifecycle) pembersihan memori saat widget dihancurkan dari memori
  @override
  void dispose() {
    // PEMBERSIHAN SUMBER DAYA (RESOURCE CLEANUP): Mematikan timer untuk mencegah kebocoran memori (memory leak)
    _timer?.cancel();
    super.dispose();
  }

  // Method build: Merender tata letak visual halaman pembuka Splash Screen
  @override
  Widget build(BuildContext context) {
    // Komponen/Widget Scaffold: Layar penuh dengan latar belakang warna biru navy seragam kasir
    return Scaffold(
      backgroundColor: const Color(
        0xFF1E3A8A,
      ), // Deklarasi warna latar belakang: Biru Navy Elegan
      // Komponen/Widget Center: Memposisikan seluruh komponen tepat di tengah layar secara vertikal & horizontal
      body: Center(
        // Komponen/Widget Column: Menyusun logo, judul, indikator putar, dan timer secara vertikal
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Perataan tengah vertikal
          children: [
            // =====================================================================
            // BAGIAN 1: LOGO APLIKASI SMARTKASIR BERELEVASI
            // =====================================================================
            // Komponen/Widget Container: Wadah lingkaran putih dengan bayangan elevasi
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle, // Bentuk wadah bulat/lingkaran sempurna
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.2,
                    ), // Bayangan hitam semi-transparan
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              // Komponen/Widget Icon: Ikon mesin kasir kasir berukuran besar
              child: const Icon(
                Icons.point_of_sale_rounded,
                size: 72,
                color: Color(
                  0xFF1E3A8A,
                ), // Warna ikon serasi dengan warna tema (Biru Navy)
              ),
            ),
            const SizedBox(height: 24), // Jarak pemisah vertikal 24 piksel
            // =====================================================================
            // BAGIAN 2: IDENTITAS & TAGLINE PRODUK DIGITAL
            // =====================================================================
            // Komponen/Widget Text: Nama aplikasi dengan penataan huruf profesional
            const Text(
              'SmartKasir',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2, // Jarak renggang antar huruf modern
              ),
            ),
            const SizedBox(height: 6), // Jarak spasi 6 piksel
            // Komponen/Widget Text: Slogan deskripsi aplikasi
            const Text(
              'Aplikasi Kasir Point of Sale Digital',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
            const SizedBox(height: 36), // Jarak spasi 36 piksel
            // =====================================================================
            // BAGIAN 3: INDIKATOR LOADING ANIMATIF & TEKS TIMER DINAMIS
            // =====================================================================
            // Komponen/Widget SizedBox: Membatasi dimensi lingkaran indikator putar (28 x 28 dp)
            const SizedBox(
              width: 28,
              height: 28,
              // Komponen/Widget CircularProgressIndicator: Animasi putaran loading standar Material 3
              child: CircularProgressIndicator(
                color: Colors.amber, // Warna indikator putar: Emas cerah
                strokeWidth: 3, // Ketebalan garis putaran 3 piksel
              ),
            ),
            const SizedBox(height: 14), // Jarak spasi 14 piksel
            // Komponen/Widget Text: Menampilkan status hitung mundur secara reaktif dari variabel _durasiDetik
            Text(
              'Menyiapkan sistem SmartKasir($_durasiDetik detik)...', // Interpolasi string variabel _durasiDetik
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            const SizedBox(height: 40), // Jarak pemisah ke footer
            // Komponen/Widget Text: Catatan modul versi praktikum
            Text(
              'Versi 1.0.0 — Modul Pertemuan 10',
              style: TextStyle(fontSize: 11, color: Colors.blue.shade200),
            ),
          ],
        ),
      ),
    );
  }
}
