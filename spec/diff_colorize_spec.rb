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
        expect(subject.t1_diff).to be_empty
        expect(subject.t2_diff).to be_empty
      end
    end

    context 'different text' do
      let(:t1) { "abcde" }
      let(:t2) { "aBcDe" }

      it do
        expect(subject.t1_diff).not_to be_empty
        expect(subject.t2_diff).not_to be_empty
      end

      it 'color' do
        expect(subject.color_t1).to eq("a\e[31mb\e[0mc\e[31md\e[0me")
        expect(subject.color_t2).to eq("a\e[32mB\e[0mc\e[32mD\e[0me")
      end
    end

    context 'change color' do
      let(:t1) { "abcde" }
      let(:t2) { "aBcDe" }

      before do
        subject.color1 = "\e[33m"
        subject.color2 = "\e[34m"
      end

      it 'color' do
        expect(subject.color_t1).to eq("a\e[33mb\e[0mc\e[33md\e[0me")
        expect(subject.color_t2).to eq("a\e[34mB\e[0mc\e[34mD\e[0me")
      end
    end
  end

  describe '#superimpose' do
    subject { DiffColorize.diff(t1, t2).superimpose }

    let(:t1) { "AAAabcdeAAA" }
    let(:t2) { "AAAaBcDeAAA" }

    it do
      expect(subject).to eq("AAAa\e[31mb\e[0m\e[32mB\e[0mc\e[31md\e[0m\e[32mD\e[0meAAA")
    end
  end
end
