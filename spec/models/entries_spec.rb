require 'spec_helper'

describe "Entries" do
  describe "required fields" do
    before(:each) do
      #TODO
      #@entry should be a database object, created after editing by a user
      @entry = FactoryGirl.create(:entry)
    end

    it "should have a wadoku_id field" do
      @entry.wadoku_id.should_not be_nil
    end
    it "should have a kana field" do
      @entry.kana.should_not be_nil 
      @entry.kana.strip.should_not == ""
    end
    it "should have a writing field" do
      @entry.writing.should_not be_nil
      @entry.writing.strip.should_not == ""
    end
    it "should have a definition field" do
      @entry.definition.should_not be_nil
      @entry.definition.strip.should_not == ""
    end
    it "should have at least one editor" do
      @entry.users.length.should > 0
    end
  end

  describe "database relations" do
    it "should belong to many users" do

    end
  end
end



