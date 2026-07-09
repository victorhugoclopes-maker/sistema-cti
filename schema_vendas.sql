-- Adição de Vendas ao Sistema CTI
-- Rode isso no SQL Editor do Supabase DEPOIS do schema.sql e schema_estoque.sql

-- Empresas emissoras (CNPJs diferentes)
create table empresas (
  id uuid primary key default gen_random_uuid(),
  nome text not null, -- ex: CTI Máquinas e Equipamentos
  cnpj text,
  criado_em timestamptz default now()
);

alter table empresas enable row level security;
create policy "acesso total autenticado" on empresas for all using (auth.role() = 'authenticated');

-- Já cadastra as duas empresas que vocês usam (edite os CNPJs corretos depois se quiser)
insert into empresas (nome, cnpj) values
  ('CTI Máquinas e Equipamentos', ''),
  ('Llebesai Reparação de Máquinas LTDA', '');

create table vendas (
  id uuid primary key default gen_random_uuid(),
  numero_venda text not null,
  cliente_id uuid references clientes(id),
  empresa_id uuid references empresas(id),
  data_venda date default current_date,
  valor_total numeric default 0,
  numero_nf text, -- número da nota fiscal, preenchido depois de emitir no Sebrae
  observacoes text,
  criado_em timestamptz default now()
);

create table vendas_itens (
  id uuid primary key default gen_random_uuid(),
  venda_id uuid references vendas(id) on delete cascade,
  peca_id uuid references pecas(id) on delete set null,
  nome_item text not null,
  quantidade numeric default 1,
  valor_unitario numeric default 0,
  criado_em timestamptz default now()
);

create index idx_vendas_cliente on vendas(cliente_id);
create index idx_vendasitens_venda on vendas_itens(venda_id);

alter table vendas enable row level security;
alter table vendas_itens enable row level security;

create policy "acesso total autenticado" on vendas for all using (auth.role() = 'authenticated');
create policy "acesso total autenticado" on vendas_itens for all using (auth.role() = 'authenticated');
