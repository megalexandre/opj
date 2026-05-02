require "rails_helper"

RSpec.describe "Customers", type: :request do
  let(:customer) { create(:customer) }

  describe "GET /customers" do
    it "returns paginated customers with metadata" do
      create_list(:customer, 3)

      get "/customers"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["data"].size).to eq(3)
      expect(body["pagination"]).to include("count", "page", "items")
    end

    it "respects page and items params" do
      create_list(:customer, 5)

      get "/customers", params: { page: 1, items: 2 }

      body = JSON.parse(response.body)
      expect(body["data"].size).to eq(2)
      expect(body["pagination"]["items"]).to eq(2)
    end
  end

  describe "GET /customers/:id" do
    it "returns the customer" do
      get "/customers/#{customer.id}"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(customer.id)
      expect(body["name"]).to eq(customer.name)
    end

    it "returns 404 for unknown id" do
      get "/customers/00000000-0000-0000-0000-000000000000"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /customers" do
    context "with valid params" do
      let(:valid_params) do
        {
          name: "Maria Souza",
          email: "maria@exemplo.com",
          tax_id: "98765432100",
          phone: "11988887777",
          address_attributes: {
            place: "Rua Augusta",
            number: "500",
            neighborhood: "Consolação",
            city: "São Paulo",
            state: "SP",
            cep: "01305-000"
          }
        }
      end

      it "creates a customer and returns 201" do
        expect {
          post "/customers", params: valid_params, as: :json
        }.to change(Customer, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["email"]).to eq("maria@exemplo.com")
      end
    end

    context "with duplicate email" do
      it "returns 422" do
        post "/customers", params: { name: "Dup", email: customer.email, address_id: customer.address_id }, as: :json

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /customers/:id" do
    it "updates the customer" do
      patch "/customers/#{customer.id}", params: { name: "Novo Nome" }, as: :json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq("Novo Nome")
    end
  end

  describe "DELETE /customers/:id" do
    it "destroys the customer and its address" do
      id = customer.id

      expect {
        delete "/customers/#{id}"
      }.to change(Customer, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
