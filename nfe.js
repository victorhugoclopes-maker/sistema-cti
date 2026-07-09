// ============================================
// LEITOR DE XML DE NOTA FISCAL (NF-e)
// Extrai os itens da nota (código, nome, quantidade, valor)
// ============================================

function lerXmlNFe(textoXml) {
  const parser = new DOMParser();
  const xml = parser.parseFromString(textoXml, 'text/xml');

  const erroParser = xml.querySelector('parsererror');
  if (erroParser) {
    throw new Error('Arquivo XML inválido ou corrompido');
  }

  const numeroNota = xml.querySelector('ide > nNF')?.textContent || '';
  const nomeFornecedor = xml.querySelector('emit > xNome')?.textContent || '';

  const dets = xml.querySelectorAll('det');
  const itens = [];

  dets.forEach(det => {
    const prod = det.querySelector('prod');
    if (!prod) return;
    itens.push({
      codigo: prod.querySelector('cProd')?.textContent || '',
      nome: prod.querySelector('xProd')?.textContent || '',
      unidade: prod.querySelector('uCom')?.textContent || 'UN',
      quantidade: parseFloat(prod.querySelector('qCom')?.textContent || '0'),
      valorUnitario: parseFloat(prod.querySelector('vUnCom')?.textContent || '0'),
    });
  });

  if (itens.length === 0) {
    throw new Error('Nenhum item encontrado no XML. Verifique se é um arquivo de NF-e válido.');
  }

  return { numeroNota, nomeFornecedor, itens };
}
