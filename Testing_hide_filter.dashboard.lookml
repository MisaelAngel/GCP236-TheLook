- dashboard: group_folder
  title: Group Folder
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Xk4OxEcK1PROkJcPTBOmEH
  elements:
  - title: Group Folder
    name: Group Folder
    model: mtrmisathelook
    explore: users
    type: table
    fields: [users.state, users.count]
    sorts: [users.count desc 0]
    limit: 500
    column_limit: 50
    listen:
      State: users.state
      City: users.city
    row:
    col:
    width:
    height:
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: mtrmisathelook
    explore: users
    listens_to_filters: []
    field: users.state
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: mtrmisathelook
    explore: users
    listens_to_filters: [State]
    field: users.city
