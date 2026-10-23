create extension if not exists pgcrypto;

create table if not exists public.applications (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  telegram_id text,
  username text,
  name text not null,
  direction text not null,
  about text not null,
  experience text,
  work_links text,
  socials text,
  motivation text,
  status text not null default 'new' check (status in ('new','reviewing','accepted','rejected')),
  admin_note text
);

create table if not exists public.news (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  title text not null,
  body text not null default '',
  image_url text,
  audio_url text,
  published boolean not null default true
);

create table if not exists public.demos (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  title text not null,
  artist text not null,
  cover_url text,
  audio_url text,
  description text,
  published boolean not null default true
);

-- API uses the service role key server-side. Do not expose it to the browser.
alter table public.applications enable row level security;
alter table public.news enable row level security;
alter table public.demos enable row level security;

-- Public read access is intentionally not granted here. The server API uses the service role key.
