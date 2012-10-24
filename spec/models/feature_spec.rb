require 'spec_helper'

describe Feature do

  it {should validate_presence_of :name}

  it {should validate_presence_of :description}

  it {should belong_to :project}


end