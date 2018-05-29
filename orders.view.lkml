view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
### Help Center Templated Filter Test Starts Here
## filter determining time range for all "A" measures

  filter: timeframe_a {
    type: date_time
  }

## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${created_raw} {% endcondition %} ;;
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
    sql: {% condition timeframe_b %} ${created_raw} {% endcondition %} ;;
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
    {% condition timeframe_a %} ${created_raw} {% endcondition %} OR
    {% condition timeframe_b %} ${created_raw} {% endcondition %} ;;
  }

### Help Center Templated Filter Test Ends Here


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
