view: vw_executive_dashboard {
  derived_table: {
    sql: SELECT *
          ,CASE WHEN "NextStageTime" IS NOT NULL AND "Status" in (1,2) then ("NextStageTime" - "StageStartTime")
    when ("NextStageTime") is null
    and "Status" in (2) then ("CreationTimeUnixTimeInMs"  + "HandlingTimeInMs" - "StageStartTime")
    else null end as "HandlingTimeAtEachStage"
  , MAX(CASE WHEN LOWER("Stage") LIKE '%incident%' THEN 1 ELSE 0 END) OVER (PARTITION BY "CaseId") AS "IncidentFlagOnStage"
from (
select distinct a."Status",a."CreationTimeUnixTimeInMs",a."HandlingTimeInMs",a."CaseId",a."Environment",
b."Name" as "SocRole",
c."Stage",c."StageStartTime"
,lead(c."StageStartTime") over (partition by a."CaseId"
      order by
        "StageStartTime") as "NextStageTime"
, it."AlertIdentifier" as "AlertIdentifier"
,cast(to_timestamp(it."CreationTimeUnixTimeInMs"/1000)as varchar) as "AlertCreationTimeUnixTimeInMs"
, CASE WHEN a."Status"=1 then null else a."CaseCloseReason" end as "CaseCloseReason"
, al."HandlingTimeInMs" as "AlertHandlingTime"
,ss."FirstName"||' '||ss."LastName" as "AnalystName", a."Analyst"
,t."Tag",al."RuleName",sla2.sla_flag AS "SlaFlag"
from public."DashboardCases" a
left join public."MetadataSocRoles" b
on a."SocRoleId"=b."Id"
left join public."MetadataUserProfiles"
     AS ss ON a."Analyst" = ss."UserName"
left join (
        select
          "CaseId" ,
          "NewStage" as "Stage" ,
          min("StartTimeInMs") as "StageStartTime"
        from
          public."DashboardStageTransitions"
        group by
          "CaseId" ,
          "Stage" ) as c on
        a."CaseId" = c."CaseId"
join public."DashboardAlerts" it
on a."CaseId"=it."CaseId"
left join public."DashboardAlerts" al
on it."AlertIdentifier" =al."AlertIdentifier"
  LEFT JOIN
    (SELECT DISTINCT "CaseId",
                trim(lower("Tag")) as "Tag"
     FROM public."DashboardCaseTags"
     where lower("Tag") like '%escalation%'
     ) as t ON a."CaseId"  = T."CaseId"
left join
(--sla query final
--alert sla
    select "CaseId",min(sla_flag) sla_flag from(
select "CaseId"
,case "ClosedCaseSlaStatusEnum"
when 2 then 'N'
when 1 then 'Y'
when 0 then case when current_timestamp>to_timestamp("SlaExpirationUnixTime"/1000) then 'N' else 'Y' end end as sla_flag
from
public."DashboardCases"
    where "SlaExpirationUnixTime" is not null
union
--stage sla
select "CaseId",min(sla_met_flag) sla_flag from (
select to_timestamp("CreationTimeUnixTimeInMs"/1000) as creation_time,to_timestamp("ModificationTimeUnixTimeInMs"/1000) mod_time
,"CaseId", "CaseSlaStatus" ,"Value" stage ,"SlaTimeInMs"/1000 as sla,"ElapsedTimeInMs" /1000 elapsed_orig
,case "CaseSlaStatus"
when 0 then extract(epoch from now())-"CreationTimeUnixTimeInMs"/1000 --when case is open and still in that stage, compute elapsed time using current time
when 1 then "ElapsedTimeInMs"/1000 --when open use db elapsed time
when 2 then case when "ElapsedTimeInMs">0 then "ElapsedTimeInMs"/1000 --use db elapsed time when case is closed and this value is not 0
                                           else ("ModificationTimeUnixTimeInMs"-"CreationTimeUnixTimeInMs")/1000 end --when db elapsed time is 0 - which happens when case was closed in the stage with defined SLA, compute using db timestamps
                                          end as case_elapsed_time,
case when case "CaseSlaStatus"
when 0 then extract(epoch from now())-"CreationTimeUnixTimeInMs"/1000 --when case is open and still in that stage, compute elapsed time using current time
when 1 then "ElapsedTimeInMs"/1000 --when open use db elapsed time
when 2 then case when "ElapsedTimeInMs">0 then "ElapsedTimeInMs"/1000 --use db elapsed time when case is closed and this value is not 0
                                           else ("ModificationTimeUnixTimeInMs"-"CreationTimeUnixTimeInMs")/1000 end --when db elapsed time is 0 - which happens when case was closed in the stage with defined SLA, compute using db timestamps
                                          end
                                          >"SlaTimeInMs"/1000 then 'N' else 'Y' end as sla_met_flag
from
public."SystemCaseSlas") sl
group by "CaseId"
    ) sla
    group by "CaseId")sla2
on a."CaseId"=sla2."CaseId"
        ) sq
        where "Stage" is not null
            ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}."CaseId", ${TABLE}."AlertIdentifier", ${TABLE}."Stage") ;;
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}."CaseId" ;;
  }

  dimension: stage {
    type: number
    sql: ${TABLE}."Stage" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."Environment" ;;
  }

  dimension: creation_time_unix_time_in_ms {
    type: string
    sql: ${TABLE}."CreationTimeUnixTimeInMs" ;;
  }

  dimension: handling_time_in_ms {
    type: string
    sql: ${TABLE}."HandlingTimeInMs" ;;
  }

  dimension_group: case_creation_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: to_timestamp(${creation_time_unix_time_in_ms}/1000);;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  dimension_group: case_close_time {
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: CASE WHEN ${status}=2 THEN to_timestamp((${creation_time_unix_time_in_ms}+${handling_time_in_ms})/1000) ELSE NULL END;;
    datatype: timestamp
    convert_tz: yes
  }

  dimension: open_since {
    type: string
    sql: DATE_PART('day',CASE WHEN ${status}=1 THEN CURRENT_TIMESTAMP - to_timestamp(${creation_time_unix_time_in_ms}/1000) ELSE NULL END);;
  }

  dimension: case_status {
    type: string
    case: {
      when: {
        sql: ${status}=1 ;;
        label: "Open"
      }
      when: {
        sql: ${status}=2 ;;
        label: "Closed"
      }
      else: "Others"
    }
    alpha_sort: yes
  }

  dimension: case_closed_reason_int {
    type: string
    sql: ${TABLE}."CaseCloseReason" ;;
  }

  dimension: case_closed_reason {
    type: string
    case: {
      when: {
        sql: ${case_closed_reason_int}=0 ;;
        label: "True Positive"
      }
      when: {
        sql: ${case_closed_reason_int}=1 ;;
        label: "False Positive"
      }
      else: "Maintenance"
    }
    alpha_sort: yes
  }

  dimension: alert_identifier {
    type: string
    sql: ${TABLE}."AlertIdentifier" ;;
  }

  dimension: alert_type {
    type: string
    sql: ${TABLE}."RuleName" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: playbook_name {
    type: string
    sql: ${TABLE}."PlaybookName" ;;
  }

  dimension: soc_role {
    type: string
    sql: ${TABLE}."SocRole" ;;
  }

  dimension: action_identifier {
    type: string
    sql: ${TABLE}."ActionIdentifier" ;;
  }

  dimension: incident_flag_on_stage {
    type: string
    sql: ${TABLE}."IncidentFlagOnStage" ;;
  }

  dimension: sla_met_flag {
    type: string
    sql: ${TABLE}."SlaFlag" ;;
  }

  measure: cases_count {
    type: count_distinct
    sql: ${case_id};;
  }

  measure: cases_count_desc {
    type: count_distinct
    sql: ${case_id};;
    html:
    <p style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >There are <span style="line-height: 1;font-size: 25px; text-align:left; color:#55a5f4;" >{{rendered_value}}</span>
    <span style="line-height: 1;font-size: 25px; text-align:left; color:#000000;" >cases in total.</span>
    </p>
    ;;
  }

  measure: alerts_count {
    type: count_distinct
    sql: ${alert_identifier};;
  }

  measure: incidents_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_executive_dashboard.incident_flag_on_stage: "1"
    ]
  }

  measure: open_incidents_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_executive_dashboard.incident_flag_on_stage: "1",
      vw_executive_dashboard.case_status: "Open"
    ]
  }

  measure: closed_incidents_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_executive_dashboard.incident_flag_on_stage: "1",
      vw_executive_dashboard.case_status: "Closed"
    ]
  }

  measure: health_summary {
    type: string
    sql: case when ${open_incidents_count}>0 THEN 'Red'
          when ${open_incidents_count}=0 AND ${closed_incidents_count}>0 THEN 'Yellow' ELSE 'Green' END;;
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

  measure: case_met_sla_count {
    type: count_distinct
    sql: ${case_id};;
    filters: [ vw_executive_dashboard.sla_met_flag: "1"
    ]
  }

}
