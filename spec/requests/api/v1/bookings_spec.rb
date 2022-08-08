require 'swagger_helper'

RSpec.describe 'api/v1/bookings', type: :request do

  path '/api/v1/bookings/create' do

    post("create booking") do
      tags "Bookings"
      consumes "application/json"
      parameter name: "ACCEPT", in: :header, type: :string
      # parameter name: :booking, in: :body, schema: {
      #   type: :object,
      #   properties: {
      #     requestId: {type: :string, format: :uuid},
      #     travellers: {
      #       type: :array,
      #       items: [
      #         properties: {
      #           firstName: {type: :string},
      #           lastName: {type: :string},
      #           title: {type: :string},
      #           email: {type: :string},
      #           primary: {type: :boolean}
      #         }
      #       ]
      #     },
      #     property: {
      #       type: :object,
      #       properties: {
      #         name: {type: :string}
      #       }
      #     },
      #     stay: {
      #       type: :object,
      #       properties: {
      #         checkIn: {type: :string, format: :datetime},
      #         checkOut: {type: :string, format: :datetime},
      #         specialRequests: {type: :string},
      #         adults: {type: :integer},
      #         children: {type: :integer}
      #       }
      #     }
      #   },
      #   required: ["requestId"]
      }

      response "200", "booking created" do
        # let("ACCEPT") { "application/json" }
        let(:payload) {
          {
            start_date: "2021-03-12",
            end_date: "2021-03-16",
            nights: 4,
            guests: 4,
            adults: 2,
            children: 2,
            infants: 0,
            status: "accepted",
            guest: {
              id: 1,
              first_name: "Wayne",
              last_name: "Woodbridge",
              phone: "639123456789",
              email: "wayne_woodbridge@bnb.com"
            },
            currency: "AUD",
            payout_price: "3800.00",
            security_price: "500",
            total_price: "4500.00"
          }

        }
        run_test!
      end

      response "422", "invalid request" do
        let(:booking) { {booking: {name: "foo"}} }
        let("ACCEPT") { "application/json" }
        run_test!
      end
    end
  end
  end
end
