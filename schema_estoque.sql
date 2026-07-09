-- Adição de Estoque de Peças ao Sistema CTI
-- Rode isso no SQL Editor do Supabase DEPOIS do schema.sql original
-- (essas são tabelas NOVAS, não afeta o que já existe)

-- Tabela de Peças em estoque
create table pecas (
  id uuid primary key default gen_random_uuid(),
  codigo text,
  nome text not null,
  unidade text default 'UN',
  quantidade numeric default 0,
  preco_custo numeric,
  preco_venda numeric,
  estoque_minimo numeric default 0,
  criado_em timestamptz default now()
);

-- Histórico de movimentações (entradas por NF-e, saídas por uso em OS)
create table movimentacoes_estoque (
  id uuid primary key default gen_random_uuid(),
  peca_id uuid references pecas(id) on delete set null,
  tipo text not null, -- 'entrada' ou 'saida'
  quantidade numeric not null,
  motivo text, -- ex: 'NF-e 12345' ou 'OS 456'
  os_id uuid references ordens_servico(id) on delete set null,
  criado_em timestamptz default now()
);

-- Peças usadas em cada Ordem de Serviço
create table os_pecas (
  id uuid primary key default gen_random_uuid(),
  os_id uuid references ordens_servico(id) on delete cascade,
  peca_id uuid references pecas(id) on delete set null, -- fica nulo se o nome digitado não bateu com nenhuma peça do estoque
  nome_peca text not null,
  quantidade numeric default 1,
  criado_em timestamptz default now()
);

create index idx_movimentacoes_peca on movimentacoes_estoque(peca_id);
create index idx_ospecas_os on os_pecas(os_id);

alter table pecas enable row level security;
alter table movimentacoes_estoque enable row level security;
alter table os_pecas enable row level security;

create policy "acesso total autenticado" on pecas for all using (auth.role() = 'authenticated');
create policy "acesso total autenticado" on movimentacoes_estoque for all using (auth.role() = 'authenticated');
create policy "acesso total autenticado" on os_pecas for all using (auth.role() = 'authenticated');
