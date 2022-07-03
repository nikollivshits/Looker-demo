view: system_alert_statistics {
  sql_table_name: public.SystemAlertStatistics ;;
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

  dimension: end_time_in_ms {
    type: number
    sql: ${TABLE}."EndTimeInMs" ;;
  }

  dimension: event_count {
    type: number
    sql: ${TABLE}."EventCount" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
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
