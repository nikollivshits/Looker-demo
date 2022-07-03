view: alerts_and_entities_report {
  derived_table: {
    sql: WITH
      incident_flag AS
      (SELECT "CaseId", MAX(CASE WHEN "NewStage" = 'Incident' THEN 1 ELSE 0 END) AS "IncidentFlag"
      FROM public."DashboardStageTransitions"
      GROUP BY "CaseId"),
      entity_list_incidents AS
      (SELECT DISTINCT a."CaseId", REPLACE(a."EntityIdentifier", '\', '@' ) AS "EntityIdentifier", a."EntityType",
           b."IncidentFlag"
          FROM public."DashboardAlertEntities" a
             LEFT JOIN incident_flag b ON a."CaseId" = b."CaseId"
           WHERE b."IncidentFlag" = 1
      )
      SELECT DISTINCT a.*, b."EntityIdentifier", b."EntityType", c."IncidentFlag"
      FROM public."DashboardCases" a
      LEFT JOIN entity_list_incidents b ON a."CaseId" = b."CaseId"
      LEFT JOIN incident_flag c ON b."CaseId" = c."CaseId"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: incident_count {
    type: count_distinct
    sql: ${incident_id} ;;
    drill_fields: [entity_type, entity_identifier, incident_id]

  }

  measure: case_count {
    type: count_distinct
    sql: ${case_id} ;;
    drill_fields: [detail*]

  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  measure: avg_handling_time_hours {
    type: average
    sql: ${handling_time_in_hours};;
  }

  measure: sum_handling_time_days {
    type: sum
    sql: ${handling_time_in_days};;
  }
  dimension: full_entitiy_identifier {
    type: string
    sql: ${entity_identifier} || '---' || ${entity_type} ;;
  }

  measure: count_identities {
    type: count_distinct
    sql: ${full_entitiy_identifier} ;;
    drill_fields: [incident_id, entity_identifier, entity_type]
  }

  dimension: creation_time_unix_time_in_ms {
    type: number
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: creation_time_timestamp {
    type: date
    sql: to_timestamp(cast(${TABLE}."CreationTimeUnixTimeInMs"/1000 as bigint))::date ;;
  }

  dimension: analyst {
    type: string
    sql: ${TABLE}."Analyst" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: is_important {
    type: string
    sql: ${TABLE}."IsImportant" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}."RootCause" ;;
  }

  dimension: case_priority {
    type: number
    sql: ${TABLE}."CasePriority" ;;
  }

  dimension: case_stage {
    type: string
    sql: ${TABLE}."CaseStage" ;;
  }

  dimension: handling_time_in_ms {
    type: number
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension: handling_time_in_hours {
    type: number
    sql: ${handling_time_in_ms} /( 1000 * 60 * 60);;
  }

  dimension: handling_time_in_seconds {
    type: number
    sql: ${handling_time_in_ms} / (1000 * 60);;
  }

  dimension: handling_time_in_days {
    type: number
    sql: ${handling_time_in_ms} / (1000 * 60 * 60 * 24 );;
  }

  dimension: case_close_reason {
    type: number
    sql: ${TABLE}."CaseCloseReason" ;;
  }

  dimension: sla_expiration_unix_time {
    type: number
    sql: ${TABLE}."SlaExpirationUnixTime" ;;
  }

  dimension: is_incident {
    type: string
    sql: ${TABLE}."IsIncident" ;;
  }

  dimension: sla_handling_time_in_ms {
    type: number
    sql: ${TABLE}."SlaHandlingTimeInMs" ;;
  }

  dimension: closed_case_sla_status_enum {
    type: number
    sql: ${TABLE}."ClosedCaseSlaStatusEnum" ;;
  }

  dimension: soc_role_id {
    type: number
    sql: ${TABLE}."SocRoleId" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."Title" ;;
  }

  dimension: touched {
    type: string
    sql: ${TABLE}."Touched" ;;
  }

  dimension: case_closed_action_type {
    type: number
    sql: ${TABLE}."CaseClosedActionType" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: entity_identifier {
    type: string
    sql: ${TABLE}."EntityIdentifier" ;;
  }

  dimension: entity_type {
    type: string
    sql: ${TABLE}."EntityType" ;;
  }

  dimension: incident_flag {
    type: number
    sql: ${TABLE}."IncidentFlag" ;;
  }

  dimension: incident_id {
    type: number
    sql: CASE ${incident_flag} WHEN 1 THEN ${case_id} ELSE NULL END;;
  }

  set: detail {
    fields: [
      case_id,
      creation_time_unix_time_in_ms,
      analyst,
      environment,
      is_important,
      status,
      root_cause,
      case_priority,
      case_stage,
      handling_time_in_ms,
      case_close_reason,
      sla_expiration_unix_time,
      is_incident,
      sla_handling_time_in_ms,
      closed_case_sla_status_enum,
      soc_role_id,
      title,
      touched,
      case_closed_action_type,
      tenant_id,
      entity_identifier,
      entity_type,
      incident_flag
    ]
  }
}
