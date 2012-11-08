require 'spec_helper'

describe Sprint do
  it {should have_many :features}
  it {should belong_to :project}
  it {should validate_presence_of :project}
end
