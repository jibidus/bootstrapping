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

    describe "execute" do
        describe "with valid command" do
            let(:command) { "exit 0" }
            it "executes given command" do
                expect { execute(command) }.not_to raise_error
            end
        end
        describe "with invalid command" do
            let(:command) { "exit 1" }
            it "raise exception" do
                expect { execute(command) }.to raise_error.with_message(/Command 'exit 1' failed/)
            end
        end
    end

    describe "check_prerequisite" do
        let(:application_name) { "Test application" }
        subject { check_prerequisite(executable, application_name) }
        describe "with a valid executable" do
            let(:executable) { "ruby" }
            it "does not raise any error" do
                expect { subject }.not_to raise_error
            end
        end
        describe "with an unknown executable" do
            let(:executable) { "unknown" }
            it "raises error" do
                expect { subject }.to raise_error.with_message(/Prerequisite 'Test application' not installed \(executable 'unknown' not found in PATH environment variable\)/)
            end
        end
    end
end
