-- Adiciona valor unitário nas peças usadas em OS (pra orçamento automático)
-- Rode isso no SQL Editor do Supabase

alter table os_pecas add column if not exists valor_unitario numeric default 0;
alter table ordens_servico add column if not exists mao_de_obra numeric default 0;
alter table ordens_servico add column if not exists cliente_nome_texto text; -- guarda o nome quando não houver cliente cadastrado vinculado (ex: importação de planilha antiga)
alter table ordens_servico add column if not exists tecnico text; -- nome do técnico responsável pela OS

-- Necessário pra permitir "upsert" (atualizar se já existe, criar se não existe) na importação de orçamentos
-- ⚠️ Se der erro "could not create unique index" aqui, significa que já existem números de OS duplicados no banco.
-- Rode esta consulta pra descobrir quais são os duplicados, apague os repetidos manualmente e tente de novo:
-- select numero_os, count(*) from ordens_servico group by numero_os having count(*) > 1;
create unique index if not exists idx_os_numero_unico on ordens_servico(numero_os);
