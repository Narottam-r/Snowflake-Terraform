output "database_names" {
  value = [for db in snowflake_database.db : db.name]
}
