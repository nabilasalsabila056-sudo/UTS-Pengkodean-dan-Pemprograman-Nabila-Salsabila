# Spesifikasi Backend & Audit Trail

## Mekanisme Immutability (Locking POSTED Transactions)
Untuk mencegah perubahan pada transaksi yang sudah `POSTED`, kita menggunakan Database Trigger di PostgreSQL.

```sql
CREATE OR REPLACE FUNCTION prevent_posted_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status_posting = 'POSTED' THEN
        RAISE EXCEPTION 'Transaksi POSTED tidak boleh diubah/dihapus. Silakan buat jurnal pembalik (reversing entry).';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_update_posted
BEFORE UPDATE OR DELETE ON journal_headers
FOR EACH ROW
EXECUTE FUNCTION prevent_posted_change();