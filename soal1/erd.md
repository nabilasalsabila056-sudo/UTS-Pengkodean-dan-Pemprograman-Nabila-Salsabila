# Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    chart_of_accounts ||--o{ journal_lines : "memiliki"
    journal_headers ||--o{ journal_lines : "memiliki"

    chart_of_accounts {
        int account_id PK
        varchar kode_akun
        varchar nama_akun
        varchar saldo_normal
        varchar klasifikasi_laporan
    }

    journal_headers {
        int header_id PK
        date tanggal_transaksi
        varchar nomor_referensi
        text deskripsi
        varchar status_posting
    }

    journal_lines {
        int line_id PK
        int header_id FK
        int account_id FK
        numeric debit
        numeric credit
    }