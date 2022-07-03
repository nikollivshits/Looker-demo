view: system_involved_threat_indicators {
  sql_table_name: public.SystemInvolvedThreatIndicators ;;
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

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
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
