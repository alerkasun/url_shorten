require 'swagger_helper'

describe 'Links API' do
  after(:each) do
    Link.delete_all
  end

  path '/api/links' do
    post 'Creates a link' do
      tags 'Links'
      consumes 'application/json'
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          original_url: { type: :string }
        },
        required: [ 'original_url' ]
      }

      response '201', 'link created' do
        let(:link) { { original_url: 'http://example.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:link) { { original_url: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:link) { { original_url: '' } }
        run_test!
      end
    end

    get 'Retrieves all links' do
      tags 'Links'
      produces 'application/json'

      response '200', 'links found' do
        before do
          3.times do |i|
            Link.create(original_url: "http://example#{i}.com", short_url: "Exmpl#{i}")
          end
        end

        run_test!
      end
    end
  end

  path '/api/links/{short_url}' do
    delete 'Deletes a link' do
      tags 'Links'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :short_url, in: :path, type: :string
      parameter name: :password, in: :query, type: :string

      response '403', 'invalid link or password' do
        let!(:link) { Link.create(original_url: "http://example.com", short_url: "L891J6mK", password: "password") }
        let(:short_url) { 'L891J6mK' }
        let(:password) { 'wrongpassword' }
        run_test!
      end

      response '403', 'invalid link or password' do
        let(:short_url) { 'wrong_short_url' }
        let(:password) { 'password' }
        run_test!
      end
    end
  end
end
