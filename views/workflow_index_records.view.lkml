view: workflow_index_records {
  sql_table_name: public.WorkflowIndexRecords ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: block_step_id {
    type: string
    sql: ${TABLE}."BlockStepId" ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: end_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."EndTimeUnixTimeInMs" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: failed {
    type: yesno
    sql: ${TABLE}."Failed" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: original_workflow_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowIdentifier" ;;
  }

  dimension: playbook_type {
    type: string
    sql: ${TABLE}."PlaybookType" ;;
  }

  dimension: start_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."StartTimeUnixTimeInMs" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: workflow_definition_identifier {
    type: string
    sql: ${TABLE}."WorkflowDefinitionIdentifier" ;;
  }

  dimension: workflow_instance_id {
    type: number
    sql: ${TABLE}."WorkflowInstanceId" ;;
  }

  dimension: workflow_name {
    type: string
    sql: ${TABLE}."WorkflowName" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, workflow_name]
  }
}
