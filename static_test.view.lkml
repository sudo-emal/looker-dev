view: static_test {
  derived_table: {
    sql: SELECT CAST(18.1750000000000000000000 AS DECIMAL(10,5)) as test
    union
    select id from orders
    group by 1;;
  }
}
