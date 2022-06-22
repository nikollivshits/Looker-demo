view: case_assign_activities {
  sql_table_name: public.CaseAssignActivities ;;
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

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: soc_role_id {
    type: number
    sql: ${TABLE}."SocRoleId" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}."UserName" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user_name]
  }
}
