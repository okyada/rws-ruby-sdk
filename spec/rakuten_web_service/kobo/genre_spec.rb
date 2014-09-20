require 'spec_helper'
require 'rakuten_web_service'

describe RWS::Kobo::Genre do
  let(:endpoint) { 'https://app.rakuten.co.jp/services/api/Kobo/GenreSearch/20131010' }
  let(:affiliate_id) { 'dummy_affiliate_id' }
  let(:application_id) { 'dummy_application_id' }
  let(:genre_id) { '101' }
  let(:expected_query) do
    {
      :affiliateId => affiliate_id,
      :applicationId => application_id,
      :koboGenreId => genre_id
    }
  end
  let(:expected_json) do
    JSON.parse(fixture('kobo/genre_search.json'))
  end

  before do
    @expected_request = stub_request(:get, endpoint).
      with(:query => expected_query).
      to_return(:body => expected_json)

    RakutenWebService.configuration do |c|
      c.affiliate_id = affiliate_id
      c.application_id = application_id
    end
  end

  describe '.search' do
    before do
      @genre = RWS::Kobo::Genre.search(:koboGenreId => genre_id).first
    end

    specify 'call the endpoint once' do
      expect(@expected_request).to have_been_made.once
    end
  end

end
