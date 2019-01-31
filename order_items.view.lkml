view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
    html: <p align="center">{{ value }}</p> ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  filter: global_timeframe {
    type: date_time
  }

### Help Center Templated Filter Test Starts Here
## filter determining time range for all "A" measures

  filter: timeframe_a {
    type: date_time
  }

## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${returned_raw} {% endcondition %} ;;
  }

## filtered measure A

  measure: count_a {
    type: count
    filters: {
      field: group_a_yesno
      value: "yes"
    }
  }

## filter determining time range for all "B" measures

  filter: timeframe_b {
    type: date_time
  }

## flag for "B" measures to only include appropriate time range

  dimension: group_b_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_b %} ${returned_raw} {% endcondition %} ;;
  }

  measure: count_b {
    type: count
    filters: {
      field: group_b_yesno
      value: "yes"
    }
  }

  dimension: is_in_time_a_or_b {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
    {% condition timeframe_a %} ${returned_raw} {% endcondition %} OR
    {% condition timeframe_b %} ${returned_raw} {% endcondition %} ;;
  }

### Help Center Templated Filter Test Ends Here


  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
}
