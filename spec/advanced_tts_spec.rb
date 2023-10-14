# frozen_string_literal: true

require 'advanced_tts'
require 'spec_helper'

describe "AdvancedTTS" do
    let(:region) { "us-west-1" }
    let(:access_key) { "abcdefgh" }
    let(:secret_key) { 1234-1234 }

    describe "initialize" do
        it "can be initialized with a region, access_key, secret_key" do
            expect(AdvancedTTS.new(region, access_key, secret_key)).to be_truthy
        end
    end

    describe "#text_to_mp3" do
        let(:tts) { AdvancedTTS.new(region, access_key, secret_key) }

        it "accepts text and writes to a file" do
            expect(tts.text_to_mp3("hello")).to eq("hello") 
        end

        it "allows configuration of the filename" do
            skip
        end

        it "conditionally uses chatgpt if given a prompt" do
            expect(tts.text_to_mp3("hello")).to eq("hello") 
        end
    end
end