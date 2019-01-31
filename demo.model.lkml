 connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: demo_default_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {

  sql_always_where: {% condition order_items.global_timeframe %} ${order_items.returned_raw} {% endcondition %} AND {% condition order_items.global_timeframe %} ${orders.created_raw} {% endcondition %};;
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  label: "Label I Want"
  description: "Description I want"
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: user_facts {
    type: left_outer
    sql_on: ${user_facts.id} = ${orders.user_id} ;;
    relationship: many_to_one
  }
}

explore: products {
  sql_always_where: 1=1      {% assign counter = 0 %}
  {% if products.category._is_filtered %}
  {% if counter > 0 %} OR {% else %} AND ({% endif %}
  {% assign counter = counter | plus:1 %}
  {% condition products.category %} ${products.category} {% endcondition %}
  {% endif %}

  {% if products.rank._is_filtered %}
  {% if counter > 0 %} OR {% else %} AND ({% endif %}
  {% assign counter = counter | plus:1 %}
  {% condition products.rank %} ${products.rank} {% endcondition %}
  {% endif %}

  {% if products.brand_filter._is_filtered %}
  {% if counter > 0 %} OR {% else %} AND ({% endif %}
  {% assign counter = counter | plus:1 %}
  {% condition products.brand_filter %} ${products.brand} {% endcondition %}
  {% endif %}

  {% if counter > 0 %} ) {% endif %}
  ;;
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: user_data_with_c {}

explore: static_test {}
# explore: timeframe_test {}
