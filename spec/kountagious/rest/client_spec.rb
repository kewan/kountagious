require "helper"

describe Kountagious::REST::Client do

	subject { Kountagious::REST::Client.new }

  it "should be able to find categories" do
    response = subject.get(categories: nil)

    expect(response.count).to eq 1
    expect(response.first['name']).to eq "Hot Drinks"
  end

  it "should be able to do find products" do
  	response = subject.get({categories: 234, products: nil, scope: :sites})
  	expect(response.count).to eq 2
    cappaccino = response.first
    expect(cappaccino['name']).to eq 'Cappaccino'
    expect(cappaccino['is_modifier']).to be(false)

    almond_milk = response.last
    expect(almond_milk['name']).to eq 'Almond milk'
    expect(almond_milk['is_modifier']).to be(true)
  end

  it "should be able to do find a product" do
    response = subject.get({categories: 234, products: 2345, scope: :sites})
    expect(response['name']).to eq 'Latte'
    expect(response['is_modifier']).to be(false)
    expect(response['image']).to eq("http://images.com/latte.png")
    expect(response['unit_price']).to eq("3.0")
  end

	# it "should throw an error when creating a client without required tokens" do
	# 	Kountagious.client_token = nil
	# 	expect { Kountagious::REST::Client.new }.to raise_error Kountagious::Errors::MissingOauthDetails
	# end
  #
	# it "should be able to create a new client" do
	# 	subject.should be_an_instance_of(Kountagious::REST::Client)
	# end
  #
	# it "should be able to generate a url from an ordered hash" do
	# 	subject.path_from_hash({companies: 162, products: nil}).should eq("companies/162/products")
	# 	subject.path_from_hash({companies: 162, products: 1234}).should eq("companies/162/products/1234")
	# end
  #
	# it "should be able to create objects from a response" do
	# 	responses = subject.objects_from_response(Kountagious::Product, :get, {companies: 162, products: nil})
	# 	responses.each do |response|
	# 		response.should be_an_instance_of Kountagious::Product
	# 	end
	# end
  #
	# it "should be able to create an object from a response" do
	# 	subject.object_from_response(Kountagious::Product, :get, {companies: 162, products: 555}).should be_an_instance_of Kountagious::Product
	# end
  #
	# it "should refresh the token automatically" do
	# 	stub_request(:get, group_endpoint('noop')).to_return(:body => {:message => "The access token provided has expired"}, :headers => endpoint_headers, :status => 400)
	# 	stub_request(:post, "https://api.kounta.com/v1/token.json")
	# 	expect { subject.perform({:company_id => 123, :noop => nil}, :get) }.to raise_error OAuth2::Error
	# end

end
