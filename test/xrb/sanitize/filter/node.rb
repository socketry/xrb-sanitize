# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2020-2024, by Samuel Williams.

require 'xrb/sanitize/filter'

describe XRB::Sanitize::Filter::Node do
	describe '#limit_attributes' do
		let(:tag) {XRB::Tag.new("img", true, {"src" => "image.jpg", "onclick" => "alert()"})}
		subject {XRB::Sanitize::Filter::Node.new("image", tag, 0)}
		
		it "can limit attributes" do
			subject.limit_attributes("src")
			
			expect(subject.tag.attributes).to be == {"src" => "image.jpg"}
		end
	end
end
