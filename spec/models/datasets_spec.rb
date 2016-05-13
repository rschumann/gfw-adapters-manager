require 'rails_helper'

describe 'Datasets API request', vcr: true do
  context 'For lists' do
    before :each do
      stub_request(:get, 'http://test-api.com/summary').to_return(body: File.open(File.join('spec/fixtures/cassettes', 'summary.json'), 'r').read, :status => 200)
    end

    it 'returns a list of datasets' do
      datasets = Datasets.list
      expect(datasets[1]['name']).to eq('Test dataset')
    end
  end

  context 'For details' do
    before :each do
      @dataset_id = 'f32805f9-85e2-44b4-b087-6ab497fbb097'
      stub_request(:get,  "http://test-api.com/summary/#{@dataset_id}").to_return(body: File.open(File.join('spec/fixtures/cassettes', 'details.json'), 'r').read, :status => 200)
      stub_request(:post, "http://test-api.com/summary/new").
                   with(:body => "{\"connector\":{\"name\":null,\"data\":null,\"data_columns\":null,\"status\":null,\"description\":null,\"slug\":null,\"units\":null}}",
                        :headers => {'Accept'=>'application/json', 'Authorization'=>'Basic Z2Z3OmFwaTIwMTY=', 'Content-Type'=>'application/json'}).
                   to_return(:status => 200, :body => "", :headers => {})
      stub_request(:put, "http://test-api.com/summary/").
                   with(:body => "{\"connector\":{\"id\":null,\"name\":null,\"data_columns\":null,\"status\":null,\"description\":null,\"slug\":null,\"units\":null}}",
                        :headers => {'Accept'=>'application/json', 'Authorization'=>'Basic Z2Z3OmFwaTIwMTY=', 'Content-Type'=>'application/json', 'Expect'=>''}).
                   to_return(:status => 200, :body => "", :headers => {})
      stub_request(:delete, "http://test-api.com/summary/#{@dataset_id}").to_return(body: '{ "message": "Dataset deleted" }', status: 200)
    end

    let!(:data_columns) {{
                            "pcpuid": {
                              "type": "string"
                            },
                            "the_geom": {
                              "type": "geometry"
                            },
                            "cartodb_id": {
                              "type": "number"
                            },
                            "the_geom_webmercator": {
                              "type": "geometry"
                            }
                          }}

    let!(:data) {[{
                    "pcpuid": "350558",
                    "the_geom": "0101000020E610000000000000786515410000000078651541",
                    "cartodb_id": 2
                  },
                  {
                    "pcpuid": "350659",
                    "the_geom": "0101000020E6100000000000000C671541000000000C671541",
                    "cartodb_id": 3
                  },
                  {
                    "pcpuid": "481347",
                    "the_geom": "0101000020E6100000000000000C611D41000000000C611D41",
                    "cartodb_id": 4
                  },
                  {
                    "pcpuid": "120171",
                    "the_geom": "0101000020E610000000000000B056FD4000000000B056FD40",
                    "cartodb_id": 5
                  },
                  {
                    "pcpuid": "500001",
                    "the_geom": "0101000020E610000000000000806EF84000000000806EF840",
                    "cartodb_id": 1
                }]}

    let!(:params) {{"connector": {
                    "name": "First test dataset",
                    "data_columns": data_columns,
                    "data": data
                  }}}

    it 'returns details for a dataset' do
      dataset = Dataset.find(@dataset_id)
      expect(dataset['name']).to eq('user dataset')
    end

    it 'Allow to create dataset' do
      Dataset.create(params)
    end

    it 'Allow to update dataset' do
      dataset = Dataset.update(@dataset_id)
    end

    it 'Allow to delete dataset' do
      dataset = Dataset.delete(@dataset_id)
    end
  end
end
