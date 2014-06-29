# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(email: 'admin@artinkle.com',
                    password: 'foobar',
                    password_confirmation: 'foobar',
                    admin: true,
                    active: true)

Type.create(name: "로고")
Type.create(name: "포스터")
Type.create(name: "앨범커버")
Type.create(name: "간판")
Type.create(name: "패키지")
Type.create(name: "명함")
Type.create(name: "표지")
