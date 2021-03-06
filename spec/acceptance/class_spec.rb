require 'spec_helper_acceptance'

describe 'talend_administration_center class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'talend_administration_center':
        tac_war_url => 'http://foo.com/org.talend.administrator.war',
        tac_domain  => 'https://talend.mycompany.com',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('talend_administration_center') do
      it { is_expected.to be_installed }
    end

    describe service('talend_administration_center') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
