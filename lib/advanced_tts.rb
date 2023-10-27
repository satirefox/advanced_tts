# frozen_string_literal: true

require 'aws-sdk-polly'

puts "hello world from advanced_tts"

class AdvancedTTS
    # TODO: Rework the args
    def initialize#(region, access_key, secret_key)
        # @region = region
        # @access_key = access_key
        # @secret_key = secret_key
    end

    def text_to_mp3(original_text, filename: "output.mp3", prompt: "")
        puts "hello from text_to_mp3: #{original_text}"
        if original_text
            trimmed_text = original_text.gsub("!say", "")
            text = !prompt.empty? ? trimmed_text : call_chatgpt(trimmed_text, prompt)
            call_polly_and_write_to_file(text, filename: filename)
        end
    end

    private

    # if given a prompt, call out to chatgpt to modify the text
    def call_chatgpt(text, prompt)
        text
    end
    
    # use the amazon sdk to call out the amazon given the text
    def call_polly_and_write_to_file(text, voice_id: "Russell", filename: "output.mp3")
        puts "hello from call_polly_and_write_to_file"
        
        polly = Aws::Polly::Client.new

        puts "Making an API call with this text: #{text}"

        resp = polly.synthesize_speech({
          output_format: "mp3",
          text: "<speak>#{text}</speak>",
          voice_id: voice_id,
          text_type: "ssml"
        })

        puts "Response: Status Succeeded? #{resp.successful?} : #{resp.data}"

        IO.copy_stream(resp.audio_stream, filename)

        puts 'Wrote MP3 content to: ' + filename

        text
    end

    private

    # def text_type(text)
    #     contains_ssml?(text) ? "ssml" : "text"
    # end

    # def contains_ssml?(text)
    #     # Search for SSML tags in the text
    #     ssml_tags = text.scan(/<[^>]+>/)
        
    #     # If SSML tags are found, it's likely SSML content
    #     ssml_tags.any?

    #     #"text"
    # end
end

AdvancedTTS.new.text_to_mp3(ARGV[0], filename: "C:/Recording Setup/Streamer.bot-latest/tts_files/output.mp3")