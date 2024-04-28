# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2020-2024, by Samuel Williams.

require 'xrb/sanitize/filter'

describe XRB::Sanitize::Filter::Node do
	with '#limit_attributes' do
		let(:tag) {XRB::Tag.new("img", true, {"src" => "image.jpg", "onclick" => "alert()"})}
		let(:node) {XRB::Sanitize::Filter::Node.new("image", tag, 0)}
		
		it "can limit attributes" do
			node.limit_attributes("src")
			
			expect(node.tag.attributes).to be == {"src" => "image.jpg"}
		end
	end
end
