import fs from 'node:fs';
import { spawnSync } from 'node:child_process';
export function phpCommand() {
  const candidates = [process.env.PHP_PATH, 'php', 'C:/xampp/php/php.exe', 'D:/xampp/php/php.exe'].filter(Boolean);
  for (const candidate of candidates) {
    if (candidate !== 'php' && !fs.existsSync(candidate)) continue;
    if (spawnSync(candidate, ['-v'], { encoding: 'utf8' }).status === 0) return candidate;
  }
  throw new Error('PHP not found. Set PHP_PATH or install PHP/XAMPP.');
}
