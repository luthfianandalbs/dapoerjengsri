# UTS Pengembangan dan Operasi 2526

Pada soal UTS ini, setiap kelompok diminta untuk menyelesaikan studi kasus terkait permasalahan dalam pengembangan aplikasi yang membutuhkan proses deployment aplikasi secara cepat kepada pengguna. Aplikasi yang digunakan adalah aplikasi yang dikembangkan oleh masing-masing kelompok.

Deployment aplikasi **wajib menggunakan container** seperti **Docker** atau **Podman**. Untuk penerapan solusi, setiap kelompok wajib menerapkan konsep **Continuous Integration (CI)** dan **Continuous Deployment (CD)**.

---

## 📝 **Matriks Penilaian**

| Komponen | Poin |
| --- | --- |
| Penggunaan container | 50 poin |
| Implementasi CI/CD | 20 poin |
| Video penjelasan implementasi | 20 poin |
| Kelengkapan & kerapian laporan | 10 poin |
| **Total** | **100 poin** |

---

## 📄 **Format dan Isi Laporan**

Setiap kelompok wajib membuat laporan yang berisi:

1. **Nama aplikasi** dan **nama lengkap seluruh anggota kelompok**
2. **Deskripsi singkat aplikasi** serta **cara penggunaannya**
3. **Informasi detail aplikasi**, termasuk:
    - teknologi yang digunakan
    - struktur folder (singkat)
    - referensi sumber code/aplikasi (jika memakai template/open source)
4. **Daftar file pendukung** atau aplikasi tambahan yang digunakan
5. **Link video penjelasan implementasi deployment** menggunakan container
6. **Link video penjelasan implementasi CI/CD** pada container tersebut
7. **Link repositori Github.**
8. Penjelasan mengenai Jobdesk masing-masing anggota.

---

## ℹ️ **Ketentuan Tambahan (Penting!)**

**Setiap anggota** wajib **mengupload file laporan yang sama** ke sistem.

Artinya:

- 1 laporan untuk 1 kelompok
- tetapi dikumpulkan oleh semua anggota kelompok

Jika ada anggota yang tidak mengupload, nilai individu **dapat dikurangi**.

---

## 📄 **Penamaan File**

Gunakan format berikut:

```csharp
UTS-NamaKelompok-NIM anda.pdf

```

Contoh:

```
UTS-playdevco-172111151.pddf

```

---

## 🗃️ **Format File**

Laporan harus dikumpulkan dalam format **PDF**.

---

## 📽️ **Output Video**

- Upload video ke Microsoft Stream atau One Drive
- Pastikan link terbuka untuk dosen
- Kualitas minimal 720p
- Durasi rekomendasi: 5–10 menit

---

## **🎥 Isi Video Deployment Container**

Video harus menjelaskan:

- build container
- run container
- akses aplikasi
- penjelasan isi dari Dockerfile/Podmanfile

---

## **🎥 Isi Video CI/CD**

Video harus menunjukkan:

- alur pipeline (contoh: GitHub Actions, GitLab CI, Jenkins, Azure Pipeline, dsb.)
- trigger otomatis (push/merge)
- hasil build/deploy sukses (log)

---

## ✅ **Catatan Penting**

- Aplikasi harus dapat **berjalan** di container.
- CI/CD harus **ditunjukkan** buktinya.
- Laporan dibuat **rapi, padat, dan mudah dipahami**.
- pastikan video dapat diakses secara publik
- pastikan link repo github dapat diakses secara publik, jika private add username **qee20** pada repo anda.

---

# 📌 Checklist Sebelum Submit

✔ aplikasi berjalan via container

✔ pipeline CI/CD berjalan otomatis

✔ link video valid

✔ seluruh anggota submit

✔ penamaan file sesuai format

✔ laporan dalam PDF