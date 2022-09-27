
view: vw_dashboard_alerts {
  derived_table: {
    sql: SELECT
          DA."CaseId",
          DA."AlertIdentifier",
          DA."RuleName",
          DA."ActionType",
          DA."HasPlaybook",
          DA."Vendor",
          DA."Product",
          DA."OriginalAlertCreationTime",
          DA."OriginalAlertStartTime",
          DA."OriginalAlertEndTime",
          SAS."EventCount"
          FROM public."DashboardAlerts" DA
          LEFT JOIN public."SystemAlertStatistics" SAS ON DA."AlertIdentifier" = SAS."AlertIdentifier"
            ;;
  }

  dimension: case_id {
    type: string
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: alert_type {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: rule_name {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: action_type {
    type: string
    sql: ${TABLE}."ActionType" ;;
  }

  dimension: has_playbook {
    type: string
    sql: ${TABLE}."HasPlaybook" ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}."Vendor" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: original_alert_creation_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."OriginalAlertCreationTime" ;;
  }

  dimension_group: original_alert_creation_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${original_alert_creation_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: original_alert_start_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."OriginalAlertStartTime" ;;
  }

  dimension_group: original_alert_start_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${original_alert_start_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: original_alert_end_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."OriginalAlertEndTime" ;;
  }

  dimension_group: original_alert_end_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${original_alert_end_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: event_count {
    type: string
    sql: ${TABLE}."EventCount" ;;
  }

  measure: alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
  }

  measure: events_count {
    type: sum
    sql: ${event_count};;
  }


}