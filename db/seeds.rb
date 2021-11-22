# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


example_company = Company.create(
  {
    name: "Mens Salon",
    gstin: "123ABC",
    pan: "DVG123H",
    address: "404, 25th main, BTM, stage 2, Bangalore",
    work_schedule: {
      monday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      tuesday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      wednesday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      thursday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      friday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      saturday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      },
      sunday: {
        start: "09:00 AM",
        fin: "09:00 PM"
      }
    }
  }
)

first_chair = example_company.chairs.create!(barber_name: "Rajini Kanth")
second_chair = example_company.chairs.create!(barber_name: "Kamal Hasan")

hair_cut = example_company.services.create!(name: "Hair Cut", cost: 150, no_of_slots: 2)
shave = example_company.services.create!(name: "Shave", cost: 50, no_of_slots: 1)
