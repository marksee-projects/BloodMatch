import fs from 'node:fs';
import { spawnSync } from 'node:child_process';
import { phpCommand } from './php-command.mjs';
let failed = false;
function check(ok, message) { console.log((ok ? 'OK ' : 'FAIL ') + message); if (!ok) failed = true; }
check(Number(process.versions.node.split('.')[0]) >= 24, 'Node.js 24+ (recommended release in .nvmrc)');
try {
  const result = spawnSync(phpCommand(), ['-r', 'exit(version_compare(PHP_VERSION,"8.2",">=") && extension_loaded("pdo_mysql") ? 0 : 1);'], { encoding: 'utf8' });
  check(result.status === 0, 'PHP 8.2+ and PDO MySQL');
} catch (error) { check(false, error.message); }
check(fs.existsSync('frontend/node_modules/vite'), 'Frontend dependencies installed');
check(fs.existsSync('.env'), 'Local .env exists');
if (fs.existsSync('.env')) {
  const lines = fs.readFileSync('.env', 'utf8').split(/\r?\n/);
  const values = Object.fromEntries(lines.filter(line => line && !line.startsWith('#') && line.includes('=')).map(line => { const i = line.indexOf('='); return [line.slice(0,i).trim(),line.slice(i+1).trim()]; }));
  check(values.DB_NAME === 'bloodmatch_v2', 'Separate v2 development database selected');
  check(['SAFETY_AUTOMATION_ENABLED','EMAIL_WORKER_ENABLED','MEMBERSHIP_EMAIL_ENABLED','DONATION_FOLLOWUP_ENABLED'].every(name => values[name] === '0'), 'Background workers disabled for initial development');
}
console.log('No SQL is performed. Database connectivity and schema need separate verification.');
process.exitCode = failed ? 1 : 0;
