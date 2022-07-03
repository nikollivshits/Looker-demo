view: dashboard_case_tags {
  sql_table_name: public.DashboardCaseTags ;;

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}."Tag" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
