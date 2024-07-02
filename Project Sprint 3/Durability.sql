# Durability
# Durability is the property of a transaction that guarantees that once a transaction has been committed, it will remain committed even in the case of a system failure (e.g., power loss, crash, etc.).
# This is achieved by writing the transaction's log to disk before the transaction is considered committed.
SET GLOBAL innodb_flush_log_at_trx_commit = 1;
# The default value is 1, which means that the log buffer is flushed to disk after every transaction.
SET GLOBAL innodb_log_file_size = 268435456;
# The default value is 50331648, which is 48MB.
SET GLOBAL innodb_max_undo_log_size = 1073741824;
# The default value is 1073741824, which is 1GB.