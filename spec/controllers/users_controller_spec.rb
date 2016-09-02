require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new user instance variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, params: {user: {first_name: "nancy",
                                      last_name: "lu",
                                      email: "me@email.com",
                                      password: "nancy",
                                      password_confirmation: "nancy"}}
      end
        it "saves a record to the database" do
          count_before = User.count
          valid_request
          count_after = User.all.reload.count
          # expect{valid_request}.to change{User.count}.by 1
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the user show page" do
          valid_request
          expect(response).to redirect_to(root_path)
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end

        it "signs in user and assigns session[:user_id]" do
          valid_request
          expect(session[:user_id]).to eq(User.last.id)
        end
        
    end

      context "with invalid parameters" do
        def invalid_request
          post :create, params: {user:{first_name: ""}}
        end



        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "doesn't save the record to the database" do
          count_before = User.count
          invalid_request
          count_after = User.count
          expect(count_after).to eq(count_before)
        end
      end
  end

end
