connection: "sedomv6-v20"

# include all the views
include: "/views/**/*.view"

datagroup: searcheverythingdb3_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: searcheverythingdb3_default_datagroup

explore: alerts_and_entities_report {}

explore: alert_networks_distribuations {}

explore: alert_ontology_families {}

explore: alert_products_distribuations {}

explore: alert_tags_distribuations {}

explore: alert_users_distribuations {}

explore: alerts_distribuations {}

explore: case_assign_activities {}

explore: case_merge_histories {}

explore: case_recommendation_records {}

explore: case_search_filters_values {}

explore: case_stage_definitions {}

explore: combined_alerts_cases {}

explore: dashboard_alert_category_outcomes {}

explore: dashboard_alert_entities {}

explore: dashboard_alert_networks {}

explore: dashboard_alert_playbooks {}

explore: dashboard_alert_ports {}

explore: dashboard_alert_products {}

explore: dashboard_alerts {}

explore: dashboard_case_tags {}

explore: dashboard_case_tasks {}

explore: dashboard_cases {}

explore: dashboard_stage_transitions {}

explore: entity_search_filters_values {}

explore: environment_dynamic_parameters {}

explore: metadata_case_stages {}

explore: metadata_operating_environments {}

explore: metadata_soc_roles {}

explore: metadata_user_profiles {}

explore: system_action_results {}

explore: system_alert_statistics {}

explore: system_case_slas {}

explore: system_involved_threat_indicators {}

explore: roi_view {}

explore: workflow_index_aggregate_records {}

explore: workflow_index_records {}

explore: workflow_statistics_job_states {}

explore: workflow_step_index_aggregate_records {}

explore: workflow_step_index_records {}

explore: __efmigrations_history {}
