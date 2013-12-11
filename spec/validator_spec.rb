require File.dirname(__FILE__) + '/spec_helper.rb'

describe AdMobApi::Validator do
  include AdMobApi::Validator

  describe '#validate' do
    subject { ->{ validate(response) } }
    let(:response) { { 'errors' => errors, 'warnings' => [] } }

    context 'when response contains error' do
      let(:errors) { [ {'msg' => msg} ] }

      context 'when password is invalid' do
        let(:msg) { 'Invalid email or password.' }
        it { should raise_error AdMobApi::AuthenticationError }
      end

      context 'when client key is invalid' do
        let(:msg) { 'client_key has invalid value 123456789abc.' }
        it { should raise_error AdMobApi::AuthenticationError }
      end

      context 'when unauthorized' do
        let(:msg) { 'token is a required parameter.' }
        it { should raise_error AdMobApi::UnauthorizedError }
      end
    end

    context "when response doesn't contain error" do
      let(:errors) { [] }
      it { should_not raise_error }
    end
  end
end
