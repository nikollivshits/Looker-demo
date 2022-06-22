view: workflow_step_index_records {
  sql_table_name: public.WorkflowStepIndexRecords ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: action_result_id {
    type: number
    sql: ${TABLE}."ActionResultId" ;;
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

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: invalidated {
    type: yesno
    sql: ${TABLE}."Invalidated" ;;
  }

  dimension: is_automatic {
    type: yesno
    sql: ${TABLE}."IsAutomatic" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: nested_workflow_instance_id {
    type: number
    sql: ${TABLE}."NestedWorkflowInstanceId" ;;
  }

  dimension: original_workflow_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowIdentifier" ;;
  }

  dimension: original_workflow_step_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowStepIdentifier" ;;
  }

  dimension: result_message {
    type: string
    sql: ${TABLE}."ResultMessage" ;;
  }

  dimension: result_value {
    type: string
    sql: ${TABLE}."ResultValue" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  dimension: step_action_name {
    type: string
    sql: ${TABLE}."StepActionName" ;;
  }

  dimension: step_instance_name {
    type: string
    sql: ${TABLE}."StepInstanceName" ;;
  }

  dimension: step_integration {
    type: string
    sql: ${TABLE}."StepIntegration" ;;
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

  dimension: workflow_step_identifier {
    type: string
    sql: ${TABLE}."WorkflowStepIdentifier" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, step_instance_name, step_action_name]
  }
}
