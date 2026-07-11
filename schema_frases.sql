-- Frases prontas que o usuário pode criar e reutilizar nos campos da OS
-- Rode isso no SQL Editor do Supabase

create table frases_rapidas (
  id uuid primary key default gen_random_uuid(),
  campo text not null, -- 'causa', 'defeito' ou 'servico'
  texto text not null,
  criado_em timestamptz default now()
);

alter table frases_rapidas enable row level security;
create policy "acesso total autenticado" on frases_rapidas for all using (auth.role() = 'authenticated');
