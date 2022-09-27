view: vw_playbooks_and_actions {
  derived_table: {
    sql: SELECT
      WFI."CaseId",
      WFI."AlertIdentifier",
      WFI."WorkflowName" AS "PlaybookName",
      WFSI."Id" AS "ActionIdentifier",
      WFSI."IsAutomatic" AS "ActionIsAutomatic"
  FROM  public."WorkflowIndexRecords" WFI
  LEFT JOIN   public."WorkflowStepIndexRecords" WFSI  ON WFI."WorkflowInstanceId"= WFSI."WorkflowInstanceId" AND WFI."AlertIdentifier"= WFSI."AlertIdentifier" AND WFI."CaseId"= WFSI."CaseId"
;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}."CaseId",'-', ${TABLE}."AlertIdentifier",'-',${TABLE}."PlaybookName",'-',${TABLE}."ActionIdentifier") ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: playbook_name {
    type: string
    sql: ${TABLE}."PlaybookName" ;;
  }

  dimension: action_identifier {
    type: string
    sql: ${TABLE}."ActionIdentifier" ;;
  }

  dimension: action_is_automatic {
    type: yesno
    sql: ${TABLE}."ActionIsAutomatic" ;;
  }

  measure: cases_with_manual_actions_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [vw_playbooks_and_actions.action_is_automatic: "No"]
  }

  measure: all_actions {
    type: count_distinct
    sql: ${action_identifier};;
  }

  measure: automatic_actions_out_of_all {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_playbooks_and_actions.action_is_automatic: "Yes"]
    html: {{ rendered_value }} out of {{ all_actions._rendered_value }} ;;
  }

  measure: automatic_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_playbooks_and_actions.action_is_automatic: "Yes"]
  }

  measure: manual_actions {
    type: count_distinct
    sql: ${action_identifier};;
    filters: [vw_playbooks_and_actions.action_is_automatic: "No"]
    value_format: "0.00%"
  }

  measure: manual_actions_percent {
    type: number
    sql: 1.0*${manual_actions}/NULLIF(${all_actions},0.00);;
    value_format: "0.00%"

  }

  measure: automatic_actions_percent {
    type: number
    sql: 1.00 * ${automatic_actions}/NULLIF(${all_actions},0.00);;
    value_format: "0.00%"
  }

}
