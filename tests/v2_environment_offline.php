<?php
declare(strict_types=1);
require dirname(__DIR__) . '/backend/src/autoload.php';
use BloodMatch\Config\Database;

foreach (['bloodmatch', 'bloodmatch_test'] as $legacy) {
    $_ENV['DB_NAME'] = $legacy;
    try {
        Database::pdo();
        throw new LogicException('A capstone database target was not blocked.');
    } catch (RuntimeException $error) {
        if (!str_contains($error->getMessage(), 'capstone database is blocked')) throw $error;
    }
}
echo "PASS capstone development and test databases blocked before connection\n";
