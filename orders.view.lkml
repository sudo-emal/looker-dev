view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    type: string
    sql: "mystring" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
                                 }

  dimension_group: created2 {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

dimension: date_subtract {
  type: number
  sql: datediff(${created2_raw}, ${created_raw}) ;;
}


### Help Center Templated Filter Test Starts Here
## filter determining time range for all "A" measures
#
#   filter: timeframe_a {
#     type: date_time
#   }
#
# ## flag for "A" measures to only include appropriate time range
#
#   dimension: group_a_yesno {
#     hidden: yes
#     type: yesno
#     sql: {% condition timeframe_a %} ${created_raw} {% endcondition %} ;;
#   }
#
# ## filtered measure A
#
#   measure: count_a {
#     type: count
#     filters: {
#       field: group_a_yesno
#       value: "yes"
#     }
#   }
#
# ## filter determining time range for all "B" measures
#
#   filter: timeframe_b {
#     type: date_time
#   }
#
# ## flag for "B" measures to only include appropriate time range
#
# #   dimension: group_b_yesno {
# #     hidden: yes
# #     type: yesno
# #     sql: {% condition timeframe_b %} ${created_raw} {% endcondition %} ;;
# #   }
#
#   dimension: group_b_yesno {
#     # hidden: yes
#     type: yesno
#     sql: DATE_ADD( {% condition timeframe_a %} ${created_raw} {% endcondition %}, INTERVAL -{% parameter timeframe %} month) ;;
#   }
#
#   parameter: timeframe {
#     type: unquoted
#     allowed_value: {
#       value: "1"
#       label: "1 month timeframe"
#     }
#     allowed_value: {
#       value: "6"
#       label: "6 month timeframe"
#     }
#   }
#
#   measure: count_b {
#     type: count
#     filters: {
#       field: group_b_yesno
#       value: "yes"
#     }
#   }
#
#   dimension: is_in_time_a_or_b {
#     group_label: "Time Comparison Filters"
#     type: yesno
#     sql:
#     {% condition timeframe_a %} ${created_raw} {% endcondition %} OR
#     {% condition timeframe_b %} ${created_raw} {% endcondition %} ;;
#   }

### Help Center Templated Filter Test Ends Here


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    suggestions: ["complete"]
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    value_format_name: decimal_2
  }

  dimension: user_id_cat {
    type: string
    # hidden: yes
    sql: concat(${TABLE}.user_id, ${TABLE}.status) ;;

  }

  measure: count {
    label: "Number of Orders"
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  measure: count_dis {
    label: "Number of distinct Orders"
    type: count_distinct
    sql: ${TABLE}.id ;;
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    html: <span title="My tooltip text">{{linked_value}}</span>;;
  }

 filter: previous_period_filter {
   type: date
   description: "Use this filter for period analysis"
 }
}



#  # For Amazon Redshift
#  # ${created_raw} is the timestamp dimension we are building our reporting period off of
#  dimension: previous_period {
#   type: string
#   description: "The reporting period as selected by the Previous Period Filter"
#   sql:
#   CASE
#     WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is not null /* date ranges or in the past x days */
#       THEN
#         CASE
#           WHEN ${created_raw} >=  {% date_start previous_period_filter %}
#             AND ${created_raw} <= {% date_end previous_period_filter %}
#             THEN 'This Period'
#           WHEN ${created_raw} >= DATEADD(day,-1*DATEDIFF(day,{% date_start previous_period_filter %}, {% date_end previous_period_filter %} ) + 1, DATEADD(day,-1,{% date_start previous_period_filter %} ) )
#             AND ${created_raw} <= DATEADD(day,-1,{% date_start previous_period_filter %} )
#             THEN 'Previous Period'
#         END
#       END ;;
#       }
#
