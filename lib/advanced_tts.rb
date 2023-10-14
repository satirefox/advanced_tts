# frozen_string_literal: true

require 'aws-sdk-polly'

class AdvancedTTS
    def initialize(region, access_key, secret_key)
        @region = region
        @access_key = access_key
        @secret_key = secret_key
    end

    def text_to_mp3(original_text, filename: "output.mp3", prompt: "")
        if original_text
            text = !prompt.empty? ? original_text : call_chatgpt(original_text, prompt)
            call_polly(text, voice_id: "Joanna", filename: filename)
        end
    end

    private

    # use the amazon sdk to call out the amazon given the text
    def call_chatgpt(text, prompt)
        text
    end
    
    # if given a prompt, call out to chatgpt to modify the text
    def call_polly(text, voice_id: "Joanna", filename: "output.mp3")
        polly = Aws::Polly::Client.new

        resp = polly.synthesize_speech({
          output_format: "mp3",
          text: text,
          voice_id: voice_id,
        })

        IO.copy_stream(resp.audio_stream, filename)

        puts 'Wrote MP3 content to: ' + filename

        text
    end
end