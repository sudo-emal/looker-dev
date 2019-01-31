view: user_data_with_c {
  derived_table: {
    sql: SELECT * FROM users
      WHERE email like 'c%'
      order by 2
       ;;
  }

derived_table: {
  sql: SELECT id FROM users
      union all
      SELECT CAST(18.1750000000000000000000 AS DECIMAL(10,5))
order by 1 ;;
}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: decimal_2
  }


  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  set: detail {
    fields: [
      id,
      email,
      first_name,
      last_name,
      gender,
      created_at_time,
      zip,
      country,
      state,
      city,
      age
    ]
  }
}
