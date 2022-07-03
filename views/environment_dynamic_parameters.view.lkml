view: environment_dynamic_parameters {
  sql_table_name: public.EnvironmentDynamicParameters ;;
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

  dimension: default_value {
    type: string
    sql: ${TABLE}."DefaultValue" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."Name" ;;
  }

  dimension: optional_values_json {
    type: string
    sql: ${TABLE}."OptionalValuesJson" ;;
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
