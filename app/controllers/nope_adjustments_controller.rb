class NopeAdjustmentsController < ApplicationController

	def index
		  # render html: "hello, world!"
	   @user = User.find(params[:user_id])
	 	if logged_in? && current_user.admin?
	  		@nope_adjustments = NopeAdjustment.paginate(page: params[:page])
		else
			@nope_adjustments = @user.nope_adjustments.all.paginate(page: params[:page])
		end
	end

	def show
		# render html: "hello, world!"
	   @user = User.find(params[:user_id])
	   @nope_adjustments = NopeAdjustment.find(params[:id])
	end


   def edit
   	@user = User.find(params[:user_id])
    @nope_adjustment = NopeAdjustment.find(params[:id])
   end

   def update
   	@user = User.find(params[:user_id])
    @nope_adjustment = NopeAdjustment.find(params[:id])
    if @nope_adjustment.update_attributes(nope_adjustments_params)
      flash[:success] = "Adjustment updated"
      redirect_to user_nope_adjustments_path
    else
      render 'edit'
    end
   end

   def destroy
   	@user = User.find(params[:user_id])
    @nope_adjustment = @user.nope_adjustments.find(params[:id])
    @nope_adjustment.destroy
    flash[:success] = "Adjustment deleted"
    redirect_to user_nope_adjustments_path
   end

   def create
  	@user = User.find(params[:user_id])
  	@nope_adjustments = @user.nope_adjustments.new(nope_adjustments_params)
    if @nope_adjustments.save
      flash[:success] = "-Adjustment successfully created."
      redirect_to user_nope_adjustments_path
      # Handle a successful save.
    else
      render 'new'
    end
   end

   def new
   	@user = User.find(params[:user_id])
   	# @nope_adjustments = @user.nope_adjustments 
   end
   
   def correct_user
      @nope_adjustments = current_user.nope_adjustments.find_by(id: params[:id])
      redirect_to user_path if @nope_adjustments.nil?
   end

   private
    def nope_adjustments_params
      params.require(:nope_adjustment).permit(:description, :amount)
    end

end
