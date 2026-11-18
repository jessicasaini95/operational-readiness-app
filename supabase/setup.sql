-- Operational Readiness: database setup for shared boards.
-- Run this once in Supabase: SQL Editor > New query > paste > Run.
--
-- Each board is one row holding the whole tracker as JSON, keyed by a long
-- random id that lives in the board's link. The public key cannot read the
-- table directly or list boards; it can only call the two functions below,
-- and only with a board id it already knows.

create table if not exists public.boards (
  id          text primary key check (char_length(id) between 16 and 64),
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

alter table public.boards enable row level security;
revoke all on public.boards from anon, authenticated;

create or replace function public.get_board(p_id text)
returns table (data jsonb, updated_at timestamptz)
language sql
security definer
set search_path = public
as $$
  select b.data, b.updated_at
  from public.boards b
  where b.id = p_id;
$$;

create or replace function public.save_board(p_id text, p_data jsonb)
returns timestamptz
language plpgsql
security definer
set search_path = public
as $$
declare
  ts timestamptz;
begin
  if char_length(p_id) < 16 then
    raise exception 'Board id is too short';
  end if;
  if pg_column_size(p_data) > 2000000 then
    raise exception 'Board is too large';
  end if;

  insert into public.boards (id, data, updated_at)
  values (p_id, p_data, now())
  on conflict (id) do update
    set data = excluded.data,
        updated_at = now()
  returning boards.updated_at into ts;

  return ts;
end;
$$;

revoke all on function public.get_board(text) from public;
revoke all on function public.save_board(text, jsonb) from public;
grant execute on function public.get_board(text) to anon, authenticated;
grant execute on function public.save_board(text, jsonb) to anon, authenticated;
