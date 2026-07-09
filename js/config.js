// ============================================
// CONFIGURAÇÃO — preencha com os dados do seu projeto Supabase
// (Project Settings > API)
// ============================================
const SUPABASE_URL = 'COLE_AQUI_SUA_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'COLE_AQUI_SUA_SUPABASE_ANON_KEY';

const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Verifica se está logado, senão manda pra tela de login
async function protegerPagina() {
  const { data: { session } } = await supabaseClient.auth.getSession();
  if (!session) {
    window.location.href = 'index.html';
  }
  return session;
}

async function fazerLogout() {
  await supabaseClient.auth.signOut();
  window.location.href = 'index.html';
}

function formatarData(dataStr) {
  if (!dataStr) return '-';
  const [ano, mes, dia] = dataStr.split('-');
  return `${dia}/${mes}/${ano}`;
}
