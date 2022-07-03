view: case_recommendation_records {
  sql_table_name: public.CaseRecommendationRecords ;;
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

  dimension: score_precent {
    type: number
    sql: ${TABLE}."ScorePrecent" ;;
  }

  dimension: similar_case_id {
    type: number
    sql: ${TABLE}."SimilarCaseId" ;;
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
