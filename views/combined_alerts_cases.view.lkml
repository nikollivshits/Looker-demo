view: combined_alerts_cases {
  derived_table: {
    sql: Select coalesce(e."CaseId", f."CaseId") as "CaseId",
          e."Status",
          e."CreationTimeUnixTimeInMs",
          e."HandlingTimeInMs",
          e."Analyst",
          e."IsIncident",
          e."RootCause",
          e."CasePriority",
              e."CaseCloseReason",
              e."CaseStage",
          e."Environment",
          f."AlertIdentifier",
          f."RuleName" ,
          f."Product",
          h."SocRoleId" AS "SocRole",
          e."CaseClosedActionType",
          e."IsImportant",
          e."ClosedCaseSlaStatusEnum",
          CASE WHEN e."Status" = 2 THEN (e."CreationTimeUnixTimeInMs"  + e."HandlingTimeInMs") ELSE NULL end as "Case_Close_UnixTimeInMs",
          coalesce(f."playbooks",0) as playbooks,
          (mcs."max_stage" - mcs."Id") as "CaseStageOrder"
          FROM
            (Select b."CaseId",
                    b."Status",
                b."CreationTimeUnixTimeInMs",
                b."HandlingTimeInMs",
                b."Analyst",
                b."IsIncident",
                b."RootCause",
                b."CasePriority",
                          b."CaseCloseReason",
                          b."CaseStage",
                b."Environment",
                 b."CaseClosedActionType",
                 b."IsImportant",
                 b."ClosedCaseSlaStatusEnum"
                from "DashboardCases" b) e FULL JOIN
                      (Select coalesce (c."CaseId", d."CaseId") as "CaseId",
                          coalesce (c."AlertIdentifier",
                          d."AlertIdentifier",
                          g."AlertIdentifier") as "AlertIdentifier",
                          c."RuleName",
                          d."Product",
                          g."playbooks"
                    FROM "DashboardAlerts" c FULL JOIN
                       "DashboardAlertProducts" d on c."CaseId" = d."CaseId" and c."AlertIdentifier" = d."AlertIdentifier"
                       FULL JOIN (SELECT "CaseId","AlertIdentifier",count (distinct "PlaybookName") as playbooks FROM "DashboardAlertPlaybooks" group by "CaseId","AlertIdentifier") g on c."CaseId" = g."CaseId" and c."AlertIdentifier" = g."AlertIdentifier") f ON e."CaseId" = f."CaseId"
              LEFT JOIN  "MetadataUserProfiles" h on e."Analyst" = h."UserName"
              LEFT join  (select *, MAX("Id") OVER (PARTITION BY '1')+1 as "max_stage"
                    from "MetadataCaseStages") mcs on mcs."Name" =  e."CaseStage"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure:  count_distinct_cases{
    type: count_distinct
    sql: ${case_id} ;;
  }

  measure:  count_distinct_alerts{
    type: count_distinct
    sql: ${alert_identifier} ;;
  }

  dimension: case_priority_bucket {
    case: {
      when: {
        sql: ${case_priority} <= 40;;
        label: "Low"
      }
      when: {
        sql: ${case_priority} > 40 AND ${case_priority} <= 60;;
        label: "Medium"
      }
      when: {
        sql: ${case_priority} > 60 AND ${case_priority} <= 80;;
        label: "High"
      }
      else:"Critical"
    }
  }
  dimension_group: created {
    type: time
    view_label: "_PoP"
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${creation_time_unix_time_in_ms} ;;
    convert_tz: no
  }

  dimension: handled_current_week {
    type: string
    sql: combined_alerts_cases."Status" != 1 AND ${days_since_closed} <7;;
  }

  dimension:  days_since_closed{
    type: number
    sql:  CURRENT_DATE - to_timestamp(cast(${TABLE}."Case_Close_UnixTimeInMs"/1000 as bigint))::date ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: date_time
    sql: to_timestamp(cast(${TABLE}."CreationTimeUnixTimeInMs"/1000 as bigint));;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: analyst {
    type: string
    sql: ${TABLE}."Analyst" ;;
  }

  dimension: is_incident {
    type: string
    sql: ${TABLE}."IsIncident" ;;
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}."RootCause" ;;
  }

  dimension: case_priority {
    type: number
    sql: ${TABLE}."CasePriority" ;;
  }

  dimension: case_close_reason {
    type: number
    sql: ${TABLE}."CaseCloseReason" ;;
  }

  dimension: case_stage {
    type: string
    sql: ${TABLE}."CaseStage" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: rule_name {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: soc_role {
    type: number
    sql: ${TABLE}."SocRole" ;;
  }

  dimension: case_closed_action_type {
    type: number
    sql: ${TABLE}."CaseClosedActionType" ;;
  }

  dimension: is_important {
    type: string
    sql: ${TABLE}."IsImportant" ;;
  }

  dimension: closed_case_sla_status_enum {
    type: number
    sql: ${TABLE}."ClosedCaseSlaStatusEnum" ;;
  }

  dimension: case_close_unix_time_in_ms {
    type: date
    sql: to_timestamp(cast(${TABLE}."Case_Close_UnixTimeInMs"/1000 as bigint))::date ;;
  }

  dimension: playbooks {
    type: number
    sql: ${TABLE}."playbooks" ;;
  }

  dimension: case_stage_order {
    type: number
    sql: ${TABLE}."CaseStageOrder" ;;
  }

  set: detail {
    fields: [
      case_id,
      status,
      creation_time_unix_time_in_ms,
      handling_time_in_ms,
      analyst,
      is_incident,
      root_cause,
      case_priority,
      case_close_reason,
      case_stage,
      environment,
      alert_identifier,
      rule_name,
      product,
      soc_role,
      case_closed_action_type,
      is_important,
      closed_case_sla_status_enum,
      case_close_unix_time_in_ms,
      playbooks,
      case_stage_order
    ]
  }
}
