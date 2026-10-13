# UTS Coding Akuntansi

### Semester Gasal 2026/2027

![Status: Selesai](https://img.shields.io/badge/Status-Selesai-2ea44f)
![Bahasa: SQL, JavaScript, HTML](https://img.shields.io/badge/Bahasa-SQL%2C%20JavaScript%2C%20HTML-blue)

> Repositori tugas Ujian Tengah Semester mata kuliah Pemrograman / Pengkodean  
> Departemen Akuntansi, Fakultas Ekonomika dan Bisnis, Universitas Diponegoro.

---

<a id="identitas"></a>
## 🪪 Identitas

| Informasi | Keterangan |
|---|---|
| Nama | Nabila Salsabila |
| NIM | 12030124140240 |
| Kelas | D |
| Mata Kuliah | Pemrograman / Pengkodean |
| Dosen | Dr. Totok Dewayanto, S.E., M.Si., Akt., CA |
| Universitas | Universitas Diponegoro (UNDIP) |
| Fakultas / Departemen | FEB / Akuntansi |
| Semester | Gasal 2026/2027 |
| Repositori GitHub | [ISI LINK GITHUB KAMU] |
| Google Drive (backup, opsional) | [ISI LINK DRIVE KAMU, OPSIONAL] |

---

<a id="deskripsi-singkat"></a>
## 📘 Deskripsi Singkat

Ujian Tengah Semester (UTS) ini menguji penerapan pemrograman dalam konteks
akuntansi, khususnya perancangan data, otomasi proses bisnis, dan pengembangan
purwarupa aplikasi. Pengerjaan menggabungkan pemahaman konsep akuntansi dengan
implementasi teknis yang dapat ditelaah dan diuji.

Repositori ini memuat tiga soal yang saling berkaitan. Soal pertama menyusun
fondasi data jurnal dan asas berpasangan; soal kedua menerapkan otomasi serta
pengendalian persediaan; sedangkan soal ketiga menyajikan purwarupa web untuk
entri jurnal kas keluar beserta kontrol keseimbangan dan audit trail.

Artefak yang disediakan meliputi rancangan ERD, skrip SQL, analisis concurrency,
purwarupa antarmuka, dokumentasi backend, catatan prompt AI, verifikasi PSAK,
serta laporan lengkap dalam format HTML.

---

<a id="daftar-isi"></a>
## 🧭 Daftar Isi

1. [Identitas](#identitas)
2. [Deskripsi Singkat](#deskripsi-singkat)
3. [Daftar Isi](#daftar-isi)
4. [Ringkasan per Soal](#ringkasan-per-soal)
   - [Soal 1 — Arsitektur Data dan Normalisasi](#soal-1--arsitektur-data-dan-normalisasi)
   - [Soal 2 — Otomasi Persediaan dan Concurrency](#soal-2--otomasi-persediaan-dan-concurrency)
   - [Soal 3 — Purwarupa Web dan Orkestrasi AI](#soal-3--purwarupa-web-dan-orkestrasi-ai)
5. [Struktur Repositori](#struktur-repositori)
6. [Cara Menjalankan](#cara-menjalankan)
7. [Teknologi yang Digunakan](#teknologi-yang-digunakan)
8. [Hasil Pembelajaran](#hasil-pembelajaran)
9. [Catatan Pengerjaan](#catatan-pengerjaan)
10. [Footer](#footer)

---

<a id="ringkasan-per-soal"></a>
## 📝 Ringkasan per Soal

### Soal 1 — Arsitektur Data dan Normalisasi

**Bobot: 25%**

#### Deskripsi

Soal ini merancang struktur data jurnal umum untuk mendukung pencatatan yang
terjaga konsistensinya. Model terdiri atas tabel `chart_of_accounts`,
`journal_headers`, dan `journal_lines`.

Rancangan ERD menunjukkan relasi antara daftar akun, header jurnal, dan baris
jurnal. DDL PostgreSQL menetapkan primary key, foreign key dengan aturan
`ON DELETE RESTRICT`, serta constraint untuk menjaga nilai dan asas pencatatan
berpasangan.

Pembahasan juga mencakup normalisasi hingga 3NF dan audit trail, termasuk
pemisahan informasi akun, informasi transaksi, dan rincian debit/kredit agar
data lebih konsisten dan dapat ditelusuri.

#### Tools yang digunakan

- PostgreSQL untuk definisi struktur dan aturan integritas data.
- Mermaid untuk menggambarkan relasi ERD.
- Markdown untuk mendokumentasikan model dan analisis.

#### File terkait

- [`soal1/erd.md`](soal1/erd.md) — diagram ERD dan entitas.
- [`soal1/ddl.sql`](soal1/ddl.sql) — skrip pembuatan tabel dan constraint.
- `images/erd.png` — pratinjau diagram ERD.
- `images/ddl_supabase.png` — pratinjau eksekusi DDL.

#### Screenshot preview

![Diagram ERD untuk chart of accounts dan jurnal](images/erd.png)

![Eksekusi DDL pada PostgreSQL sandbox](images/ddl_supabase.png)

---

### Soal 2 — Otomasi Persediaan dan Concurrency

**Bobot: 40%**

#### Deskripsi

Soal ini membangun fungsi trigger PostgreSQL
`trg_update_stock_and_journal()` untuk memperbarui jumlah stok secara otomatis
setelah transaksi persediaan dimasukkan ke `inventory_transactions`.

Transaksi pembelian menambah stok, transaksi penjualan mengurangi stok, dan
penyesuaian mencatat perubahan persediaan. Jika penjualan melebihi stok yang
tersedia, fungsi mengeluarkan `RAISE EXCEPTION` sehingga perubahan yang tidak
valid ditolak.

Analisis concurrency menjelaskan risiko *overselling* ketika beberapa transaksi
mengakses item yang sama. Penguncian baris dengan `SELECT ... FOR UPDATE`
membuat transaksi lain menunggu sampai transaksi pemegang kunci selesai.

#### Tools yang digunakan

- PostgreSQL dan PL/pgSQL untuk trigger function dan otomasi stok.
- `SELECT ... FOR UPDATE` untuk membahas pengendalian akses bersamaan.
- Markdown untuk dokumentasi skenario race condition.

#### File terkait

- [`soal2/trigger.sql`](soal2/trigger.sql) — tabel persediaan, fungsi, dan trigger.
- [`soal2/concurrency.md`](soal2/concurrency.md) — analisis concurrency.
- `images/trigger_check.png` — pratinjau pemeriksaan trigger.
- `images/purchase_items.png` — pratinjau transaksi pembelian persediaan.

#### Screenshot preview

![Pemeriksaan otomasi trigger persediaan](images/trigger_check.png)

![Contoh item persediaan setelah transaksi pembelian](images/purchase_items.png)

---

### Soal 3 — Purwarupa Web dan Orkestrasi AI

**Bobot: 35%**

#### Deskripsi

Soal ini mengintegrasikan purwarupa web full-stack untuk entri jurnal kas keluar.
Antarmuka menyediakan baris akun dengan nilai debit dan kredit serta indikator
langsung untuk memperlihatkan apakah total debit sama dengan total kredit.

Komponen audit trail yang dibahas mencakup identitas pembuat (`created_by`),
waktu pencatatan (`created_at`), dan checksum (`hash_checksum`) berbasis
SHA-256. Pada sisi database, trigger `prevent_posted_change()` digunakan untuk
mencegah perubahan atas transaksi yang sudah berstatus `POSTED`.

Aturan bisnis purwarupa diverifikasi menggunakan NotebookLM dengan rujukan
PSAK 1 (201) dan PSAK 2 (207). Prompt Gemini Canvas untuk menghasilkan UI dan
ringkasan verifikasi didokumentasikan agar proses penggunaan AI dapat ditinjau.

#### Tools yang digunakan

- React 18 dan Tailwind CSS untuk rancangan UI.
- HTML, CSS, dan JavaScript untuk purwarupa browser.
- Gemini Canvas untuk membantu generasi antarmuka.
- NotebookLM untuk membantu verifikasi aturan bisnis terhadap referensi PSAK.
- PostgreSQL untuk rancangan trigger dan kontrol transaksi.

#### File terkait

- [`soal3/frontend/index.html`](soal3/frontend/index.html) — purwarupa antarmuka.
- [`soal3/backend.md`](soal3/backend.md) — spesifikasi backend dan audit trail.
- [`soal3/prompt_gemini.md`](soal3/prompt_gemini.md) — prompt UI Gemini Canvas.
- [`soal3/verifikasi_notebooklm.md`](soal3/verifikasi_notebooklm.md) — ringkasan verifikasi.
- `images/form_balanced.png` — tampilan jurnal seimbang.
- `images/form_notbalanced.png` — tampilan jurnal belum seimbang.
- `images/audit_log.png` — pratinjau pencatatan audit.

#### Screenshot preview

![Form jurnal dengan total debit dan kredit seimbang](images/form_balanced.png)

![Form jurnal dengan total debit dan kredit belum seimbang](images/form_notbalanced.png)

![Pratinjau audit log](images/audit_log.png)

---

<a id="struktur-repositori"></a>
## 🗂️ Struktur Repositori

```text
uts-coding-akuntansi/
├── README.md
├── laporan.html
├── images/
│   ├── erd.png
│   ├── ddl_supabase.png
│   ├── trigger_check.png
│   ├── purchase_items.png
│   ├── form_balanced.png
│   ├── form_notbalanced.png
│   └── audit_log.png
├── soal1/
│   ├── erd.md
│   └── ddl.sql
├── soal2/
│   ├── trigger.sql
│   └── concurrency.md
└── soal3/
    ├── frontend/
    │   └── index.html
    ├── backend.md
    ├── prompt_gemini.md
    └── verifikasi_notebooklm.md
```

### Keterangan folder dan file

- **`images/`** — screenshot pendukung untuk ERD, eksekusi database,
  otomasi persediaan, form jurnal, dan audit log.
- **`soal1/`** — rancangan ERD dan DDL untuk struktur akun serta jurnal.
- **`soal2/`** — trigger otomasi stok dan analisis pengendalian concurrency.
- **`soal3/frontend/`** — halaman purwarupa web yang dapat dibuka di browser.
- **`soal3/`** — dokumentasi backend, prompt Gemini, dan verifikasi NotebookLM.
- **`laporan.html`** — laporan tugas lengkap dalam format HTML.
- **`README.md`** — panduan, ringkasan, dan navigasi isi repositori.

---

<a id="cara-menjalankan"></a>
## ▶️ Cara Menjalankan

### Prasyarat

- PostgreSQL yang dapat diakses melalui sandbox, Supabase, atau Neon.
- Git untuk mengambil repositori.
- Browser modern seperti Chrome, Firefox, Edge, atau Safari.
- Koneksi ke instance PostgreSQL apabila menjalankan skrip database secara daring.

### Langkah-langkah

1. **Clone repositori**

   Ganti alamat di bawah ini dengan URL GitHub repositori yang sebenarnya.

   ```bash
   git clone [URL-REPOSITORI-GITHUB]
   cd uts-coding-akuntansi
   ```

2. **Jalankan DDL Soal 1**

   Buka `soal1/ddl.sql` pada SQL editor PostgreSQL sandbox, lalu jalankan skrip
   untuk membuat tabel akun dan jurnal beserta constraint-nya.

3. **Jalankan trigger Soal 2**

   Buka `soal2/trigger.sql` pada SQL editor PostgreSQL sandbox, lalu jalankan
   skrip untuk membuat struktur transaksi persediaan dan mengaktifkan otomasi
   perubahan stok.

4. **Buka purwarupa web**

   Buka `soal3/frontend/index.html` menggunakan browser modern untuk melihat
   form entri jurnal kas keluar dan indikator keseimbangannya.

5. **Baca laporan lengkap**

   Buka `laporan.html` menggunakan browser untuk melihat laporan tugas secara
   menyeluruh.

> Jalankan skrip pada database yang sesuai dan periksa hasil setiap perintah
> sebelum menggunakan objek database tersebut.

---

<a id="teknologi-yang-digunakan"></a>
## 🧰 Teknologi yang Digunakan

| Teknologi | Kegunaan | Versi |
|---|---|---|
| PostgreSQL / Supabase | Database relasional dan sandbox untuk menjalankan SQL | Versi layanan / instance |
| SQL | DDL, constraint, query, dan definisi trigger | Tidak ditentukan |
| PL/pgSQL | Implementasi fungsi trigger PostgreSQL | Mengikuti versi PostgreSQL |
| HTML, CSS, JavaScript | Struktur, tampilan, dan interaksi purwarupa frontend | Tidak ditentukan |
| React | Komponen dan interaksi UI | 18 |
| Tailwind CSS | Styling antarmuka berbasis utility | Tidak ditentukan |
| Gemini Canvas | Bantuan generasi rancangan UI | Layanan daring |
| NotebookLM | Bantuan verifikasi aturan bisnis dengan sumber PSAK | Layanan daring |
| Git + GitHub | Version control dan publikasi repositori | Tidak ditentukan |
| Mermaid | Visualisasi ERD di dalam Markdown | Tidak ditentukan |

---

<a id="hasil-pembelajaran"></a>
## 🎓 Hasil Pembelajaran

Pengerjaan UTS ini menghubungkan capaian pembelajaran mata kuliah dan program
studi dengan praktik teknis pemrograman akuntansi. Capaian yang menjadi konteks
pembahasan meliputi **CPL-3**, **CPL-4**, **CPMK-1**, **CPMK-2**, dan **CPMK-3**.

Melalui tiga soal yang terintegrasi, pembelajaran berfokus pada kemampuan untuk:

- Menerjemahkan kebutuhan pencatatan akuntansi ke dalam model data relasional.
- Menerapkan normalisasi, primary key, foreign key, dan constraint untuk
  menjaga integritas data.
- Memahami asas berpasangan melalui pencatatan debit dan kredit.
- Mengotomasi proses bisnis dengan fungsi dan trigger database.
- Menganalisis konsistensi stok serta risiko concurrency pada transaksi serentak.
- Merancang purwarupa web dengan indikator validasi jurnal secara langsung.
- Memahami peran audit trail dan pembatasan perubahan transaksi yang sudah
  diposting.
- Menggunakan AI secara terarah untuk membantu generasi UI dan penelaahan
  aturan bisnis.

### Skill yang diperoleh

| Area | Keterampilan |
|---|---|
| SQL modeling | ERD, normalisasi, DDL, relasi, dan constraint |
| Database programming | PL/pgSQL, trigger, validasi, dan `RAISE EXCEPTION` |
| Transaction control | Pemahaman row locking dengan `SELECT ... FOR UPDATE` |
| Web development | Purwarupa form jurnal, interaksi, dan indikator keseimbangan |
| Auditability | Konsep audit trail, checksum, dan transaksi `POSTED` |
| AI orchestration | Pemanfaatan Gemini Canvas dan NotebookLM secara terdokumentasi |

---

<a id="catatan-pengerjaan"></a>
## 🗒️ Catatan Pengerjaan

- **Waktu ujian:** Senin, 19 Oktober 2026.
- **Durasi:** 120 menit.
- **Sifat ujian:** Open Book / Open AI / Open Code Sandbox.
- **Tools AI yang digunakan:** Gemini Canvas untuk bantuan UI dan NotebookLM
  untuk membantu verifikasi aturan bisnis.
- **Referensi standar:** PSAK 1 (201) dan PSAK 2 (207), sesuai cakupan tugas.
- **Dokumentasi proses AI:** Lihat `soal3/prompt_gemini.md` dan
  `soal3/verifikasi_notebooklm.md`.
- **Catatan reproduksibilitas:** Versi PostgreSQL, Tailwind CSS, dan Git tidak
  dicantumkan secara spesifik; sesuaikan dengan lingkungan yang digunakan.

---

<a id="footer"></a>
## 🏛️ Footer

**Fakultas Ekonomika dan Bisnis — Universitas Diponegoro**  
Departemen Akuntansi · 2026

---

> Terima kasih telah mengunjungi repositori UTS Coding Akuntansi ini.
