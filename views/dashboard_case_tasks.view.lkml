view: dashboard_case_tasks {
  sql_table_name: public.DashboardCaseTasks ;;

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: case_priority {
    type: number
    sql: ${TABLE}."CasePriority" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}."Creator" ;;
  }

  dimension: due_date_in_unixtime_ms {
    type: number
    sql: ${TABLE}."DueDateInUnixtimeMs" ;;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}."Owner" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
  }

  dimension: task_id {
    type: number
    sql: ${TABLE}."TaskId" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
