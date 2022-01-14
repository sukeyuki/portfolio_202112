require 'rails_helper'

RSpec.describe Schedule, type: :model do

  context "with valid data" do
    before do
      @schedule = FactoryBot.build(:schedule)
    end

    it "is valid" do
      expect(@schedule).to be_valid
    end
  end

  context "with blank attributes" do
    before do
      @schedule = FactoryBot.build(:schedule, :schedule_with_blank_attributes)
      @schedule.valid?
    end  
    
    it "has :title error" do
      expect(@schedule.errors[:title]).to include("can't be blank")
    end
    it "has :group error" do
      expect(@schedule.errors[:group]).to include("must exist")
    end
    it "has :contents error" do
      expect(@schedule.errors[:contents]).to include("can't be blank")
    end
    it "has :start_at error" do
      expect(@schedule.errors[:start_at]).to include("can't be blank")
    end
    it "has :end_at error" do
      expect(@schedule.errors[:end_at]).to include("can't be blank")
    end
  end

  context "with long attributes" do
    before do
      @schedule = FactoryBot.build(:schedule, :schedule_with_long_attributes)
      @schedule.valid?
    end

    it "has :title error" do
      expect(@schedule.errors[:title]).to include("is too long (maximum is 50 characters)")
    end

    it "has :contents error" do
      expect(@schedule.errors[:contents]).to include("is too long (maximum is 1000 characters)")
    end
  end
end