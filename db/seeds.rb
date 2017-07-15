# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username:  "admin",
             password:              "admin",
             password_confirmation: "admin",
             admin: true,
             name:  "Administrator",
             birthday:  "May 6, 1988",
             contact_no:  "09162411416",
             account_no:  "00742020882080",
             bank:  "BDO",
             base_salary:  "18000",
             no_of_dependents: "0",
             status: "Single",
             sss_no: "01030425020240",
             philhealth_no: "913019104220",
             pagibig_no: "1290294208420",
             tin_no: "9039101082089",
             address: "Katipunan Ave, Prince Condo",
             date_hired: "April 4, 2017",
             job: "Application Developer",
             position: "Trainee"
             )

# 99.times do |n|
#   name  = Faker::Name.name
#   username = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name: name,
#                username:  username,
#                password:              password,
#                password_confirmation: password,
#                status:              "Single",
#                birthday:            "May 6, 1988",
#                date_hired: "April 4, 2017",
#                address:              "Katipunan Ave, Prince Condo",
#                base_salary:         Random::rand(30000) + 12000,
#                bank: ["BDO", "BPI", "Metrobank", "Unionbank", "PSBank"].sample,
#                account_no: Faker::Number.number(10),
#                sss_no: Faker::Number.number(10),
#                philhealth_no: Faker::Number.number(10),
#                pagibig_no: Faker::Number.number(10),
#                tin_no: Faker::Number.number(10),
#                no_of_dependents: "0",
#                contact_no:  Faker::Number.number(10),
#                job: "Application Developer",
#                position: "Trainee"
#                )
# end