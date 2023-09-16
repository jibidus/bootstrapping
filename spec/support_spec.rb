require_relative '../support'
require_relative 'tempdir'
require 'fileutils'

RSpec.describe "support" do
    describe "append_text" do
        include_context :uses_temp_dir
        let(:file) { "#{temp_dir}/append_text_spec"}
        describe "with existing empty file" do
            before { FileUtils.touch(file) }
            it "append given text" do
                append_text "text", file
                expect(File.read(file)).to eq("text")
            end
        end
        describe "with existing not empty file" do
            before { File.open(file, 'w') { |f| f.write("line1\nline2\n") } }
            it "append given text" do
                append_text "text", file
                expect(File.read(file)).to eq("line1\nline2\ntext")
            end
            # TODO: file does end with \n
        end
        describe "with unexisting file" do
            it "creates it" do
                append_text "text", file
                expect(File.exist?(file)).to be_truthy
            end
        end
    end
end
