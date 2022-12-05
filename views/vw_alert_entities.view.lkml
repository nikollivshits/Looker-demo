view: vw_alert_entities {
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
      SELECT DISTINCT a."CaseId", b."EntityIdentifier", b."EntityType", c."IncidentFlag"
      FROM public."DashboardCases" a
      LEFT JOIN entity_list_incidents b ON a."CaseId" = b."CaseId"
      LEFT JOIN incident_flag c ON b."CaseId" = c."CaseId"
       ;;
  }

  measure: incident_count {
    type: count_distinct
    sql: ${incident_id} ;;
  }

  measure: entities_count {
    type: count_distinct
    sql: ${entity_identifier} ;;
  }

  dimension: case_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: full_entitiy_identifier {
    type: string
    sql: ${entity_identifier} || '---' || ${entity_type} ;;
  }

  measure: count_identities {
    type: count_distinct
    sql: ${full_entitiy_identifier} ;;
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
}
