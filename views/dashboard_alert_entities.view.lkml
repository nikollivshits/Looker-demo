view: dashboard_alert_entities {
  sql_table_name: public.DashboardAlertEntities ;;
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

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: entity_environment {
    type: string
    sql: ${TABLE}."EntityEnvironment" ;;
  }

  dimension: entity_identifier {
    type: string
    sql: ${TABLE}."EntityIdentifier" ;;
  }

  dimension: entity_type {
    type: string
    sql: ${TABLE}."EntityType" ;;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
