bin/rails server -b 0.0.0

rails db:migrate:status
RAILS_ENV=test rails db:migrate:status


bin/rails g scaffold_controller Address link:string place:string cep:string number:string address:string complement:string neighborhood:string city:string state:string

bin/rails g scaffold Customer address:references name:string email:string:uniq tax_id:string:uniq phone:string

rails g resource Concessionaire name:string acronym:string code:string region:string phone:string email:string active:boolean

rails g scaffold Project client:references{uuid} address:references{uuid} utility_company:string utility_protocol:string customer_class:string integrator:string modality:string framework:string status:string amount:decimal dc_protection:string system_power:float unit_control:string description:string project_type:string fast_track:boolean coordinates:st_point --no-jbuilder



para gerar o swagger apos editar a rotas
RAILS_ENV=test PATTERN="spec/swagger/**/*_spec.rb" rails rswag:specs:swaggerize
