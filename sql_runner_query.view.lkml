explore: sql_runner_query {}

view: sql_runner_query {
  derived_table: {
    sql: select sleep(30)
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sleep30 {
    type: number
    sql: ${TABLE}.`sleep(30)` ;;
  }

  set: detail {
    fields: [sleep30]
  }
}
