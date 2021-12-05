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

User.create({username: 'consu', password: 'consu',rol: con})
User.create({username: 'asist', password: 'asist',rol: asi})
User.create({username: 'admin', password: 'admin',rol: adm})

Professional.create({name: ''})
