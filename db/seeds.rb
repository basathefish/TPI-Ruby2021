# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
con = Rol.create({name: 'consulta'})
asi = Rol.create({name: 'asistencia'})
adm = Rol.create({name: 'administracion'})

users = User.create({name: 'consu', rol: con})
users = User.create({name: 'asist', rol: asi})
users = User.create({name: 'admin', rol: adm})