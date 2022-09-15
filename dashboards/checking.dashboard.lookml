- dashboard: executive_dashboard_custom_v1
  title: Executive Dashboard v1
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: u2EgWIwCRPZiTO5zBlrBQM
  elements:
  - name: Health Flag (Based on Incidents using Incident Stage)
    title: Health Flag (Based on Incidents using Incident Stage)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.cases_count, vw_executive_dashboard.incidents_count,
      vw_executive_dashboard.open_incidents_count, vw_executive_dashboard.closed_incidents_count]
    limit: 500
    dynamic_fields: [{category: table_calculation, description: 'When there are open
          incidents from the period, the health is red.', expression: "case(\n   \
          \ when(${vw_executive_dashboard.open_incidents_count}>0, \"Red\"),\n   \
          \ when(${vw_executive_dashboard.open_incidents_count}=0 AND ${vw_executive_dashboard.closed_incidents_count}>0\
          \ , \"Yellow\"),\n    \"Green\"\n  \n)", label: Health Flag, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: health_flag,
        _type_hint: string, id: HO2Ike66k1}, {category: table_calculation, expression: "case(\n\
          \    when(${vw_executive_dashboard.open_incidents_count}>0, 2),\n    when(${vw_executive_dashboard.open_incidents_count}=0\
          \ AND ${vw_executive_dashboard.closed_incidents_count}>0 , 1),\n   0\n \
          \ \n)", label: Health Flag Numeric, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: health_flag_numeric, _type_hint: number,
        id: d0K1QoWYho}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    value_format: ''
    conditional_formatting: [{type: equal to, value: 2, background_color: "#EA4335",
        font_color: "#EA4335", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: equal to, value: 1, background_color: "#7CB342",
        font_color: "#7CB342", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: equal to, value: 0, background_color: "#F0C733",
        font_color: "#F0C733", color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_view_names: false
    series_types: {}
    map: usa
    map_projection: ''
    defaults_version: 1
    hidden_fields: [vw_executive_dashboard.cases_count, vw_executive_dashboard.incidents_count,
      vw_executive_dashboard.open_incidents_count, vw_executive_dashboard.closed_incidents_count,
      health_flag]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    value_labels: legend
    label_type: labPer
    hidden_points_if_no: []
    series_labels: {}
    listen: {}
    row: 2
    col: 0
    width: 2
    height: 2
  - name: Health Summary (Based on Incidents using Incident Stage)
    title: Health Summary (Based on Incidents using Incident Stage)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.cases_count, vw_executive_dashboard.incidents_count,
      vw_executive_dashboard.open_incidents_count, vw_executive_dashboard.closed_incidents_count]
    limit: 500
    dynamic_fields: [{category: table_calculation, description: 'When there are open
          incidents from the period, the health is red.', expression: "case(\n   \
          \ when(${vw_executive_dashboard.open_incidents_count}>0, \"Red\"),\n   \
          \ when(${vw_executive_dashboard.open_incidents_count}=0 AND ${vw_executive_dashboard.closed_incidents_count}>0\
          \ , \"Yellow\"),\n    \"Green\"\n  \n)", label: Health Flag, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: health_flag,
        _type_hint: string, id: HO2Ike66k1}, {category: table_calculation, expression: "case(\n\
          \    when(${vw_executive_dashboard.open_incidents_count}>0, 2),\n    when(${vw_executive_dashboard.open_incidents_count}=0\
          \ AND ${vw_executive_dashboard.closed_incidents_count}>0 , 1),\n   0\n \
          \ \n)", label: Health Flag Numeric, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: health_flag_numeric, _type_hint: number,
        id: d0K1QoWYho}, {category: table_calculation, expression: "case(\n    when(${vw_executive_dashboard.open_incidents_count}>0,\
          \ \"The data health is RED - There have been incidents during the reporting\
          \ period and they are open.\"),\n    when(${vw_executive_dashboard.open_incidents_count}=0\
          \ AND ${vw_executive_dashboard.closed_incidents_count}>0 , \"The data health\
          \ is YELLOW - there have been incidents during the reporting period and\
          \ they were closed.\"),\n    \"The data health is GREEN - there have been\
          \ no incidents during the reporting period.\"\n  \n)", label: Health Flag
          Description, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: health_flag_description, _type_hint: string, id: VfbCvZ0cbW}]
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    value_format: ''
    conditional_formatting: []
    show_view_names: false
    series_types: {}
    map: usa
    map_projection: ''
    defaults_version: 1
    hidden_fields: [vw_executive_dashboard.cases_count, vw_executive_dashboard.incidents_count,
      vw_executive_dashboard.open_incidents_count, vw_executive_dashboard.closed_incidents_count,
      health_flag, health_flag_numeric]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    value_labels: legend
    label_type: labPer
    hidden_points_if_no: []
    series_labels: {}
    listen: {}
    row: 2
    col: 2
    width: 22
    height: 2
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: 'The following is a high level overview of Siemplify Security Operations
      Center (SOC). This report focuses on the overall status of the organization
      as well as covers the main metrics that are typically used to measure the SOC
      status. '
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Total Cases (Executive Dashboard)
    title: Total Cases (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.cases_count]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Cases
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 4
    col: 0
    width: 5
    height: 3
  - name: Open vs Closed Cases (Executive Dashboard)
    title: Open vs Closed Cases (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: looker_bar
    fields: [vw_executive_dashboard.cases_count, vw_executive_dashboard.case_status]
    pivots: [vw_executive_dashboard.case_status]
    fill_fields: [vw_executive_dashboard.case_status]
    sorts: [vw_executive_dashboard.case_status]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Total Cases
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    listen: {}
    row: 7
    col: 0
    width: 12
    height: 8
  - name: Incidents (Executive Dashboard)
    title: Incidents (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.incidents_count]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    single_value_title: Total Incidents
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    listen: {}
    row: 4
    col: 10
    width: 5
    height: 3
  - name: Closed Alerts by SOC Role (Executive Dashboard)
    title: Closed Alerts by SOC Role (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: looker_column
    fields: [vw_executive_dashboard.alerts_count, vw_executive_dashboard.soc_role]
    filters:
      vw_executive_dashboard.case_status: Closed
    sorts: [vw_executive_dashboard.alerts_count desc 0]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% Alerts Closed", value_format: !!null '',
        value_format_name: percent_2, calculation_type: percent_of_column_sum, table_calculation: alerts_closed,
        args: [vw_executive_dashboard.alerts_count], _kind_hint: measure, _type_hint: number,
        id: cHC8zOlyK4}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Incidents
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields: [vw_executive_dashboard.alerts_count]
    listen: {}
    row: 15
    col: 0
    width: 12
    height: 7
  - name: Top 10 Alerts by Alert Type or Rule Name (Executive Dashboard)
    title: Top 10 Alerts by Alert Type or Rule Name (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: looker_bar
    fields: [vw_executive_dashboard.alerts_count, vw_executive_dashboard.alert_type]
    filters:
      vw_executive_dashboard.case_status: Closed
    sorts: [vw_executive_dashboard.alerts_count desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Incidents
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 7
    col: 12
    width: 12
    height: 8
  - name: Escalated Cases Handled (Executive Dashboard)
    title: Escalated Cases Handled (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: looker_column
    fields: [vw_executive_dashboard.alerts_count, vw_executive_dashboard.soc_role]
    filters:
      vw_executive_dashboard.case_status: Closed
      vw_executive_dashboard.soc_role: "-%Tier1%"
    sorts: [vw_executive_dashboard.alerts_count desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Incidents
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 15
    col: 12
    width: 12
    height: 7
  - name: True Positive vs False Positive Alerts (Executive Dashboard)
    title: True Positive vs False Positive Alerts (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: looker_pie
    fields: [vw_executive_dashboard.alerts_count, vw_executive_dashboard.case_closed_reason]
    fill_fields: [vw_executive_dashboard.case_closed_reason]
    filters:
      vw_executive_dashboard.case_status: Closed
    limit: 10
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Incidents
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields:
    font_size: 12
    listen: {}
    row: 22
    col: 0
    width: 12
    height: 7
  - name: "% Cases that met SLA (Executive Dashboard)"
    title: "% Cases that met SLA (Executive Dashboard)"
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.case_met_sla_count, vw_executive_dashboard.cases_count]
    limit: 10
    dynamic_fields: [{category: table_calculation, expression: "${vw_executive_dashboard.case_met_sla_count}\n\
          /\n${vw_executive_dashboard.cases_count}", label: "% Cases that met SLA",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        table_calculation: cases_that_met_sla, _type_hint: number, id: 3LwBTpnnpW}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    single_value_title: Cases met SLA
    value_format: 0.00%
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields:
    font_size: 12
    listen: {}
    row: 4
    col: 5
    width: 5
    height: 3
  - name: Cases Open More than N Days (Executive Dashboard)
    title: Cases Open More than N Days (Executive Dashboard)
    model: searcheverythingdb3
    explore: vw_executive_dashboard
    type: single_value
    fields: [vw_executive_dashboard.cases_count]
    filters:
      vw_executive_dashboard.soc_role: SocManager
    limit: 10
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    single_value_title: Cases open for 10 days
    value_format: ''
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: alerts_closed, id: alerts_closed,
            name: "% Alerts Closed"}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types: {}
    series_colors: {}
    series_labels:
      Closed - vw_executive_dashboard.cases_count: Closed
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    hidden_fields:
    font_size: 12
    listen: {}
    row: 4
    col: 15
    width: 5
    height: 3
