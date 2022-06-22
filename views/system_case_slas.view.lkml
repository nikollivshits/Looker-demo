view: system_case_slas {
  sql_table_name: public.SystemCaseSlas ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: case_sla_status {
    type: number
    sql: ${TABLE}."CaseSlaStatus" ;;
  }

  dimension: case_sla_type {
    type: number
    sql: ${TABLE}."CaseSlaType" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: elapsed_time_in_ms {
    type: number
    sql: ${TABLE}."ElapsedTimeInMs" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: sla_critical_time_in_ms {
    type: number
    sql: ${TABLE}."SlaCriticalTimeInMs" ;;
  }

  dimension: sla_time_in_ms {
    type: number
    sql: ${TABLE}."SlaTimeInMs" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}."Value" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
