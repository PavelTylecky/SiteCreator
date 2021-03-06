# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Template.destroy_all
Template.create(title: "Two columns", html: '<div class="row"><div class="col-md-6 column" id="col1">%{col1}</div><div class="col-md-6 column" id="col2">%{col2}</div></div>
')
Template.create(title: "One column", html: '<div class="row"><div class="col-xs-12 col-md-8 column-full-width" id="col1">%{col1}</div></div>')
Template.create(title: "Three columns", html: '<div class="row">
  <div class="col-xs-12 col-md-8 column-full-width" id="col1">%{col1}</div>
 </div>
 <div class="row">
  <div class="col-xs-6 col-md-4 column" id="col2">%{col2}</div>
  <div class="col-xs-6 col-md-4 column" id="col3">%{col3}</div>
</div>')