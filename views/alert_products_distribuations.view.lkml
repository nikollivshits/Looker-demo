view: alert_products_distribuations {
  sql_table_name: public.AlertProductsDistribuations ;;
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

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
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
