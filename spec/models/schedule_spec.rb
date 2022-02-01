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
      expect(@schedule.errors[:title]).to include("を入力してください")
    end
    it "has :group error" do
      expect(@schedule.errors[:group]).to include("を入力してください")
    end
    it "has :start_at error" do
      expect(@schedule.errors[:start_at]).to include("を入力してください")
    end
    it "has :end_at error" do
      expect(@schedule.errors[:end_at]).to include("を入力してください")
    end
  end

  context "with long attributes" do
    before do
      @schedule = FactoryBot.build(:schedule, :schedule_with_long_attributes)
      @schedule.valid?
    end

    it "has :title error" do
      expect(@schedule.errors[:title]).to include("は50文字以内で入力してください")
    end

    it "has :contents error" do
      expect(@schedule.errors[:contents]).to include("は1000文字以内で入力してください")
    end
  end
end