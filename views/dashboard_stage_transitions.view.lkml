view: dashboard_stage_transitions {
  sql_table_name: public.DashboardStageTransitions ;;
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

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: end_time_in_ms {
    type: number
    sql: ${TABLE}."EndTimeInMs" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: new_stage {
    type: string
    sql: ${TABLE}."NewStage" ;;
  }

  dimension: previous_stage {
    type: string
    sql: ${TABLE}."PreviousStage" ;;
  }

  dimension: previous_stage_duration_ms {
    type: number
    sql: ${TABLE}."PreviousStageDurationMs" ;;
  }

  dimension: stage_sla_critical_expiration_unix_time_in_ms {
    type: number
    sql: ${TABLE}."StageSlaCriticalExpirationUnixTimeInMs" ;;
  }

  dimension: stage_sla_expiration_unix_time_in_ms {
    type: number
    sql: ${TABLE}."StageSlaExpirationUnixTimeInMs" ;;
  }

  dimension: start_time_in_ms {
    type: number
    sql: ${TABLE}."StartTimeInMs" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }



  measure: count {
    type: count
    drill_fields: [id]
  }
}
