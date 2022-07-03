view: alert_users_distribuations {
  sql_table_name: public.AlertUsersDistribuations ;;
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

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: is_internal {
    type: yesno
    sql: ${TABLE}."IsInternal" ;;
  }

  dimension: is_suspicous {
    type: yesno
    sql: ${TABLE}."IsSuspicous" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: user {
    type: string
    sql: ${TABLE}."User" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
