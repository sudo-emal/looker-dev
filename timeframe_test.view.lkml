view: timeframes {
  sql_table_name: demo_db.orders ;;

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      week_of_year,
      hour_of_day,
      day_of_week,
      day_of_week_index
    ]
    sql: ${TABLE}.created_at ;;
    # sql: DATE(CONVERT_TZ(${TABLE}.created_at ,'UTC','America/Los_Angeles')) ;;
  }

  measure: count {
    type: count
  }



  measure: timeframe_count {
    type: count
    filters: {
      field: timeframe_date
      value: "yes"
    }
  }

  dimension: timeframe_date {
    type: date
    sql: (((${TABLE}.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(CONVERT_TZ(NOW(),'UTC','America/Los_Angeles')),'%Y-%m-01')),INTERVAL -{% parameter timeframe %} month)))
      AND (${TABLE}.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE_FORMAT(DATE(CONVERT_TZ(NOW(),'UTC','America/Los_Angeles')),'%Y-%m-01')),INTERVAL -{% parameter timeframe %} month),INTERVAL {% parameter timeframe %} month))))) ;;
  }



  parameter: timeframe {
    type: unquoted
    allowed_value: {
      value: "1"
      label: "1 month timeframe"
    }
    allowed_value: {
      value: "6"
      label: "6 month timeframe"
    }
  }

}
