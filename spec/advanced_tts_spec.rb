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
        let(:polly_client) { double('polly') }
        let(:synthesize_response) { double('response') }
        let(:io_stream) { double('io_stream') }

        it "accepts text and writes to a file" do
            # an API call is made to amazon polly which returns a synthesize response
            expect(polly_client).to receive(:synthesize_speech).and_return(synthesize_response)
            expect(Aws::Polly::Client).to receive(:new).and_return(polly_client)
            
            # we then pull the audio stream from the api response
            expect(synthesize_response).to receive(:audio_stream)

            # Mock file writes
            expect(IO).to receive(:copy_stream).with(anything, "output.mp3")

            expect(tts.text_to_mp3("hello")).to eq("hello") 
        end

        it "allows configuration of the filename" do
            # an API call is made to amazon polly which returns a synthesize response
            expect(polly_client).to receive(:synthesize_speech).and_return(synthesize_response)
            expect(Aws::Polly::Client).to receive(:new).and_return(polly_client)
            
            # we then pull the audio stream from the api response
            expect(synthesize_response).to receive(:audio_stream)

            # Mock file write to a different file
            expect(IO).to receive(:copy_stream).with(anything, "newfile.mp3")

            expect(tts.text_to_mp3("hello", filename: "newfile.mp3")).to eq("hello")
        end

        it "conditionally uses chatgpt if given a prompt" do
            # expect(tts.text_to_mp3("hello", prompt: "Pretend you're a goofy guy")).to eq("hello") 
        end
    end
end