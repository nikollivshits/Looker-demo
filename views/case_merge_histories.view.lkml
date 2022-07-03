view: case_merge_histories {
  sql_table_name: public.CaseMergeHistories ;;
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

  dimension: merged_from_case_id {
    type: number
    sql: ${TABLE}."MergedFromCaseId" ;;
  }

  dimension: merged_to_case_id {
    type: number
    sql: ${TABLE}."MergedToCaseId" ;;
  }

  dimension: modification_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."ModificationTimeUnixTimeInMs" ;;
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
