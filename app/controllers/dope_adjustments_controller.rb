class DopeAdjustmentsController < ApplicationController

	def index
		  # render html: "hello, world!"
	   @user = User.find(params[:user_id])
	 	if logged_in? && current_user.admin?
	  		@dope_adjustments = DopeAdjustment.paginate(page: params[:page])
		else
			@dope_adjustments = @user.dope_adjustments.all.paginate(page: params[:page])
		end
	end

	def show
		# render html: "hello, world!"
	   @user = User.find(params[:user_id])
	   @dope_adjustments = DopeAdjustment.find(params[:id])
	end


   def edit
   	@user = User.find(params[:user_id])
    @dope_adjustment = DopeAdjustment.find(params[:id])
   end

   def update
   	@user = User.find(params[:user_id])
    @dope_adjustment = DopeAdjustment.find(params[:id])
    if @dope_adjustment.update_attributes(dope_adjustments_params)
      flash[:success] = "Adjustment updated"
      redirect_to user_dope_adjustments_path
    else
      render 'edit'
    end
   end

   def destroy
   	@user = User.find(params[:user_id])
    @dope_adjustment = @user.dope_adjustments.find(params[:id])
    @dope_adjustment.destroy
    flash[:success] = "Adjustment deleted"
    redirect_to user_dope_adjustments_path
   end

   def create
    
  	@user = User.find(params[:user_id])
    @dope_adjustments = @user.dope_adjustments.new(dope_adjustments_params)
    
    if @dope_adjustments.save!
      flash[:success] = "Adjustment successfully created."
      redirect_to user_dope_adjustments_path
      # Handle a successful save.
    else
      render 'new'
    end
   end

   def new
   	@user = User.find(params[:user_id])
   	# @dope_adjustments = @user.dope_adjustments 
   end
   
   def correct_user
      @dope_adjustments = current_user.dope_adjustments.find_by(id: params[:id])
      redirect_to user_path if @dope_adjustments.nil?
   end

   private
    def dope_adjustments_params
      params.require(:dope_adjustment).permit(:description, :amount)
    end

end
