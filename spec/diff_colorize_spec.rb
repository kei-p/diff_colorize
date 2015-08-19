require 'spec_helper'

describe DiffColorize do
  describe 'version' do
    it 'has a version number' do
      expect(DiffColorize::VERSION).not_to be nil
    end
  end

  RED = "\e[31m"
  PLAIN = "\e[0m"

  describe '.diff' do
    subject { DiffColorize.diff(t1, t2) }

    let(:t1) { "a" }
    let(:t2) { "a" }

    it { expect(subject.class).to eq(DiffColorize::Result) }

    context 'same text' do
      let(:t1) { "a" }
      let(:t2) { "a" }

      it do
        expect(subject.diff[:t1_diff]).to be_empty
        expect(subject.diff[:t2_diff]).to be_empty
      end
    end

    context 'different text' do
      let(:t1) { "abcde" }
      let(:t2) { "aBcDe" }

      it do
        expect(subject.diff[:t1_diff]).not_to be_empty
        expect(subject.diff[:t2_diff]).not_to be_empty
      end

      it 'color' do
        expect(subject.color_t1).to eq("a\e[31mb\e[0mc\e[31md\e[0me")
        expect(subject.color_t2).to eq("a\e[31mB\e[0mc\e[31mD\e[0me")
      end
    end
  end
end
