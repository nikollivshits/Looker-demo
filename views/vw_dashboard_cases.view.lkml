view: vw_dashboard_cases {
  derived_table: {
    sql: SELECT
          DC."CaseId",
          DC."Environment" AS "Environment",
          DC."CreationTimeUnixTimeInMs",
          DC."CasePriority",
          DC."IsImportant",
          DC."Touched",
          DC."Status",
          DC."CaseCloseReason",
          DC."RootCause",
          DC."CaseClosedActionType",
          DC."IsIncident",
          DC."HandlingTimeInMs",
          DC."CaseStage" AS "LastCaseStage",
          DC."Analyst" AS "LastHandledAnalyst",
          MSR1."Name" AS "LastSocRole",
          DC."Title" AS "CaseTitle",
      FA."UserName" AS "FirstAnalystAssigned",
      FS."RemediationTimeFromStageUnixTimeInMs" AS "RemediationTimeFromStageUnixTimeInMs",
      MSR2."Name" AS "FirstSocRole",
      FA."CreationTimeUnixTimeInMs" AS "FirstAnalystAssignedUnixTimeInMs"
          FROM public."DashboardCases" DC
      LEFT JOIN
      (
      SELECT "CaseId", "UserName", "SocRoleId", "CreationTimeUnixTimeInMs" FROM
      (
      SELECT
        "CaseId", "UserName", "SocRoleId", "CreationTimeUnixTimeInMs",
        RANK() OVER (PARTITION BY "CaseId" ORDER BY "CreationTimeUnixTimeInMs") as "Order"
        FROM "CaseAssignActivities"
        WHERE "UserName" NOT LIKE '@%'
      ) a
      WHERE a."Order" = 1
      ) FA ON DC."CaseId" = FA."CaseId"
      LEFT JOIN
      (
        SELECT "CaseId",
        MAX(CASE WHEN "Stage" = 'Remediation' AND "ReverseOrder" = 1 THEN "StartTimeInMs" ELSE NULL END) AS "RemediationTimeFromStageUnixTimeInMs"
        FROM
        (
        SELECT
          "CaseId", "NewStage" AS "Stage", "StartTimeInMs",
          RANK() OVER (PARTITION BY "CaseId","NewStage" ORDER BY "StartTimeInMs" DESC) as "Order",
          RANK() OVER (PARTITION BY "CaseId","NewStage" ORDER BY "StartTimeInMs") as "ReverseOrder"
          FROM "DashboardStageTransitions"
        ) a
        GROUP BY "CaseId"
      ) FS ON DC."CaseId" = FS."CaseId"
      LEFT JOIN public."MetadataSocRoles" MSR1 ON DC."SocRoleId" = MSR1."Id"
      LEFT JOIN public."MetadataSocRoles" MSR2 ON FA."SocRoleId" = MSR2."Id"
            ;;
  }

  dimension: case_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: case_title {
    type: string
    sql: ${TABLE}."CaseTitle" ;;
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

  dimension: case_priority {
    type: string
    sql: ${TABLE}."CasePriority" ;;
  }

  dimension: case_priority_str {
    type: string
    case: {
      when: {
        sql: ${case_priority}=-1 ;;
        label: "Informative"
      }
      when: {
        sql: ${case_priority}=20 ;;
        label: "Low"
      }
      when: {
        sql: ${case_priority}=40 ;;
        label: "Low"
      }
      when: {
        sql: ${case_priority}=60 ;;
        label: "Medium"
      }
      when: {
        sql: ${case_priority}=80 ;;
        label: "High"
      }
      when: {
        sql: ${case_priority}=100 ;;
        label: "Critical"
      }
      else: "Others"
    }
    alpha_sort: yes
  }

  dimension: is_important {
    type: string
    sql: ${TABLE}."IsImportant" ;;
  }

  dimension: touched {
    type: string
    sql: ${TABLE}."Touched" ;;
  }

  dimension: case_status_int {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  dimension: case_status_str {
    type: string
    case: {
      when: {
        sql: ${case_status_int}=1 ;;
        label: "Open"
      }
      when: {
        sql: ${case_status_int}=2 ;;
        label: "Closed"
      }
      else: "Others"
    }
    alpha_sort: yes
  }

  dimension: open_since {
    type: string
    sql: DATE_PART('day',CASE WHEN ${case_status_int}=1 THEN CURRENT_TIMESTAMP - to_timestamp(${creation_time_unix_time_in_ms}/1000) ELSE NULL END);;
  }

  dimension: case_closed_reason_int {
    type: string
    sql: ${TABLE}."CaseCloseReason" ;;
  }

  dimension: case_closed_reason_str {
    type: string
    case: {
      when: {
        sql: ${case_closed_reason_int}=0 ;;
        label: "Malicious"
      }
      when: {
        sql: ${case_closed_reason_int}=1 ;;
        label: "Not Malicious"
      }
      else: "Maintenance"
    }
    alpha_sort: yes
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}."RootCause" ;;
  }

  dimension: case_closed_action_type_int {
    type: string
    sql: ${TABLE}."CaseClosedActionType" ;;
  }

  dimension: case_closed_action_type_str {
    type: string
    case: {
      when: {
        sql: ${case_closed_action_type_int}=0 ;;
        label: "Automatic"
      }
      when: {
        sql: ${case_closed_action_type_int}=1 ;;
        label: "Manual"
      }
      else: "Others"
    }
    alpha_sort: yes
  }

  dimension: is_incident {
    type: string
    sql: ${TABLE}."IsIncident" ;;
  }

  dimension: handling_time_in_ms {
    type: string
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension_group: case_close_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: CASE WHEN ${case_status_int}=2 THEN to_timestamp((${creation_time_unix_time_in_ms}+${handling_time_in_ms})/1000) ELSE NULL END;;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: last_case_stage {
    type: string
    sql: ${TABLE}."LastCaseStage" ;;
  }

  dimension: last_handled_analyst {
    type: string
    sql: ${TABLE}."LastHandledAnalyst" ;;
  }

  dimension: last_soc_role {
    type: string
    sql: ${TABLE}."LastSocRole" ;;
  }

  dimension: first_analyst_assigned {
    type: string
    sql: ${TABLE}."FirstAnalystAssigned" ;;
  }

  dimension: first_soc_role {
    type: string
    sql: ${TABLE}."FirstSocRole" ;;
  }

  dimension: first_analyst_assignment_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."FirstAnalystAssignedUnixTimeInMs" ;;
  }

  dimension_group: first_analyst_assignment_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${first_analyst_assignment_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  measure: average_detection_time {
    type: average
    sql: (${first_analyst_assignment_time_unix_time_in_ms}-${creation_time_unix_time_in_ms})/(1000.0*60*60*24);;
    value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }

  dimension: remediation_stage_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."RemediationTimeFromStageUnixTimeInMs" ;;
  }

  dimension_group: remediation_stage_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${remediation_stage_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  measure: average_remediation_stage_time {
    type: average
    sql: (${remediation_stage_time_unix_time_in_ms}-${creation_time_unix_time_in_ms})/(1000.0*60*60*24);;
    value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }

  measure: average_handling_time {
    type: average
    sql: (${handling_time_in_ms})/(1000.0*60*60*24);;
    filters: [ vw_dashboard_cases.case_status_str: "Closed"]
    value_format: "d\"days\" h\"h\" m\"m\" s\"s\""
  }
  measure: cases_count {
    type: count_distinct
    sql: ${case_id};;
  }

  measure: open_cases_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.case_status_str: "Open" ]
  }

  measure: closed_cases_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.case_status_str: "Closed"]
  }

  measure: false_positive_cases_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.case_status_str: "Closed",
      vw_dashboard_cases.case_closed_reason_str: "Not Malicious"
      ]
  }

  measure: false_positive_cases_percentage {
    type: number
    sql: ((${vw_dashboard_cases.false_positive_cases_count}*1.0)/${vw_dashboard_cases.closed_cases_count});;
    value_format: "0.00%"
  }

  measure: incidents_count_based_on_flag {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.is_incident: "1"
    ]
  }

  measure: open_incidents_count_on_flag {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.is_incident: "1",
      vw_dashboard_cases.case_status_str: "Open"
    ]
  }

  measure: closed_incidents_count_on_flag {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_dashboard_cases.is_incident: "1",
      vw_dashboard_cases.case_status_str: "Closed"
    ]
  }

  measure: health_summary {
    type: string
    sql: case when ${open_incidents_count_on_flag}>0 THEN 'Red'
      when ${open_incidents_count_on_flag}=0 AND ${closed_incidents_count_on_flag}>0 THEN 'Yellow' ELSE 'Green' END;;
    html:
        {% if value == 'Red' %}
         <p style="line-height: 1;font-size: 17px; text-align:center;color:black;" ><img src="https://proanalyst.net/wp-content/uploads/2019/09/red.png" height=30 width=30> The data health is {{rendered_value}} - There have been incidents during the reporting period and they are open.</p>
      {% elsif value == 'Yellow' %}
        <p style="line-height: 1;font-size: 17px; text-align:center;color:black;" ><img src="https://proanalyst.net/wp-content/uploads/2019/09/yellow.png" height=30 width=30>The data health is {{rendered_value}} - There have been incidents during the reporting period and they were closed.</p>
      {% else %}
        <p style="line-height: 1;font-size: 17px; text-align:center;color:black;" ><img src="https://proanalyst.net/wp-content/uploads/2019/09/green.png" height=30 width=30>The data health is {{rendered_value}} - There have been no incidents during the reporting period.</p>
      {% endif %}
;;
  }

  parameter: max_rows {
    type: number
  }

  dimension: max_rows_limit {
    type:  number
    sql: {% parameter max_rows %} ;;
  }

}
