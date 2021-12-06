# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
con = Rol.create({name: "consulta"})
asi = Rol.create({name: "asistencia"})
adm = Rol.create({name: "administracion"})

User.create({username: "consu", password: "consu",rol: con})
User.create({username: "asist", password: "asist",rol: asi})
User.create({username: "admin", password: "admin",rol: adm})

profs= Professional.create([{name: "Profe", surname: "Sional"},
    {name: "Nitales", surname: "jorge"},
    {name: "rogER", surname: "fedERER"}
])

rand(5..10).times do |i|
    prof = profs.sample
    date = rand(5..10).days.ago.at_beginning_of_day + rand(8..20).hours
    Appointment.create({
        professional: prof, 
        date: date,
        name: "name" ,
        surname: "apo+#{prof.name}", 
        phone: "#{rand(5..10)}"
    })
end