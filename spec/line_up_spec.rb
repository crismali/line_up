require "spec_helper"

class Product < ActiveRecord::Base
end

RSpec.describe LineUp do
  it "is a module" do
    expect(subject).to be_a(Module)
  end

  it "is mixed into active record base" do
    expect(ActiveRecord::Base.ancestors).to include(subject)
  end
end
