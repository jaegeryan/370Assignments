# Durability
# Durability is the property of a transaction that guarantees that once a transaction has been committed, it will remain committed even in the case of a system failure (e.g., power loss, crash, etc.).
# This is achieved by writing the transaction's log to disk before the transaction is considered committed.
SET GLOBAL innodb_flush_log_at_trx_commit = 1;
# The default value is 1, which means that the log buffer is flushed to disk after every transaction. // Redo Log
SET GLOBAL innodb_log_file_size = 268435456;
# The default value is 50331648, which is 48MB.
SET GLOBAL innodb_max_undo_log_size = 1073741824;
# The default value is 1073741824, which is 1GB.

# Logging, Monitoring, and Auditing
SET GLOBAL general_log_file = '/var/log/mysql/mysql.log';
# The default value is /var/log/mysql/mysql.log.
SET GLOBAL general_log = 1;

# Backup and Recovery, Using terminal to backup database
## mysqldump -u root -p 370_assignment > 370_assignment_backup.sql
## nano ~/.my.cnf
## [client]
##user=username
## password=password
## chmod 600 ~/.my.cnf
## sudo sh -c "/usr/local/mysql/bin/mysqldump 370_assignment > /var/backups/mysql/370_assignment_backup.sql"
# This is a shell script that runs the mysqldump command and saves the output to a file.
## crontab -e
## 0 1 * * * /usr/local/mysql/bin/mysqldump 370_assignment > /var/backups/mysql/370_assignment_backup.sql

# Isoaltion Level I chose READ COMMITTED
# Since my project involves a lot of JOIN operations and batch update operations, the READ COMMITTED isolation level can provide good concurrency performance while also providing some data consistency.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;