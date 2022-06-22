view: metadata_user_profiles {
  sql_table_name: public.MetadataUserProfiles ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}."Email" ;;
  }

  dimension: environments_json {
    type: string
    sql: ${TABLE}."EnvironmentsJson" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."FirstName" ;;
  }

  dimension: is_disabled {
    type: yesno
    sql: ${TABLE}."IsDisabled" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."LastName" ;;
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
    drill_fields: [id, first_name, user_name, last_name]
  }
}
