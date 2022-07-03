view: case_stage_definitions {
  sql_table_name: public.CaseStageDefinitions ;;
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

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."Name" ;;
  }

  dimension: order {
    type: number
    sql: ${TABLE}."Order" ;;
  }


  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
