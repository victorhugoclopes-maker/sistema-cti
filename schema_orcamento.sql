-- Adiciona valor unitário nas peças usadas em OS (pra orçamento automático)
-- Rode isso no SQL Editor do Supabase

alter table os_pecas add column if not exists valor_unitario numeric default 0;
alter table ordens_servico add column if not exists mao_de_obra numeric default 0;
