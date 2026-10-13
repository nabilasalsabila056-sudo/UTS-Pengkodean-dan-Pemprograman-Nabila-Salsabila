-- 1. Tabel Chart of Accounts
CREATE TABLE chart_of_accounts (
    account_id SERIAL PRIMARY KEY,
    kode_akun VARCHAR(20) UNIQUE NOT NULL,
    nama_akun VARCHAR(100) NOT NULL,
    saldo_normal VARCHAR(10) NOT NULL CHECK (saldo_normal IN ('DEBIT','KREDIT')),
    klasifikasi_laporan VARCHAR(50) NOT NULL
);

-- 2. Tabel Journal Headers
CREATE TABLE journal_headers (
    header_id SERIAL PRIMARY KEY,
    tanggal_transaksi DATE NOT NULL,
    nomor_referensi VARCHAR(50) UNIQUE NOT NULL,
    deskripsi TEXT,
    status_posting VARCHAR(20) NOT NULL DEFAULT 'DRAFT'
        CHECK (status_posting IN ('DRAFT','POSTED','VOID'))
);

-- 3. Tabel Journal Lines
CREATE TABLE journal_lines (
    line_id SERIAL PRIMARY KEY,
    header_id INT NOT NULL,
    account_id INT NOT NULL,
    debit NUMERIC(18,2) NOT NULL DEFAULT 0 CHECK (debit >= 0),
    credit NUMERIC(18,2) NOT NULL DEFAULT 0 CHECK (credit >= 0),

    -- Foreign Key dengan ON DELETE RESTRICT
    CONSTRAINT fk_header FOREIGN KEY (header_id)
        REFERENCES journal_headers(header_id) ON DELETE RESTRICT,
    CONSTRAINT fk_account FOREIGN KEY (account_id)
        REFERENCES chart_of_accounts(account_id) ON DELETE RESTRICT,

    -- Constraint: Tidak boleh debit dan kredit nol bersamaan
    CONSTRAINT chk_tidak_nol CHECK (debit > 0 OR credit > 0),
    
    -- Constraint: Satu baris hanya boleh debit ATAU kredit (tidak keduanya)
    CONSTRAINT chk_satu_sisi CHECK (debit = 0 OR credit = 0)
);