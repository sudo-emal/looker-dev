view: user_facts {
  derived_table: {
    indexes: ["id"]
    persist_for: "6 hours"
    sql: /*
      User ID
      Total number of orders
      First order date
      Latest order date
      Days since first purchase
      Repeat customer (yesno)
      Average number of orders per month
      */

      select
      u.id
      , CAST(18.1750000000000000000000 AS DECIMAL(10,5)) as test
      , count(o.id) as total_orders
      , min(o.created_at) as first_order
      , max(o.created_at) as last_order
      , if(der.total_orders > 1, true, false) as is_repeat_customer

      -- , timestampdiff(month, min(o.created_at), max(o.created_at)) as month_diff
      , ifnull(
          case
            when timestampdiff(month, min(o.created_at) , max(o.created_at)) <> 0 and count(o.id) <> 0
              then count(o.id) / timestampdiff(month, min(o.created_at), max(o.created_at))
            when timestampdiff(month, min(o.created_at) , max(o.created_at)) = 0 and count(o.id) = 1
              then 1
            else 0 end, 0)
          as avg_orders_per_month
      from orders o
        inner join users u
          on u.id = o.user_id
      left join (
        select u.id, count(o.id) as total_orders
        from users u
          inner join orders o
            on o.user_id = u.id
        group by 1
        -- having count(o.id) > 1
      ) der
        on der.id = u.id
      group by 1
      order by 1
      LIMIT 500
      /*
      select u.id, count(o.id) as total_orders
      from users u
        inner join orders o
          on o.user_id = u.id
      group by 1
      having count(o.id) > 1
      */
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    sql: ${TABLE}.last_order ;;
  }

  dimension: is_repeat_customer {
    type: number
    sql: ${TABLE}.is_repeat_customer ;;
  }

  dimension: avg_orders_per_month {
    type: number
    sql: ${TABLE}.avg_orders_per_month ;;
  }

  set: detail {
    fields: [
      id,
      total_orders,
      first_order_time,
      last_order_time,
      is_repeat_customer,
      avg_orders_per_month
    ]
  }
}
