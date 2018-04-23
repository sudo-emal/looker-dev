# If necessary, uncomment the line below to include explore_source.
include: "demo.model.lkml"
include: "orders.view.lkml"

view: user_facts {
  derived_table: {
    explore_source: orders {
      column: count {}
      column: id { field: users.id }
    }

  }
#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }

  dimension: count {
    type: number
  }
  dimension: id {
    type: number
  }
  measure: first_order_date {
    sql: MIN(${TABLE}.created) ;;
  }
  measure: last_order_date {
    sql: MAX(${TABLE}.created) ;;
  }
#   dimension: days_since_last_purchase {
#
#   }
#   dimension: avg_num_order_per_month {
#
#   }
}
