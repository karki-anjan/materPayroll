class PayslipsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @payslips = Payslip.all
  end
  
  def toggle_paid
    @payslips = Payslip.find(params[:id])

    @payslips.toggle(:paid)
    @payslips.save  
    flash[:success] = "Payslip updated!"
    if params[:payroll_id] 
      redirect_to payroll_path(params[:payroll_id])
    else
      redirect_to payrolls_path 
    end
  end

 def toggle_pay_all
    @payroll = Payroll.find(params[:id])

    @payroll.payslips.each do |payslip|
      payslip.update_attributes({paid: "true"})
    end
    flash[:success] = "All payslips are paid!"
    redirect_to payroll_path
  end

  def toggle_unpay_all
    @payroll = Payroll.find(params[:id])

    @payroll.payslips.each do |payslip|
      payslip.update_attributes({paid: "false"})
    end
    flash[:success] = "All payslips are not yet paid!"
    redirect_to payroll_path
  end

  def sss_bracket

  end

  def philhealth_bracket

  end

  def pagibig_bracket

  end

  def withholding_bracket
    
  end


  def show
    
    @reimbursements = Reimbursement.all
    @payslips = Payslip.find(params[:id])

    @status = @payslips.employee.no_of_dependents

    @dependents = @payslips.employee.status

    #cutoff
    @salary = @payslips.employee.base_salary/2

    #sss computation
    # @payslips.sss = sssBracket(@salary)*0.0363
    # @payslips.sss = @payslips.monthly_salary_sss*0.0363
    # @employer_sss = @payslips.monthly_salary_sss*0.0737

    #philhealth_computation
    # @monthly_salary_philhealth = philBracket(@salary)
    # @payslips.philhealth = @monthly_salary_philhealth/40
    # @employer_philhealth = @payslips.philhealth/2

    #pagibig_computation
    # @monthly_salary_pagibig = pagibigBracket(@salary)
    # @payslips.pagibig    = @monthly_salary_pagibig
    # @employer_philhealth = @monthly_salary_pagibig

    #withholding_tax computation
    @monthly_withholding_tax = withholding_tax(@salary, @status, @dependents)
    @withholding_tax = @monthly_withholding_tax

    #total reimbursements computation
    @total_reimbursements = 0

    @payslips.employee.reimbursements.each do |reimbursement|
      @total_reimbursements += reimbursement.amount
    end

    #total reimbursements computation
    @total_allowances = 0

    @payslips.employee.allowances.each do |allowance|
      @total_allowances += allowance.amount
    end
    
    #total less adjustments
    @total_nope_adjustments = 0

    @payslips.employee.nope_adjustments.each do |nope_adjustment|
      @total_nope_adjustments += nope_adjustment.amount
    end

    #total plus adjustments
    @total_dope_adjustments = 0

    @payslips.employee.dope_adjustments.each do |dope_adjustment|
      @total_dope_adjustments += dope_adjustment.amount
    end

    #final_pay computation
    @final_pay = (@payslips.employee.base_salary + @total_allowances + @total_reimbursements + @total_dope_adjustments) - (@withholding_tax + @total_dope_adjustments )
 
    
  end

  def new
    @payslip = Payslip.new
  end

  def create
  end

  def destroy
  end

  def edit
    @payslips = Payslip.find(params[:id])
  end

  def update
  end

  private 

  def payroll_params
    params.require(:payroll).permit(:start_period, :end_period)
  end
  
  def payslip_params
    params.require(:payslip).permit(:base_salary, :paid, :avatar)
  end
  

  def sssBracket(salary)
    thousands = salary / 1000
    hundreds  = salary % 1000
    percent   = hundreds / 1000.0

    if   percent < 0.25
     thousands = thousands * 1000
    elsif percent < 0.75
     thousands = (thousands * 1000) + 500
    elsif thousands >= 15
     thousands = thousands = 16000
    else 
     thousands = (thousands + 1) * 1000
    end

    return thousands
  end
  

  def philBracket (salary)
      salary = salary/1000
      if salary <= 7
        salary = 7000
      elsif salary >= 35
        salary = 35000
      else
        return salary * 1000
      end 
  end

  def pagibigBracket (salary)
      if salary <= 1500
        salary = salary*0.01
      else
        salary = salary*0.02
        if salary >= 100
          return salary = 100
        end
      end
  end

  def withholding_tax(salary, status, dependents)

      if status = "Single" || status = "Married"

        if dependents = 0
            if salary < 2083
              return salary = 2083
            elsif salary >= 2083 && salary < 2500
              salary = salary-2083
              salary = salary*0.05
            elsif salary >= 2500 && salary < 3333
              salary = salary-2500
              salary = salary*0.10+(20.83)
            elsif salary >= 3333 && salary < 5000
              salary = salary-3333
              salary = salary*0.15+(104.17)
            elsif salary >= 5000 && salary < 7917
              salary = salary-5000
              salary = salary*0.20+(354.17)

            elsif salary >= 7917 && salary < 12500
              salary = salary-2000
            elsif salary >= 12500 && salary < 22917
              salary = salary-12500
              salary = salary*0.30+(2083.33)
            elsif salary > 22917
              salary = salary-22917
              salary = salary*0.32+(5208.33)

        # elsif dependents = 1
        #     if salary < 3125
        #       return salary = 3125
        #     elsif salary >= 3125 && salary < 3542
        #       salary = salary-3125
        #       salary = salary*0.05
        #     elsif salary >= 3542 && salary < 4375
        #       salary = salary-3542
        #       salary = salary*0.10+(20.83)
        #     elsif salary >= 4375 && salary < 6042
        #       salary = salary-4375
        #       salary = salary*0.15+(104.17)
        #     elsif salary >= 6042 && salary < 8958
        #       salary = salary-6042
        #       salary = salary*0.20+(354.17)
        #     elsif salary >= 8958 && salary < 13542
        #       salary = salary-8958
        #       salary = salary*0.25+(937.50)
        #     elsif salary >= 13542 && salary < 23958
        #       salary = salary-13542
        #       salary = salary*0.30+(2083.33)
        #     elsif salary > 23958
        #       salary = salary-23958
        #       salary = salary*0.32+(5208.33)
        #     end

        # elsif dependents = 2
        #     if salary < 4167
        #       return salary = 4167
        #     elsif salary >= 4167 && salary < 4583
        #       salary = salary-4167
        #       salary = salary*0.05
        #     elsif salary >= 4583 && salary < 5417
        #       salary = salary-4583
        #       salary = salary*0.10+(20.83)
        #     elsif salary >= 5417 && salary < 7083
        #       salary = salary-5417
        #       salary = salary*0.15+(104.17)
        #     elsif salary >= 7083 && salary < 10000
        #       salary = salary-7083
        #       salary = salary*0.20+(354.17)
        #     elsif salary >= 10000 && salary < 14583
        #       salary = salary-10000
        #       salary = salary*0.25+(937.50)
        #     elsif salary >= 14583 && salary < 25000
        #       salary = salary-14583
        #       salary = salary*0.30+(2083.33)
        #     elsif salary > 25000
        #       salary = salary-25000
        #       salary = salary*0.32+(5208.33)
        #     end

        # elsif dependents = 3
        #     if salary < 5208
        #       return salary = 5208
        #     elsif salary >= 5208 && salary < 5625
        #       salary = salary-5208
        #       salary = salary*0.05
        #     elsif salary >= 5625 && salary < 6458
        #       salary = salary-5625
        #       salary = salary*0.10+(20.83)
        #     elsif salary >= 6458 && salary < 8125
        #       salary = salary-6458
        #       salary = salary*0.15+(104.17)
        #     elsif salary >= 8125 && salary < 11042
        #       salary = salary-8125
        #       salary = salary*0.20+(354.17)
        #     elsif salary >= 11042 && salary < 15625
        #       salary = salary-11042
        #       salary = salary*0.25+(937.50)
        #     elsif salary >= 15625 && salary < 26042
        #       salary = salary-15625
        #       salary = salary*0.30+(2083.33)
        #     elsif salary > 26042
        #       salary = salary-26042
        #       salary = salary*0.32+(5208.33)
        #     end

        # elsif dependents >= 4
        #     if salary < 6250
        #       return salary = 6250
        #     elsif salary >= 6250 && salary < 6667
        #       salary = salary-6250
        #       salary = salary*0.05
        #     elsif salary >= 6667 && salary < 7500
        #       salary = salary-6667
        #       salary = salary*0.10+(20.83)
        #     elsif salary >= 7500 && salary < 9167
        #       salary = salary-7500
        #       salary = salary*0.15+(104.17)
        #     elsif salary >= 9167 && salary < 12083
        #       salary = salary-9167
        #       salary = salary*0.20+(354.17)
        #     elsif salary >= 12083 && salary < 16667
        #       salary = salary-12083
        #       salary = salary*0.25+(937.50)
        #     elsif salary >= 16667 && salary < 27083
        #       salary = salary-16667
        #       salary = salary*0.30+(2083.33)
        #     elsif salary > 27083
        #       salary = salary-27083
        #       salary = salary*0.32+(5208.33)
        #     end
        # end

              else
                return salary = 1000000
              end
            end
          end
        end
  end
