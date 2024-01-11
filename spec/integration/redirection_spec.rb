require 'swagger_helper'

describe 'Redirection API' do
  path '/{short_url}' do
    get 'Redirects to the original URL' do
      tags 'Redirection'
      produces 'text/plain'
      parameter name: :short_url, in: :path, type: :string

      response '302', 'redirected to original URL' do
        let(:original_url) { 'http://youtube.com' }
        let!(:link) { Link.create(original_url: original_url, visit_count: 0) }
        let(:short_url) { link.short_url }

        run_test! do |response|
          expect(response.status).to eq(302)
          expect(response.location).to eq(original_url)
          link.reload
          expect(link.visit_count).to eq(1)
        end
      end

      response '404', 'not found' do
        let(:short_url) { 'nonexistent' }
        run_test!
      end
    end
  end
end
