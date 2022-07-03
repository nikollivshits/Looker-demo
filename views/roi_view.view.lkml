view: roi_view {
  derived_table: {
    sql: with d as (
        select     distinct aa."AlertIdentifier",
              a."Environment",
              cast(to_timestamp(a."CreationTimeUnixTimeInMs"/1000)as varchar) as case_time
              ,ap."PlaybookName",c.actions_active_auto,d.actions_active_manual,a."CaseId",a."Status"
              ,aa."RuleName",
              apr."Product",
              s."Name" as soc_role
              --,s.soc_role
        from      public."DashboardCases" a
        join     public."DashboardAlerts" aa
        on       a."CaseId"=aa."CaseId"
        left join   public."DashboardAlertPlaybooks" ap
        on       aa."AlertIdentifier"=ap."AlertIdentifier"
              and
              aa."CaseId"=ap."CaseId"
        left join   public."DashboardAlertProducts" apr
        on       aa."AlertIdentifier"=apr."AlertIdentifier"
              and
              aa."CaseId"=apr."CaseId"
        left join(  SELECT   distinct COUNT(*) as actions_active_auto,"AlertIdentifier"
              FROM   public."WorkflowStepIndexRecords"
              WHERE   "IsAutomatic"
              group by "AlertIdentifier") c
        on       aa."AlertIdentifier" =c."AlertIdentifier"
        left join(  SELECT   distinct COUNT(*) as actions_active_manual,
                  "AlertIdentifier"
              FROM   public."WorkflowStepIndexRecords"
              WHERE   not "IsAutomatic"
              group by "AlertIdentifier") d
        on       aa."AlertIdentifier"=d."AlertIdentifier"
          --getting soc role
        LEFT JOIN(  SELECT   DISTINCT "Id", "Name"
              FROM   public."MetadataSocRoles")AS s
              ON     a."SocRoleId" = s."Id")

      select     main.*,t3.tier_3_time,t2.tier_2_time,t1.tier_1_time
      from     d as main
      left join(  select   sum(actions_active_auto)*3 as tier_3_time,
      'Tier3' as soc
      from   d) t3
      on       main.soc_role=t3.soc
      left join(  select   sum(actions_active_auto)*6 as tier_2_time,
      'Tier2' as soc
      from d) t2
      on       main.soc_role=t2.soc
      left join(  select   sum(actions_active_auto)*9 as tier_1_time,
      'Tier1' as soc
      from   d) t1
      on       main.soc_role=t1.soc
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: case_time {
    type: string
    sql: ${TABLE}."case_time" ;;
  }

  dimension: playbook_name {
    type: string
    sql: ${TABLE}."PlaybookName" ;;
  }

  dimension: actions_active_auto {
    type: number
    sql: ${TABLE}."actions_active_auto" ;;
  }

  dimension: actions_active_manual {
    type: number
    sql: ${TABLE}."actions_active_manual" ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."Status" ;;
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
    type: string
    sql: ${TABLE}."soc_role" ;;
  }

  dimension: tier_3_time {
    type: number
    sql: ${TABLE}."tier_3_time" ;;
  }

  dimension: tier_2_time {
    type: number
    sql: ${TABLE}."tier_2_time" ;;
  }

  dimension: tier_1_time {
    type: number
    sql: ${TABLE}."tier_1_time" ;;
  }

  set: detail {
    fields: [
      alert_identifier,
      environment,
      case_time,
      playbook_name,
      actions_active_auto,
      actions_active_manual,
      case_id,
      status,
      rule_name,
      product,
      soc_role,
      tier_3_time,
      tier_2_time,
      tier_1_time
    ]
  }
}
