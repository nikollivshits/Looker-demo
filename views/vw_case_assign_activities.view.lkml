
view: vw_case_assign_activities {
  derived_table: {
    sql: SELECT
          CAA."Id",
          CAA."CaseId",
          CAA."Analyst",
          MSR."Name" AS "SocRole",
          CAA."AssignmentStartTime" AS "AssignmentStartTimeInMs",
          CASE WHEN CAA."AssignmentEndTime" IS NULL
          AND DC."Status"=2 THEN DC."CreationTimeUnixTimeInMs" + DC."HandlingTimeInMs" ELSE CAA."AssignmentEndTime" END AS "AssignmentEndTimeInMs"
          FROM
          (
          SELECT
          "Id",
          "CaseId",
          "CreationTimeUnixTimeInMs" AS "AssignmentStartTime",
          "UserName" AS "Analyst",
          "SocRoleId",
          LEAD("CreationTimeUnixTimeInMs") over (PARTITION BY "CaseId" ORDER BY "CreationTimeUnixTimeInMs") as "AssignmentEndTime",
          RANK() OVER (PARTITION BY "CaseId" ORDER BY "CreationTimeUnixTimeInMs") as "AssignmentOrder"
          FROM public."CaseAssignActivities"
          ) CAA
          LEFT JOIN public."DashboardCases" DC ON CAA."CaseId" = DC."CaseId"
          LEFT JOIN public."MetadataSocRoles" MSR ON CAA."SocRoleId" = MSR."Id"
            ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}."Id", ${TABLE}."CaseId",${TABLE}."Analyst") ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}."Id" ;;
  }

  dimension: case_id {
    type: string
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: analyst {
    type: string
    sql: ${TABLE}."Analyst" ;;
  }

  dimension: soc_role {
    type: string
    sql: ${TABLE}."SocRole" ;;
  }

  dimension: assignment_start_time_in_ms {
    type: string
    sql: ${TABLE}."AssignmentStartTimeInMs" ;;
  }

  dimension_group: assignment_start_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${assignment_start_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: assignment_end_time_in_ms {
    type: string
    sql: ${TABLE}."AssignmentEndTimeInMs" ;;
  }

  dimension_group: assignment_end_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${assignment_end_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  measure: average_assignment_time_in_ms {
    type: number
    sql:
    (CASE WHEN
    COUNT(DISTINCT CASE WHEN ${assignment_end_time_in_ms} IS NOT NULL AND ${assignment_start_time_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END) > 0
    THEN
    SUM(CASE WHEN ${assignment_end_time_in_ms} IS NOT NULL AND ${assignment_start_time_in_ms} IS NOT NULL THEN ${assignment_end_time_in_ms}-${assignment_start_time_in_ms} ELSE 0 END)
    /
    COUNT(DISTINCT CASE WHEN ${assignment_end_time_in_ms} IS NOT NULL AND ${assignment_start_time_in_ms} IS NOT NULL THEN ${case_id} ELSE NULL END)
    ELSE NULL END)/(1000.0*60*60*24)
    ;;
    value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }

}
