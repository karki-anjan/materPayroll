class ReimbursementsController < ApplicationController
    # before_action :correct_user,   only: :destroy


	def index
		  
    @user = User.find(params[:user_id])
	 	if logged_in? && current_user.admin?
	  		@reimbursements = Reimbursement.paginate(page: params[:page])
		else
			@reimbursements = @user.reimbursements.all.paginate(page: params[:page])
		end
	end

	def show
		# render html: "hello, world!"
	   @user = User.find(params[:user_id])
	   @reimbursements = Reimbursement.find(params[:id])
	end


   def edit
   	@user = User.find(params[:user_id])
    @reimbursement = Reimbursement.find(params[:id])
   end

   def update
   	@user = User.find(params[:user_id])
   	@reimbursement = Reimbursement.find(params[:id])
    if @reimbursement.update_attributes(reimbursements_params)
      flash[:success] = "Reimbursement updated"
      redirect_to user_reimbursements_path
    else
      render 'edit'
    end
   end

   def destroy
   	# @user = User.find(params[:user_id])
   	# @reimbursement = @user.reimbursements.find(params[:id])
    @reimbursement = Reimbursement.find(params[:id])
   	@reimbursement.destroy
    flash[:success] = "Reimbursement deleted"
    redirect_to user_reimbursements_path
   end

   def create
  	@user = User.find(params[:user_id])
  	@reimbursement = @user.reimbursements.new(reimbursements_params)
    if @reimbursement.save!
      flash[:success] = "Reimbursement successfully created."
      redirect_to user_reimbursements_path
      # Handle a successful save.
    else
      flash.now[:alert] = @reimbursement.errors.full_messages.join("<br>").html_safe
      render 'new'
    end
   end

   def new
    @user = User.find(params[:user_id])
   	@reimbursements = @user.reimbursements 
   end
   
   def correct_user
      @reimbursements = current_user.reimbursements.find_by(id: params[:id])
      redirect_to user_path if @reimbursements.nil?
   end

   private
    def reimbursements_params
      params.require(:reimbursement).permit(:category, :description, :amount, :avatar, :user_id)
    end

end
