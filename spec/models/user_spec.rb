require 'spec_helper'

describe User do

  describe ".top_rated" do
   before :each do
     post = nil
     topic = create(:topic)
     @u0 = create(:user) do |user|
       post = user.posts.build(attributes_for(:post))
       post.topic = topic
       post.save
       c = user.comments.build(attributes_for(:comment))
       c.post = post
       c.save
     end

     @u1 = create(:user) do |user|
       c = user.comments.build(attributes_for(:comment))
       c.post = post
       c.save
       post = user.posts.build(attributes_for(:post))
       post.topic = topic
       post.save
       c = user.comments.build(attributes_for(:comment))
       c.post = post
       c.save
     end
   end

   it "should return users based on comments + posts" do
     User.top_rated.should eq([@u1, @u0])
   end
   it "should have 'posts_count' on user" do
     users = User.top_rated
     users.first.posts_count.should eq(1)
   end
   it "should have 'comments_count' on user" do
     users = User.top_rated
     users.first.comments_count.should eq(2)
   end
   it "should have 'posts_count' on user" do
      users = User.top_rated
      users.last.posts_count.should eq(1)
    end
    it "should have 'comments_count' on user" do
      users = User.top_rated
      users.last.comments_count.should eq(1)
    end
  end

  describe ".role?" do
    before :each do
      ROLES = %w[member moderator admin]
      @u0 = create(:user) do |user|
        user.role = 'member'
      end

      @u1 = create(:user) do |user|
        user.role = 'moderator'
      end

      @u2 = create(:user) do |user|
        user.role = 'admin'
      end
    end

    it "should return false for 'role.nil?'" do
      @u0.role.nil?.should eq(false)
    end
    it "should return true for the index comparison" do
      ROLES.index(@u0.role.to_s) <= ROLES.index('member') == true
    end
    it "should return true for the index comparison" do
      ROLES.index(@u1.role.to_s) <= ROLES.index('admin') == true
    end
  end

end