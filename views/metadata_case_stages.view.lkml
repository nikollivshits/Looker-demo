view: metadata_case_stages {
  sql_table_name: public.MetadataCaseStages ;;
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

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }


  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
