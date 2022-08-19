connection: "sedomv6-v20"

# include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
include: "/views/dashboard_alert_entities.view.lkml"                 # include all views in this project
include: "/views/dashboard_alerts.view.lkml"                 # include all views in this project
include: "/views/dashboard_cases.view.lkml"                 # include all views in this project

# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: dashboard_alert_entities {
  join: dashboard_alerts {
    relationship: many_to_one
    sql_on: ${dashboard_alert_entities.alert_identifier} = ${dashboard_alerts.alert_identifier} ;;
  }
  join: dashboard_cases {
    relationship: many_to_one
    sql_on: ${dashboard_alerts.case_id} = ${dashboard_cases.case_id} ;;
  }
}
