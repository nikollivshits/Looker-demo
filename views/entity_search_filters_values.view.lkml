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

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
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
