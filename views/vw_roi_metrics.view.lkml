view: vw_roi_metrics {
  derived_table: {
    sql: SELECT
  DC."CaseId",
  DC."Environment",
  DC."CreationTimeUnixTimeInMs",
  DC."Status",
  DC."HandlingTimeInMs",
  DC."CasePriority",
  DA."AlertIdentifier",
  DA."HasPlaybook",
  DA."RuleName",
  DAPR."Product",
  MS."Name" as "SocRoleName" ,
  WFI."WorkflowName" AS "PlaybookName",
  WFSI."Id" AS ActionIdentifier,
  WFSI."IsAutomatic" AS ActionIsAutomatic
FROM    public."DashboardCases" DC
LEFT JOIN   public."DashboardAlerts" DA       ON DC."CaseId"= DA."CaseId"
LEFT JOIN   public."DashboardAlertProducts" DAPR  ON DA."AlertIdentifier" = DAPR."AlertIdentifier" AND DA."CaseId" = DAPR."CaseId"
LEFT JOIN   public."MetadataSocRoles" MS      ON DC."SocRoleId" = MS."Id"
LEFT JOIN   public."WorkflowIndexRecords" WFI   ON DA."CaseId"= WFI."CaseId" AND DA."AlertIdentifier" = WFI."AlertIdentifier"
LEFT JOIN   public."WorkflowStepIndexRecords" WFSI  ON WFI."WorkflowInstanceId"= WFSI."WorkflowInstanceId" AND WFI."AlertIdentifier"= WFSI."AlertIdentifier" AND WFI."CaseId"= WFSI."CaseId"
      ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension_group: case_creation_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${creation_time_unix_time_in_ms})
    datatype: datetime
    convert_tz: yes | no;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: action_identifier {
    type: string
    sql: ${TABLE}."ActionIdentifier" ;;
  }

  dimension: action_is_automatic {
    type: yesno
    sql: ${TABLE}."ActionIsAutomatic" ;;
  }

  measure: cases {
    type: count_distinct
    sql: ${case_id};;
  }

  measure: alerts {
    type: count_distinct
    sql: ${alert_identifier};;
  }

  measure: all_actions {
    type: count_distinct
    sql: ${action_identifier};;
  }

  measure: automatic_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [action_is_automatic: "Yes"]
  }

  measure: manual_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [action_is_automatic: "No"]
  }

}
