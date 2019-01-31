- dashboard: new_dashboard
  title: New Dashboard
  layout: newspaper
  elements:
  - title: HTML Tile
    name: HTML Tile
    model: demo
    explore: order_items
    type: table
    fields:
    - order_items.id
    - order_items.inventory_item_id
    - order_items.order_id
    - order_items.sale_price
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Order Item ID Less: order_items.id
    note_state: collapsed
    note_display: hover
    note_text: This is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!This
      is a reeeeeeeeeaaaaaaaaallllllyyyyyyyyy looooooooong descriptionnnnnnnnnnnnnn!!!!!!!
    row: 0
    col: 0
    width: 6
    height: 8
  - title: Month Filter
    name: Month Filter
    model: demo
    explore: order_items
    type: single_value
    fields:
    - order_items.count
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    listen:
      Untitled Filter: order_items.returned_date
    row: 0
    col: 6
    width: 8
    height: 6
  filters:
  - name: Untitled Filter
    title: Untitled Filter
    type: date_filter
    default_value: ''
    allow_multiple_values: true
    required: false
  - name: Order Item ID Less
    title: Order Item ID Less
    type: field_filter
    default_value: "<10"
    allow_multiple_values: true
    required: false
    model: demo
    explore: order_items
    listens_to_filters: []
    field: order_items.id
