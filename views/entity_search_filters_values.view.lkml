view: entity_search_filters_values {
  sql_table_name: public.EntitySearchFiltersValues ;;

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: for_migration {
    type: yesno
    sql: ${TABLE}."ForMigration" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: type {
    type: number
    sql: ${TABLE}."Type" ;;
  }

  dimension: usage_frequency {
    type: number
    sql: ${TABLE}."UsageFrequency" ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}."Value" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
