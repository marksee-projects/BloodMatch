import fs from 'node:fs';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { phpCommand } from './php-command.mjs';
const php = phpCommand();
function run(args) {
  const result = spawnSync(php, args, { encoding: 'utf8' });
  if (result.status !== 0) { process.stderr.write(result.stderr || result.stdout || 'PHP check failed.'); process.exit(1); }
  return result.stdout;
}
function files(dir) { return fs.readdirSync(dir,{withFileTypes:true}).flatMap(entry => entry.isDirectory() ? files(path.join(dir,entry.name)) : [path.join(dir,entry.name)]); }
const source = [...files('backend/src'), ...files('backend/public')].filter(file => file.endsWith('.php'));
for (const file of source) run(['-l',file]);
console.log('PHP syntax passed for ' + source.length + ' application files.');
for (const file of ['session_identity_offline.php','workflow_lock_offline.php','chat_offline.php','v2_environment_offline.php']) {
  process.stdout.write(run([path.join('tests',file)]));
}
console.log('Selected offline checks passed. No SQL, SMTP, or scheduled tasks ran.');
