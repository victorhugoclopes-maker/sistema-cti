-- Schema do Sistema CTI Máquinas e Equipamentos
-- Rode isso no SQL Editor do Supabase (Project > SQL Editor > New query)

-- Tabela de Clientes
create table clientes (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  empresa text,
  telefone text,
  endereco text,
  observacoes text,
  criado_em timestamptz default now()
);

-- Tabela de Equipamentos (balanças, etc.)
create table equipamentos (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete cascade,
  tipo text, -- ex: Balança, Impressora, etc.
  marca text,
  modelo text,
  numero_serie text,
  capacidade text, -- ex: 15kg, 30kg
  ultima_calibracao date,
  proxima_calibracao date,
  observacoes text,
  criado_em timestamptz default now()
);

-- Tabela de Ordens de Serviço
create table ordens_servico (
  id uuid primary key default gen_random_uuid(),
  numero_os text not null unique,
  orcamento text, -- deve ser igual ao numero_os por padrão da empresa
  cliente_id uuid references clientes(id),
  equipamento_id uuid references equipamentos(id),
  descricao_defeito text,
  causa text, -- célula de carga, placa eletrônica, etc.
  servico_realizado text,
  status text default 'aberta', -- aberta, em_andamento, concluida
  valor text,
  data_abertura date default current_date,
  data_conclusao date,
  criado_em timestamptz default now()
);

-- Índices úteis
create index idx_equipamentos_cliente on equipamentos(cliente_id);
create index idx_os_cliente on ordens_servico(cliente_id);
create index idx_os_status on ordens_servico(status);

-- Habilitar acesso (RLS simples - ajuste depois se quiser mais segurança)
alter table clientes enable row level security;
alter table equipamentos enable row level security;
alter table ordens_servico enable row level security;

create policy "acesso total autenticado" on clientes for all using (auth.role() = 'authenticated');
create policy "acesso total autenticado" on equipamentos for all using (auth.role() = 'authenticated');
create policy "acesso total autenticado" on ordens_servico for all using (auth.role() = 'authenticated');
