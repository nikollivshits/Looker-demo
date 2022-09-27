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
  WFSI."Id" AS "ActionIdentifier",
  WFSI."IsAutomatic" AS "ActionIsAutomatic"
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
    sql: to_timestamp(${creation_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  dimension: case_status {
    type: string
    case: {
      when: {
        sql: ${status}=1 ;;
        label: "Open"
      }
      when: {
        sql: ${status}=2 ;;
        label: "Closed"
      }
      else: "Others"
    }
    alpha_sort: yes
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: alert_type {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: playbook_name {
    type: string
    sql: ${TABLE}."PlaybookName" ;;
  }

  dimension: soc_role_name {
    type: string
    sql: ${TABLE}."SocRoleName" ;;
  }

  dimension: action_identifier {
    type: string
    sql: ${TABLE}."ActionIdentifier" ;;
  }

  dimension: action_is_automatic {
    type: yesno
    sql: ${TABLE}."ActionIsAutomatic" ;;
  }

  measure: cases_count {
    type: count_distinct
    sql: ${case_id};;
  }

  measure: alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
  }

  measure: cases_with_manual_actions_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [vw_roi_metrics.action_is_automatic: "No"]
    }

  measure: cases_without_manual_intervention_percent {
    type: number
    sql: 1.0 * (${cases_count}-${cases_with_manual_actions_count})/NULLIF(${cases_count},0.00);;
  }

  measure: all_actions {
    type: count_distinct
    sql: ${action_identifier};;
  }

  measure: automatic_actions_out_of_all {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_roi_metrics.action_is_automatic: "Yes"]
    html: {{ rendered_value }} out of {{ all_actions._rendered_value }} ;;
  }

  measure: automatic_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_roi_metrics.action_is_automatic: "Yes"]
  }

  measure: manual_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_roi_metrics.action_is_automatic: "No"]
  }

  measure: manual_actions_percent {
    type: number
    sql: 1.0*${manual_actions}/NULLIF(${all_actions},0.00);;

  }

  measure: automatic_actions_percent {
    type: number
    sql: 1.00 * ${automatic_actions}/NULLIF(${all_actions},0.00);;
  }


}
