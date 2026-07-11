// ============================================
// CONFIGURAÇÃO — preencha com os dados do seu projeto Supabase
// (Project Settings > API)
// ============================================
const SUPABASE_URL = 'https://owtnikelnwzmirgnvety.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im93dG5pa2Vsbnd6bWlyZ252ZXR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM1NDEwNDAsImV4cCI6MjA5OTExNzA0MH0.1VUYAN6uq7AneDPyD7SUrIGOCn0UsuRCy-6bYnYY5_k';

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
