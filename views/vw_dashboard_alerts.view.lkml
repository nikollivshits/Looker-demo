
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

  dimension: alert_status_str {
    type: string
    sql: ${vw_dashboard_cases.case_status_str} ;;
  }

  dimension: alert_closed_action_type_str {
    type: string
    sql: ${vw_dashboard_cases.case_closed_action_type_str} ;;
  }

  measure: closed_alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
    filters: [ vw_dashboard_alerts.alert_status_str: "Closed" ]
  }

  measure: automated_alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
    filters: [ vw_dashboard_alerts.has_playbook: "true" ]
  }

  measure: automatically_closed_alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
    filters: [ vw_dashboard_alerts.alert_status_str: "Closed",
               vw_dashboard_alerts.alert_closed_action_type_str: "Automatic" ]
  }

  measure: automated_alerts_percentage {
    type: number
    sql:  CASE
            WHEN ${automated_alerts_count} != 0
              THEN ((${automated_alerts_count}*1.0)/${alerts_count})
            ELSE 0
          END;;
    value_format: "0.00%"
  }

  measure: automatically_closed_alerts_percentage {
    type: number
    sql:  CASE
            WHEN ${automatically_closed_alerts_count} != 0
              THEN ((${automatically_closed_alerts_count}*1.0)/${closed_alerts_count})
            ELSE 0
          END;;
    value_format: "0.00%"
  }

  measure: alert_count_desc {
    type: count_distinct
    sql: ${alert_identifier};;
    html:
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >There were <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{rendered_value}}</span>
    <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >alerts in total generated during the reporting period.</span>
    </p>
    ;;
  }

  measure: high_priority_alerts_count {
    type: count_distinct
    sql: ${alert_identifier} ;;
    filters: [vw_dashboard_cases.case_priority_str: "High"]
  }

  measure: medium_priority_alerts_count {
    type: count_distinct
    sql: ${alert_identifier} ;;
    filters: [vw_dashboard_cases.case_priority_str: "Medium"]
  }

  measure: low_priority_alerts_count {
    type: count_distinct
    sql: ${alert_identifier} ;;
    filters: [vw_dashboard_cases.case_priority_str: "Low"]
  }

  measure: maximum_alert_count_severity {
    type: string
    sql:  CASE WHEN ${high_priority_alerts_count} > ${low_priority_alerts_count} and ${high_priority_alerts_count} > ${medium_priority_alerts_count} THEN 'High'
              WHEN ${low_priority_alerts_count} > ${high_priority_alerts_count} and ${low_priority_alerts_count} > ${medium_priority_alerts_count} THEN  'Low'
              WHEN ${medium_priority_alerts_count} > ${high_priority_alerts_count} and ${medium_priority_alerts_count} > ${low_priority_alerts_count} THEN 'Medium'
          END ;;
  }

  measure: alerts_with_severity_summary {
    type: string
    sql:  ${vw_dashboard_alerts.maximum_alert_count_severity};;
    html:   <ul>
  <li>
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >The below details the split of 10 different alerts triggered during the reporting period.</p>
  </li>
  <li>
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >There were
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{vw_dashboard_alerts.alerts_count}} </span>
      alerts in total generated during the reporting period.
    </p>
  </li>
  <li>
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >The majority of alerts were
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{rendered_value}} </span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >severity, with </span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{vw_dashboard_alerts.high_priority_alerts_count}}</span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >high severity, </span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{vw_dashboard_alerts.medium_priority_alerts_count}}</span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >medium severity and </span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{vw_dashboard_alerts.low_priority_alerts_count}}</span>
      <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >low severity alerts triggered during the reporting period.</span>
    </p>
  </li>
  <li>
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >Full breakdown of the alerts can be found in the accompanying spreadsheet.</p>
  </li>
</ul>;;
  }
}
