-- KATERINA v3 - Supabase database
-- Jalankan di Supabase SQL Editor.
create table if not exists public.screenings (
  id uuid primary key default gen_random_uuid(),
  animal_id text not null,
  student_name text not null,
  group_name text,
  inspection_date date not null default current_date,
  score integer not null,
  percent integer not null,
  status text not null,
  action text,
  teacher_name text,
  teacher_note text,
  created_at timestamptz not null default now()
);

alter table public.screenings enable row level security;

-- Uji coba kelas: izinkan anon membaca/menambah data.
-- Untuk penggunaan produksi, ganti dengan Auth + policy berbasis akun/kelas.
create policy "katerina read" on public.screenings
for select to anon using (true);

create policy "katerina insert" on public.screenings
for insert to anon with check (true);

create policy "katerina update" on public.screenings
for update to anon using (true) with check (true);

-- Pastikan tabel tersedia melalui Data API.
-- Di Supabase terbaru, expose tabel public.screenings pada Integrations/Data API.
