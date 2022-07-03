view: alert_ontology_families {
  sql_table_name: public.AlertOntologyFamilies ;;

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}."Tenant" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TenantId" ;;
  }

  dimension: visual_family {
    type: string
    sql: ${TABLE}."VisualFamily" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
