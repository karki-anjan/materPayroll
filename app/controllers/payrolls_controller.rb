# require "action_view/helpers/date_helper"

class PayrollsController < ApplicationController

  def index
    @employees = User.all
    @payrolls  = Payroll.paginate(page: params[:page])
  end

  def new
    @payroll = Payroll.new  
  end

  def create
    @payroll = Payroll.new payroll_params

    if @payroll.save
      redirect_to @payroll, notice: "Payroll created."
    else
      render action: :new
    end
  end

  def show
    @payroll = Payroll.find(params[:id])

      # @users = User.all
        if params[:search]
          @payslips = @payroll.payslips.joins(:employee).where("'users'.'name' LIKE ?", "%#{params['search']}%")
        else
          @payslips = @payroll.payslips
        end

  end

    
  # def toggle_pay_all
  #   # @payslips = @payroll.payslips.includes(:employee)
  #   # @payslips.paid = "true"
  #   # @payslips.save  
  #   # flash[:success] = "Payslip updated!"
  #   # if params[:payroll_id] 
  #   #   redirect_to payroll_path(params[:payroll_id])
  #   # else
  #   redirect_to payrolls_path 
  #   # end
  # end
 
  def destroy
    @payroll = Payroll.find(params[:id])
    @payroll.payslips.destroy_all
    @payroll.destroy
    flash[:success] = "Payroll deleted"
    redirect_to payrolls_path
  end


  private 

  def payroll_params
    params.require(:payroll).permit(:start_period, :end_period)
  end
end
