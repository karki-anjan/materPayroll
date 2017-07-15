class AllowancesController < ApplicationController

	
	def index
		  # render html: "hello, world!"
		  
	  @user = User.find(params[:user_id])
	 	if logged_in? && current_user.admin?
	  		@allowances = Allowance.paginate(page: params[:page])
		else
			@allowances = @user.allowances.all.paginate(page: params[:page])
		end
	end

	def show
		# render html: "hello, world!"
	   @user = User.find(params[:user_id])
	   @allowances = Allowance.find(params[:id])
	end


   def edit
   	@user = User.find(params[:user_id])
    @allowance = Allowance.find(params[:id])
   end

   def update
   	@user = User.find(params[:user_id])
   	@allowance = Allowance.find(params[:id])
    if @allowance.update_attributes(allowances_params)
      flash[:success] = "Allowance updated"
      redirect_to user_allowances_path
    else
      render 'edit'
    end
   end

   def destroy
   	@user = User.find(params[:user_id])
   	@allowance = @user.allowances.find(params[:id])
   	@allowance.destroy
    flash[:success] = "Allowance deleted"
    redirect_to user_allowances_path
   end

   def create
  	@user = User.find(params[:user_id])
  	@allowances = @user.allowances.new(allowances_params)
    if @allowances.save
      flash[:success] = "Allowance successfully created."
      redirect_to user_allowances_path
      # Handle a successful save.
    else
      render 'new'
    end
   end

   def new
   	@user = User.find(params[:user_id])
   	# @allowances = @user.allowances 
   end
   
   def correct_user
      @allowances = current_user.allowances.find_by(id: params[:id])
      redirect_to user_path if @allowances.nil?
   end

   private
    def allowances_params
      params.require(:allowance).permit(:description, :amount)
    end

end
