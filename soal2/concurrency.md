# Penanganan Concurrency (Race Condition)

## Masalah
Jika dua kasir memproses penjualan untuk item yang sama pada detik yang bersamaan ketika stok hanya tersisa 1 unit, maka bisa terjadi *overselling* (stok menjadi minus) jika tidak ada penguncian baris (row locking).

## Solusi: SELECT ... FOR UPDATE
Teknik ini mengunci baris data di tabel `inventory_items` sampai transaksi selesai (COMMIT atau ROLLBACK). Transaksi kedua harus menunggu transaksi pertama selesai.

### Contoh Cuplikan Kode (Di Backend/Stored Procedure)
```sql
BEGIN;

-- Kunci baris item yang akan dijual
SELECT stock_qty 
FROM inventory_items 
WHERE item_id = 'ITM001' 
FOR UPDATE;

-- Cek stok (logika bisnis)
-- Jika stok >= 1, lakukan UPDATE
UPDATE inventory_items 
SET stock_qty = stock_qty - 1 
WHERE item_id = 'ITM001';

-- Insert transaksi
INSERT INTO inventory_transactions(item_id, trx_type, qty)
VALUES ('ITM001', 'SALE', 1);

COMMIT;