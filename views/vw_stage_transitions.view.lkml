
view: vw_stage_transitions {
  derived_table: {
    sql: SELECT
          "Id",
          "CaseId",
          "PreviousStage" AS "Stage",
          "PreviousStageDurationMs" AS "StageDurationInMs"
          FROM public."DashboardStageTransitions"
          WHERE "PreviousStage" IS NOT NULL
            ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}."Id", ${TABLE}."CaseId",${TABLE}."Stage") ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}."Id" ;;
  }

  dimension: case_id {
    type: string
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}."Stage" ;;
  }

  dimension: stage_duration_in_ms {
    type: string
    sql: ${TABLE}."StageDurationInMs" ;;
  }

  measure: average_stage_duration {
    type: number
    sql:  (CASE WHEN
    COUNT(DISTINCT CASE WHEN ${stage_duration_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END) > 0
    THEN
    SUM(CASE WHEN ${stage_duration_in_ms} IS NOT NULL THEN ${stage_duration_in_ms} ELSE 0 END)
    /
    COUNT(DISTINCT CASE WHEN ${stage_duration_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END)
    ELSE NULL END)/(1000.0*60*60*24)
    ;;
      value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }

  measure: mean_time_to_triage {
    type: number
    sql:  (CASE WHEN
          COUNT(DISTINCT CASE WHEN ${stage} = 'Triage' AND ${stage_duration_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END) > 0
          THEN
          SUM(CASE WHEN ${stage} = 'Triage' AND ${stage_duration_in_ms} IS NOT NULL THEN ${stage_duration_in_ms} ELSE 0 END)
          /
          COUNT(DISTINCT CASE WHEN ${stage} = 'Triage' AND ${stage_duration_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END)
          ELSE NULL END)/(1000.0*60*60*24)
          ;;
    value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }



}
