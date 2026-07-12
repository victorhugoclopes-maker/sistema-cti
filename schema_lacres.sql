-- Controle de Lacres (pacotes de 100, atribuídos a técnicos)
-- Rode isso no SQL Editor do Supabase

create table lacres_pacotes (
  id uuid primary key default gen_random_uuid(),
  tipo text not null default 'Lacre', -- 'Lacre' ou 'Selo IPEM'
  numero_inicial bigint not null,
  numero_final bigint not null,
  tecnico text,
  data_atribuicao date default current_date,
  observacoes text,
  criado_em timestamptz default now()
);

create index idx_lacres_range on lacres_pacotes(numero_inicial, numero_final);

-- Caso já tenha rodado uma versão anterior deste arquivo sem a coluna "tipo":
alter table lacres_pacotes add column if not exists tipo text default 'Lacre';

-- Registro de uso individual (debita um número específico quando é usado numa OS)
create table lacres_usados (
  id uuid primary key default gen_random_uuid(),
  tipo text not null default 'Lacre',
  numero bigint not null,
  numero_os text, -- número da OS onde foi usado (texto livre, nem sempre é uma OS do sistema)
  tecnico text,
  data_uso date default current_date,
  criado_em timestamptz default now()
);

create unique index idx_lacre_usado_unico on lacres_usados(tipo, numero); -- não deixa marcar o mesmo número 2x

alter table lacres_usados enable row level security;
create policy "acesso total autenticado" on lacres_usados for all using (auth.role() = 'authenticated');

alter table lacres_pacotes enable row level security;
create policy "acesso total autenticado" on lacres_pacotes for all using (auth.role() = 'authenticated');
