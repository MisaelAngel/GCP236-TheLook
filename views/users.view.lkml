# The name of this view in Looker is "Users"
view: users {
  label: "Users"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.users ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90]
    style: integer
    sql: ${age} ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  dimension: city {
    label: "City"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
      day_of_month,
      day_of_year,
      month_name,
      week_of_year,
      hour2
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: current_date {
    type: string
    sql: CURDATE() ;;
  }

  dimension: is_current_week {
    type: yesno
    sql: ${created_week_of_year} = weekofyear(NOW()) AND ${created_year}= year(NOW());;
  }

# SELECT CURDATE();

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    label: "State"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
    # html: <h1 title="The State of {{value}}">{{value}}</h1> ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_california {
    type: count_distinct
    sql: ${id} ;;
    filters: [state: "California"]
  }

  measure: count_greater_than_1000 {
    type: yesno
    sql: ${count}>1000 ;;
  }

  measure: abandoned {
    type: string
    sql: case when ${count} > 1000 then "Abandoned" else "Not Abandoned" end;;
  }

  measure: total_sale_price {
    type: sum
    precision: 0
    sql: 1234;;
  }

  measure: no_agg {
    type: number
    sql: Sum(1000)/count(100);;
  }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
