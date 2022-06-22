view: workflow_index_aggregate_records {
  sql_table_name: public.WorkflowIndexAggregateRecords ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}."Count" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: index_date {
    type: number
    sql: ${TABLE}."IndexDate" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: original_workflow_identifier {
    type: string
    sql: ${TABLE}."OriginalWorkflowIdentifier" ;;
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

}
