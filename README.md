# Form Inspeksi Kendaraan Leasing

Technical assignment submission untuk **PT. Nusantara Sakti Group**.

Repository ini berisi aplikasi Flutter untuk proses **inspeksi kendaraan leasing**. Fokus implementasinya adalah pengisian data inspeksi, validasi foto wajib, tanda tangan digital bersyarat, serta penyimpanan draft lokal agar data tidak hilang saat proses input berlangsung.

## Ringkasan

Implementasi saat ini memodelkan alur inspeksi kendaraan dengan tujuan utama berikut:

- Mengumpulkan data identitas inspeksi seperti nomor polisi, kilometer, dan lokasi kendaraan.
- Memastikan 5 foto inspeksi wajib selalu tersedia sebelum submit.
- Mewajibkan tanda tangan digital saat kendaraan tidak dapat dipindahkan.
- Menyimpan draft secara otomatis dengan mekanisme debounce.
- Mensimulasikan perilaku penyimpanan yang berbeda antara mode offline dan online.

Project ini dibuat sebagai **prototype / deliverable assignment**, sehingga integrasi kamera, GPS aktual, dan backend upload masih direpresentasikan dalam bentuk dummy data dan simulasi proses.

## Fitur yang Diimplementasikan

### 1. Form Identitas Inspeksi

- Nomor polisi
- Kilometer / odometer
- Lokasi kendaraan
- Catatan tambahan

### 2. Checklist Foto Wajib

Form mewajibkan kategori foto berikut:

- Foto Nomor Polisi
- Foto Kendaraan + Watermark GPS
- Foto Speedometer
- Foto Kondisi Eksterior
- Foto Kondisi Mesin

Setiap foto menyimpan metadata simulasi berupa:

- Koordinat GPS latitude dan longitude
- Timestamp pengambilan
- Watermark text
- Ukuran file asli dan hasil kompresi
- Mode penyimpanan

### 3. Status Pemindahan Kendaraan

User dapat memilih apakah kendaraan **bisa dipindahkan** atau **tidak bisa dipindahkan**.

Jika kendaraan tidak bisa dipindahkan:

- alasan dapat dicatat
- tanda tangan digital menjadi wajib sebelum submit

### 4. Digital Signature Pad

- Tanda tangan dibuat langsung di dalam aplikasi.
- Stroke tanda tangan ikut tersimpan dalam draft.
- Tanda tangan dapat dihapus dan digambar ulang.

### 5. Autosave Draft Lokal

- Autosave menggunakan debounce `700ms`.
- Draft disimpan dengan `shared_preferences`.
- Draft tetap tersedia setelah aplikasi dibuka ulang.
- Draft dapat di-reset secara manual.

### 6. Simulasi Perilaku Offline / Online

- **Mode offline** menyimpan draft secara lokal tanpa kompresi tambahan.
- **Mode online** mensimulasikan kompresi foto sebelum draft disimpan.
- Proses submit memperbarui status draft menjadi submitted.

## Catatan Teknis

Agar implementasi tetap sederhana dan mudah direview, project ini menggunakan pendekatan berikut:

- State management berbasis `ChangeNotifier`
- Persistence melalui local repository
- Pemisahan entity domain dari layer presentasi
- Widget test dasar untuk memverifikasi render alur inspeksi utama

## Arsitektur

Codebase mengikuti struktur feature-based yang ringan:

```text
lib/
  app/
    app.dart
    theme/
    utils/
  features/
    inspection/
      data/
        repositories/
      domain/
        entities/
        repositories/
      presentation/
        controllers/
        pages/
        widgets/
```

Tanggung jawab layer:

- `presentation`: UI, controller, dan interaksi form
- `domain`: entity dan kontrak repository
- `data`: implementasi repository serta perilaku persistence

## Teknologi yang Digunakan

- Flutter `3.41.6`
- Dart `3.11.4`
- Material 3
- `shared_preferences`

## Cara Menjalankan

### Prasyarat

- Flutter SDK `3.41.6` atau kompatibel
- Dart SDK `3.11.4`

### Install dependency

```bash
flutter pub get
```

### Menjalankan aplikasi

```bash
flutter run
```

### Menjalankan test

```bash
flutter test
```

## Panduan Review

Untuk mengecek assignment dengan cepat:

1. Jalankan aplikasi.
2. Tekan tombol **Isi data dummy** pada app bar.
3. Periksa kelengkapan foto wajib beserta metadata yang dihasilkan.
4. Ubah ke **mode online** untuk melihat perubahan status autosave dan kompresi.
5. Submit form dan verifikasi perilaku validasi serta status simpan.

Alur validasi manual juga dapat diuji dengan:

- mengosongkan field wajib
- menghapus satu atau lebih foto wajib
- menghapus tanda tangan saat status kendaraan tidak bisa dipindahkan

## Scope dan Asumsi

Versi saat ini masih berada pada tahap prototype, dengan beberapa asumsi eksplisit:

- Pengambilan foto masih berupa simulasi, belum terhubung ke kamera device.
- Metadata GPS dan watermark dibuat secara lokal untuk kebutuhan demonstrasi.
- Proses online upload masih disimulasikan di level repository, belum terhubung ke backend.
- Penyimpanan draft masih menggunakan local storage.

Keputusan ini diambil agar assignment tetap fokus pada:

- alur form
- aturan validasi
- ketahanan draft
- kualitas struktur kode dasar

## Pengembangan Lanjutan yang Disarankan

- Integrasi kamera asli menggunakan `image_picker` atau native camera API
- Pengambilan geolocation aktual untuk setiap foto
- Integrasi API submit ke backend
- Validasi yang lebih kuat untuk lokasi kendaraan dan alasan kendaraan tidak bisa dipindahkan
- Unit test tambahan untuk controller dan repository
- Penambahan screenshot atau demo video untuk reviewer

## Status Project

Project ini berada pada tahap **assignment prototype** dan ditujukan untuk menunjukkan pendekatan implementasi, organisasi kode, serta product thinking untuk workflow inspeksi kendaraan pada konteks leasing.
