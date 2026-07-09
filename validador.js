// ============================================
// VALIDADOR ITENSMGV.TXT — Version 4
// Ajuste as regras abaixo conforme a especificação exata
// (Especificacao_ItensMGV7.docx) já validada anteriormente.
// ============================================

// Configuração básica — ajuste conforme a spec real
const CONFIG_VALIDACAO = {
  separador: ';',           // separador de campos usado no arquivo
  numeroColunasEsperado: 10, // ajuste para o número real de colunas da Version 4
  colunasObrigatorias: [0, 1], // índices (0-based) de colunas que não podem estar vazias
};

function validarItensMGV(conteudo) {
  const linhas = conteudo.split(/\r?\n/).filter(l => l.trim().length > 0);
  const erros = [];

  linhas.forEach((linha, idx) => {
    const numeroLinha = idx + 1;
    const campos = linha.split(CONFIG_VALIDACAO.separador);

    if (campos.length !== CONFIG_VALIDACAO.numeroColunasEsperado) {
      erros.push(`Linha ${numeroLinha}: esperado ${CONFIG_VALIDACAO.numeroColunasEsperado} colunas, encontrado ${campos.length}`);
    }

    CONFIG_VALIDACAO.colunasObrigatorias.forEach(col => {
      if (!campos[col] || campos[col].trim() === '') {
        erros.push(`Linha ${numeroLinha}: coluna obrigatória ${col + 1} está vazia`);
      }
    });
  });

  return { linhas: linhas.length, erros };
}
