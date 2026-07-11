-- Adiciona controle de "estoque do carro" (peças que o técnico carrega)
-- separado do estoque geral (armazém)
-- Rode isso no SQL Editor do Supabase

alter table pecas add column if not exists quantidade_carro numeric default 0;
alter table pecas add column if not exists estoque_ideal_carro numeric default 0; -- quantidade que deveria sempre ter no carro (o "3" do "2/3")
