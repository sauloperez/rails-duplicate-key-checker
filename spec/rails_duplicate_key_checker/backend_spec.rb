require 'spec_helper'

describe RailsDuplicateKeyChecker::Backend do
  let(:backend) { described_class.new('teambox_development', 'root') }

  describe '#run' do
    subject { backend.run }

    before do
      allow(Kernel)
        .to receive(:system)
        .with('pt-duplicate-key-checker D=teambox_development -u root')
        .and_return('command output')
    end

    it { is_expected.to eq('command output') }
  end

  describe '#success?' do
    subject { backend.success? }

    context 'when the command is successful' do
      before do
        allow($?).to receive(:exitstatus).and_return(0)
      end

      it { is_expected.to be true }
    end

    context 'when the command is unsuccessful' do
      before do
        allow($?).to receive(:exitstatus).and_return(-1)
      end

      it { is_expected.to be false }
    end
  end
end
