// Connects the tracker to Supabase so shared boards are saved online.
// Leave both values empty and the app saves in each person's browser only.
//
// Find these in Supabase: Project Settings > API.
// - supabaseUrl: the Project URL, e.g. https://abcdefgh.supabase.co
// - supabaseAnonKey: the "anon public" key, or the "publishable" key on newer projects.
//
// The public key is safe to commit: the database only allows reading and
// saving one board at a time, by its link (see supabase/setup.sql).
// Never put the service_role or secret key here.
window.OR_CONFIG = {
  supabaseUrl: '',
  supabaseAnonKey: ''
};
