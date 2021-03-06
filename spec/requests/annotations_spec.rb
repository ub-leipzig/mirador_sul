require 'rails_helper'

RSpec.describe 'Annotations', type: :request do
  describe 'GET /annotations' do
    it 'requires authorization' do
      get annotations_path
      expect(response).to have_http_status(401)
    end
  end
end
