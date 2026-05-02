bin/rails server -b 0.0.0

bin/rails g scaffold_controller Address link:string place:string cep:string number:string address:string complement:string neighborhood:string city:string state:string

bin/rails g scaffold Customer address:references name:string email:string:uniq tax_id:string:uniq phone:string

rails db:migrate:status
RAILS_ENV=test rails db:migrate:status