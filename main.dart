import 'dart:io';

// 1. Database Anggota
final anggota = [
  {"nim": "124240138", "nama": "Rafi'i Maulana"},
  {"nim": "124240179", "nama": "Aslam Arganda"},
  {"nim": "124240200", "nama": "Ahmad Santosa"},
];

Map<String, String>? userAktif;

void main() {
  while (true) {
    if (userAktif == null) {
      login();
    } else {
      dashboard();
    }
  }
}

// 2. Autentikasi
void login() {
  print("\n=== SISTEM LOGIN ===");
  stdout.write("Nama : ");
  String nama = stdin.readLineSync()?.trim().toLowerCase() ?? '';
  stdout.write("NIM  : ");
  String nim = stdin.readLineSync()?.trim() ?? '';

  try {
    userAktif = anggota.firstWhere(
      (m) => m['nim'] == nim && m['nama']!.toLowerCase() == nama,
    );
    print("Login berhasil! Halo, ${userAktif!['nama']}.");
  } catch (_) {
    print("Kredensial salah! Silakan coba lagi.");
  }
}

// 3. Menu Utama
void dashboard() {
  print("\n--- MENU UTAMA (${userAktif!['nama']}) ---");
  print("1. Data Kelompok\n2. Penjumlahan & Pengurangan\n3. Perkalian & Pembagian");
  print("4. Cek Ganjil/Genap\n5. Total Deret Angka\n6. Logout");
  stdout.write("Pilih (1-6): ");
  String? menu = stdin.readLineSync()?.trim();

  switch (menu) {
    case '1':
      print("\n--- DATA KELOMPOK ---");
      for (var m in anggota) {
        print("- ${m['nama']} (${m['nim']})");
      }
      break;
    case '2':
      hitung("+", "-");
      break;
    case '3':
      hitung("*", "/");
      break;
    case '4':
      cekGanjilGenap();
      break;
    case '5':
      totalAngka();
      break;
    case '6':
      userAktif = null;
      print("Berhasil logout.");
      break;
    default:
      print("Menu tidak valid!");
  }
}

// 4. Kalkulator Gabungan (Reuse untuk +,- dan *,/)
void hitung(String op1, String op2) {
  print("\nPilih Operasi: [1] $op1  |  [2] $op2");
  stdout.write("Pilihan: ");
  String? pil = stdin.readLineSync()?.trim();
  if (pil != '1' && pil != '2') return print("Pilihan salah!");

  stdout.write("Angka 1 : ");
  double a = double.tryParse(stdin.readLineSync() ?? '') ?? 0;
  stdout.write("Angka 2 : ");
  double b = double.tryParse(stdin.readLineSync() ?? '') ?? 0;

  String op = pil == '1' ? op1 : op2;
  dynamic hasil;

  if (op == "+") hasil = a + b;
  if (op == "-") hasil = a - b;
  if (op == "*") hasil = a * b;
  if (op == "/") hasil = (b == 0) ? "Error (bagi nol)" : a / b;

  print("Hasil: $a $op $b = $hasil");
}

// 5. Fitur Ganjil / Genap
void cekGanjilGenap() {
  stdout.write("\nMasukkan bilangan bulat: ");
  int? n = int.tryParse(stdin.readLineSync() ?? '');
  if (n == null) return print("Input harus bilangan bulat!");
  print("$n adalah bilangan ${n % 2 == 0 ? 'GENAP' : 'GANJIL'}.");
}

// 6. Fitur Total Deret Angka
void totalAngka() {
  stdout.write("\nMasukkan deret angka (contoh: 10 20 30): ");
  String baris = stdin.readLineSync() ?? '';
  var angka = baris
      .split(RegExp(r'[\s,]+'))
      .map(double.tryParse)
      .whereType<double>()
      .toList();

  double total = angka.fold(0, (sum, val) => sum + val);
  print("Jumlah angka: ${angka.length} | Total: $total");
}