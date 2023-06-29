describe 'POST /api/v1/app/unlink' do
  subject { JSON.parse(response.body, symbolize_names: true) }

  let(:api_key) { Settings.api_key }

  let!(:ciu_id) { '123456789012345' }

  let!(:obd_device) { create(:obd_device) }
  let!(:obd_id) { obd_device.string_id }
  let!(:car_information_utility) { create(:car_information_utility, string_id: ciu_id, app_type: 'CIU', obd_device: obd_device) }

  before do
    post api_v1_app_unlink_path, params
  end

  context 'invalid params' do
    let(:params) {
      {
        api_key:  api_key,
        ciu_id:   ciu_id,
        app_type: app_type,
        obd_id:   obd_id
      }
    }
    let(:app_type) { 'CIU' }

    include_examples 'invalid api_key'
    include_examples 'invalid obd_id'
    include_examples 'invalid app_type'
    include_examples 'invalid combination of obd_id and ciu'
    context 'nothing obd_id' do
      let(:params) {
        {
          api_key:  api_key,
          ciu_id:   ciu_id,
          app_type: app_type
        }
      }

      it {
        is_expected.to eq({
          result: { status: 'INVALID_PARAM' }
        })
      }
    end
  end
