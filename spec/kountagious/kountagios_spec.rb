require "helper"

describe Kountagious do

	subject { Kountagious }

	it "should be able to call a configure block" do
		subject.configure do |config|
      expect(config).to be(Kountagious)
		end
	end

	it "should be able to configure logging" do
		expect(Kountagious.enable_logging).to be(false)
		Kountagious.enable_logging = true
		expect(Kountagious.enable_logging).to be(true)
		Kountagious.enable_logging = false
		expect(Kountagious.enable_logging).to be(false)
	end

end
