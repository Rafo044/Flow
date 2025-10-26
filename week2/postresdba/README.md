# PostgreSQL Arxitekturası, Proses və Yaddaş İdarəetməsi

PostgreSQL, digər RDBMS-lər kimi əlaqəli verilənlər bazasının idarəetmə sistemidir (Relational Database Management System). Bu sistem məlumatları əlaqəli cədvəllər şəklində saxlayır və idarə edir.

---

## 1. Müştəri-Server Arxitekturası

PostgreSQL müştəri-server əsaslıdır. Müştəri tətbiqləri (`psql`, `pgAdmin`, Python, Java və s.) TCP/IP və ya Unix Socket vasitəsilə serverə qoşulur.

**PostMaster** – PostgreSQL-in əsas prosesi:

* Yeni bağlantıları qəbul edir (default port: 5432),
* Hər bir bağlantı üçün backend prosesi yaradır,
* Background və auxiliary prosesləri idarə edir,
* Serverin işə düşməsi və bağlanmasını nəzarətdə saxlayır,
* Proseslərin aktiv və idle vəziyyətlərini izləyir.

PostMaster, həmçinin background proseslərin aktivliyini və idle vəziyyətini idarə edir.

---

## 2. Backend Proseslər və Yaddaş

Hər backend prosesi yalnız bir müştəri bağlantısını idarə edir və yaddaşı iki hissəyə bölünür: **özəl (private)** və **paylaşılan (shared)**.

### Private Memory (Per Backend)

* **work_mem** – Sort, Hash join, Merge join, Bitmap əməliyyatları üçün ayrılır. Default 4 MB. Hər əməliyyat üçün ayrılır (per operation), yəni bir sorğuda bir neçə sort varsa, hər biri üçün ayrıca work_mem istifadə olunur.
* **temp_buffers** – Müvəqqəti cədvəllər üçün buffer. Default 8 MB.
* **Local Caches** – Daxili metadata (catalog cache, relcache) üçün istifadə olunur.
* **Connection State** – Sessiyanın tranzaksiya vəziyyəti, hazır ifadələr və session dəyişənləri saxlanılır.

**Work_mem Nümunəsi:**

* Bir sorğuda 3 sort əməliyyatı varsa, hər biri üçün 4 MB → toplam 12 MB istifadə olunur. Hash join əməliyyatları da bu yaddaşdan istifadə edir.

**Tuning :**

* Conservative: 4MB (çox sayda bağlantı)
* Moderate: 16–64MB (orta səviyyəli bağlantılar, mürəkkəb sorğular)
* Aggressive: 256MB–1GB (az bağlantı, analitik sorğular)
* Per-session tuning: `SET work_mem = '256MB';`

Maximum memory belə hesablanır:

```
Max memory ≈ work_mem × max_connections × avg_operations_per_query
```

### Shared Memory

* **Shared Buffers** – Disk səhifələrini RAM-da saxlayır. Məqsəd disk oxumalarını azaltmaq və sorğuları sürətləndirməkdir. Default 128 MB, RAM-ın 25%-i.
* **WAL Buffers** – Write-Ahead Log üçün istifadə olunur, məlumatların etibarlı saxlanmasını təmin edir.
* **Lock Tables** – Cədvəl və sətrlərə qoyulan kilidləri izləyir.
* **Process Information** – Aktiv və pasiv proseslər, tranzaksiya vəziyyətləri haqqında məlumat verir.

---

## 3. Background Proseslər

PostgreSQL-də background proseslər müxtəlif vəzifələri yerinə yetirir:

* **Background Writer** – Diskdəki dəyişiklikləri yayır, checkpointer işini asanlaşdırır.
* **Checkpointer** – Müəyyən intervallarla bütün dəyişiklikləri diskə `fsync` edir.
* **WAL Writer** – WAL buffers-dəki məlumatları diskə yazır.
* **WAL Archiver** – WAL fayllarını arxivləyir (backup və replikasiya üçün).
* **Autovacuum Launcher və Workers** – Ölü tuples-ları təmizləyir, statistikaları yeniləyir.
* **Stats Collector** – Server statistikasını toplayır.
* **Logical Replication Workers** – Verilənlərin replikasiyası üçün məlumatları hazırlayır.

### Dead Tuples və Autovacuum

* PostgreSQL-də bir sətir silindikdə, əslində dərhal diskdən silinmir, bu "dead tuple" olaraq qalır.
* **Autovacuum** launcher və workers bu tuples-ları təmizləyir və statistikaları yeniləyir.

---

## 4. Memory Flow: Query Execution

Bir sorğunun (`SELECT * FROM users ORDER BY created_at LIMIT 100`) icrası zamanı yaddaş və I/O axını:

1. **Parse və Plan** – Backend prosesin private yaddaşında parser və planner istifadə olunur.
2. **Read from Shared Buffers** – Məlumat səhifələri əvvəlcə cache-dən oxunur. Cache miss olduqda diskdən gətirilir.
3. **Sort in work_mem** – Sort əməliyyatı üçün work_mem istifadə olunur. Sığarsa in-memory sort, sığmazsa disk sort.
4. **Return Results** – Nəticələr müştəriyə qaytarılır.

---

## 5. Yaddaş Parametrləri və Planlama

* `shared_buffers` və OS page cache paralel işləyir, hər ikisi nəzərə alınmalıdır.
* `work_mem`, `temp_buffers`, `maintenance_work_mem` backend başına yaddaş istifadəni müəyyən edir.
* Connection pooling (PgBouncer, Pgpool-II) idle bağlantıların RAM istifadəsini azaldır.

---

## 6. Monitoring və Sorğular

**Aktiv proseslər:**

```sql
SELECT pid, usename, client_addr, client_port, backend_start, state, query, application_name
FROM pg_stat_activity
ORDER BY backend_start;
```

**Proses tipi və statusu:**

```sql
SELECT pid,
       CASE WHEN backend_type = 'client backend' THEN 'Client Backend' END AS process_types,
       CASE WHEN state IS NULL THEN 'Background Process' ELSE state END AS status
FROM pg_stat_activity;
```

**Yaddaş parametrləri:**

```sql
SELECT name, setting, unit, short_desc
FROM pg_settings
WHERE name IN ('maintenance_work_mem','work_mem','temp_buffers','max_connections');
```

---

## 7. Nəticə

Bu məqalədə PostgreSQL-in əsas arxitekturası, backend və background prosesləri, yaddaş idarəetməsi, work_mem və temp_buffers, shared_buffers, autovacuum, WAL və replikasiya ilə bağlı anlayışlar birləşdirilmiş şəkildə izah olunmuşdur.

Düzgün konfiqurasiya və monitorinq performansı artırır, resurs istifadəsini optimallaşdırır və verilənlərin etibarlı saxlanmasını təmin edir.
