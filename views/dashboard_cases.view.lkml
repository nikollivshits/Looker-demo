view: dashboard_cases {
  sql_table_name: public."DashboardCases" ;;

  dimension: analyst {
    type: string
    sql: ${TABLE}."Analyst" ;;
  }

  dimension: case_close_reason {
    type: number
    sql: ${TABLE}."CaseCloseReason" ;;
  }

  dimension: case_closed_action_type {
    type: number
    sql: ${TABLE}."CaseClosedActionType" ;;
  }

  dimension: case_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: case_priority {
    type: number
    sql: ${TABLE}."CasePriority" ;;
  }

  dimension: case_stage {
    type: string
    sql: ${TABLE}."CaseStage" ;;
  }

  dimension: closed_case_sla_status_enum {
    type: number
    sql: ${TABLE}."ClosedCaseSlaStatusEnum" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: is_important {
    type: yesno
    sql: ${TABLE}."IsImportant" ;;
  }

  dimension: is_incident {
    type: yesno
    sql: ${TABLE}."IsIncident" ;;
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}."RootCause" ;;
  }

  dimension: sla_expiration_unix_time {
    type: number
    sql: ${TABLE}."SlaExpirationUnixTime" ;;
  }

  dimension: sla_handling_time_in_ms {
    type: number
    sql: ${TABLE}."SlaHandlingTimeInMs" ;;
  }

  dimension: soc_role_id {
    type: number
    sql: ${TABLE}."SocRoleId" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }



  dimension: title {
    type: string
    sql: ${TABLE}."Title" ;;
  }

  dimension: touched {
    type: yesno
    sql: ${TABLE}."Touched" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: cases_count {
    type: count_distinct
    sql: ${case_id};;
  }

  measure: cases_count_desc {
    type: count_distinct
    sql: ${case_id};;
    html:
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >There are <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{rendered_value}}</span>
    <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >cases in total.</span>
    </p>
    ;;
  }

  measure: mean_time_to_resolve {
    type: number
    sql: SUM(${handling_time_in_ms});;
  }


}
