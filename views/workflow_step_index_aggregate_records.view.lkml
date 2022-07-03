view: workflow_step_index_aggregate_records {
  sql_table_name: public.WorkflowStepIndexAggregateRecords ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: failed_count {
    type: number
    sql: ${TABLE}."FailedCount" ;;
  }

  dimension: index_date {
    type: number
    sql: ${TABLE}."IndexDate" ;;
  }

  dimension: is_flow {
    type: yesno
    sql: ${TABLE}."IsFlow" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: original_workflow_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowIdentifier" ;;
  }

  dimension: original_workflow_step_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowStepIdentifier" ;;
  }

  dimension: result_value {
    type: string
    sql: ${TABLE}."ResultValue" ;;
  }

  dimension: success_count {
    type: number
    sql: ${TABLE}."SuccessCount" ;;
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
