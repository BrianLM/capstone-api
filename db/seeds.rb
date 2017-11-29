# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Level.create([
               { level: 1, required: 10, energy: 15 },
               { level: 2, required: 12, energy: 15 },
               { level: 3, required: 14, energy: 16 },
               { level: 4, required: 16, energy: 16 },
               { level: 5, required: 18, energy: 17 },
               { level: 6, required: 20, energy: 17 },
               { level: 7, required: 22, energy: 18 },
               { level: 8, required: 24, energy: 18 },
               { level: 9, required: 26, energy: 19 }
             ])
