view: workflow_statistics_job_states {
  sql_table_name: public.WorkflowStatisticsJobStates ;;

  dimension: end_time_ms {
    type: number
    sql: ${TABLE}."EndTimeMs" ;;
  }

  dimension: frequency_seconds {
    type: number
    sql: ${TABLE}."FrequencySeconds" ;;
  }

  dimension: last_execution_time_ms {
    type: number
    sql: ${TABLE}."LastExecutionTimeMs" ;;
  }

  dimension: server_identifier {
    type: string
    sql: ${TABLE}."ServerIdentifier" ;;
  }

  dimension: start_time_ms {
    type: number
    sql: ${TABLE}."StartTimeMs" ;;
  }

  dimension: state {
    type: number
    sql: ${TABLE}."State" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: timeout_seconds {
    type: number
    sql: ${TABLE}."TimeoutSeconds" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
