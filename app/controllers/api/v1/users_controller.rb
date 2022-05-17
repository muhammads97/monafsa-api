module Api
  module V1
    class UsersController < ApiController
      before_action :authenticate_user!, except: %i[create index show]
      before_action :find_user, except: %i[create index]
    
      # GET /users
      def index
        @users = User.all
      end
    
      # GET /users/{username}
      def show; end
    
      # POST /users
      def create
        @user = User.create!(user_params)
        @token = JsonWebToken.encode(user_id: @user.id)
        @time = Time.now + 24.hours.to_i
      end
    
      # PUT /users/{username}
      def update
        authorize @user
        @user.update!(user_params)
      end
    
      # DELETE /users/{username}
      def destroy
        authorize @user
        @user.destroy
      end
    
      private
    
      def find_user
        @user = User.find(params[:id])
      end
    
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
