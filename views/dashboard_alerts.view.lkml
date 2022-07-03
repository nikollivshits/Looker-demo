view: dashboard_alerts {
  sql_table_name: public.DashboardAlerts ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."Id" ;;
  }

  dimension: action_type {
    type: number
    sql: ${TABLE}."ActionType" ;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
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

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: has_playbook {
    type: yesno
    sql: ${TABLE}."HasPlaybook" ;;
  }

  dimension: original_alert_creation_time {
    type: number
    sql: ${TABLE}."OriginalAlertCreationTime" ;;
  }

  dimension: original_alert_end_time {
    type: number
    sql: ${TABLE}."OriginalAlertEndTime" ;;
  }

  dimension: original_alert_start_time {
    type: number
    sql: ${TABLE}."OriginalAlertStartTime" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: rule_name {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}."Vendor" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, rule_name]
  }
}
