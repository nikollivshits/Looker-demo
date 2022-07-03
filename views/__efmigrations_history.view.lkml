view: __efmigrations_history {
  sql_table_name: public.__EFMigrationsHistory ;;

  dimension: migration_id {
    type: string
    sql: ${TABLE}."MigrationId" ;;
  }

  dimension: product_version {
    type: string
    sql: ${TABLE}."ProductVersion" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
