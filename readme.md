bin/rails server -b 0.0.0

rails db:migrate:status
RAILS_ENV=test rails db:migrate:status


bin/rails g scaffold_controller Address link:string place:string cep:string number:string address:string complement:string neighborhood:string city:string state:string

bin/rails g scaffold Customer address:references name:string email:string:uniq tax_id:string:uniq phone:string

rails g resource Concessionaire name:string acronym:string code:string region:string phone:string email:string active:boolean

rails g scaffold Project client:references{uuid} address:references{uuid} utility_company:string utility_protocol:string customer_class:string integrator:string modality:string framework:string status:string amount:decimal dc_protection:string system_power:float unit_control:string description:string project_type:string fast_track:boolean coordinates:st_point --no-jbuilder



/**/

@Entity
@Table(name = "concessionaires")
data class CompanyEntity(

    @Id
    @Column(name = "id", nullable = false, updatable = false)
    var id: UUID,

    @Column(name = "name", nullable = false)
    var name: String,

    @Column(name = "acronym")
    var acronym: String?,

    @Column(name = "code")
    var code: String?,

    @Column(name = "region")
    var region: String?,

    @Column(name = "phone")
    var phone: String?,

    @Column(name = "email")
    var email: String?,

    @Column(name = "active", nullable = false)
    var active: Boolean,

) {