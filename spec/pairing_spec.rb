require 'spec_helper'

describe Pairing do
  context 'associations' do
    it {should belong_to(:tag)}
    it {should belong_to(:expense)}
   end
 end