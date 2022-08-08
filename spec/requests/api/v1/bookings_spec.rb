require 'swagger_helper'

RSpec.describe 'api/v1/bookings', type: :request do

  path '/api/v1/bookings/create' do

    post("create reservation") do
      tags "Reservations"
      consumes "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
            reservation: {
              type: :object,
              properties: {
                start_date: {type: :string, format: :datetime},
                end_date: {type: :string, format: :datetime},
                expected_payout_amount: {type: :string},
                guest_details: {
                  type: :object,
                  properties: {
                    localized_description: {type: :string},
                    number_of_adults: {type: :integer},
                    number_of_children: {type: :integer},
                    number_of_infants: {type: :integer}
                  }
                },
                guest_email: {type: :string},
                guest_first_name: {type: :string},
                guest_id: {type: :integer},
                guest_last_name: {type: :string},
                guest_phone_numbers: {type: :array}
                listing_security_price_accurate: {type: :string},
                host_currency: {type: :string},
                nights: {type: :integer},
                number_of_guests: {type: :integer},
                status_type: {type: :string},
                total_paid_amount_accurate: {type: :string}
              }
            }
          }
        }
      }

      response "200", "reservation created" do
        let(:payload) {
          {
            reservation: {
              start_date: "2021-03-12",
              end_date: "2021-03-16",
              expected_payout_amount: "3800.00",
              guest_details: {
                localized_description: "4 guests",
                number_of_adults: 2,
                number_of_children: 2,
                number_of_infants: 0
              },
              guest_email: "wayne_woodbridge@bnb.com",
              guest_first_name: "Wayne",
              guest_id: 1,
              guest_last_name: "Woodbridge",
              guest_phone_numbers: %w[639123456789 639123456789],
              listing_security_price_accurate: "500.00",
              host_currency: "AUD",
              nights: 4,
              number_of_guests: 4,
              status_type: "accepted",
              total_paid_amount_accurate: "4500.00"
            }
          }
        }
        run_test!
      end
    end

    post("create booking") do
      tags "Bookings"
      consumes "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          start_date: {type: :string, format: :datetime},
          end_date: {type: :string, format: :datetime},
          nights: {type: :integer},
          guests: {type: :integer},
          adults: {type: :integer},
          children: {type: :integer},
          infants: {type: :integer},
          status: {type: :string},
          guest: {
            type: :object,
            properties: {
              id: {type: :integer},
              first_name: {type: :string},
              last_name: {type: :string},
              phone: {type: :string},
              email: {type: :string}

            }
          },
          currency: {type: :string},
          payout_price: {type: :string},
          security_price: {type: :string},
          total_price: {type: :string}
        }
      }

      response "200", "booking created" do
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
        run_test!
      end
    end
  end
  end
end
