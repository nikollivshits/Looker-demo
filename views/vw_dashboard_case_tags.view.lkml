view: vw_dashboard_case_tags {
  derived_table: {
    sql: SELECT "CaseId",
          "CreationTimeUnixTimeInMs",
          "HandlingTimeInMs",
          "Tag"
          FROM public."DashboardCaseTags";;
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}."Id", ${TABLE}."CaseId",${TABLE}."Tag") ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}."Tag" ;;
  }
}
