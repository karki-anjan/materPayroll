class Payslip < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: :employee_id
  belongs_to :payroll
  
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  # attr_accessor :monthly_salary_sss, :monthly_salary_philhealth

  validates :employee, presence: true

  # validates_inclusion_of :paid, :in => [true, false]
  
  # has_many :reimbursements, inverse_of: :payslip

  before_save :set_base_salary, on: :create
  

  # def monthly_salary_sss
  #   salary = employee.base_salary / 2
  #   thousands = salary / 1000
  #   hundreds  = salary % 1000
  #   percent   = hundreds / 1000.0

  #   if   percent < 0.25
  #    thousands = thousands * 1000
  #   elsif percent < 0.75
  #    thousands = (thousands * 1000) + 500
  #   elsif thousands >= 15
  #    thousands = thousands = 16000
  #   else 
  #    thousands = (thousands + 1) * 1000
  #   end

  #   # return ((percent < 0.25) ? (thousands * 1000) : (percent < 0.75 ? (thousands * 1000) + 500 : (thousands >= 15 ? 16000 :(thousands + 1) * 1000)))*0.0363  
  #   return thousands * 0.0363

  # end

  # def monthly_salary_philhealth

  #     salary = employee.base_salary / 2
  #     salary = salary / 1000

  #     if salary < 9
  #       salary = 8000/40
  #     elsif salary >= 35
  #       salary = 35000/40
  #     else
  #       return (salary * 1000)/40
  #     end 

  #     return salary

  # end


  # def monthly_salary_pagibig
  #     salary = employee.base_salary / 2

  #     if salary <= 1500
  #       salary = salary*0.01
  #     else
  #       salary = salary*0.02
  #       if salary >= 100
  #         return salary = 100
  #       end
  #     end

  # end

  def monthly_withholding_tax

    salary = employee.base_salary / 2
    status = employee.status
    dependents = employee.no_of_dependents

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
            end
        end

      else
        return salary = 1000000
      end

  end

  #nope_adjustments collect
  def monthly_less_adjustments

    employee.nope_adjustments.collect do |nope_adjustment|
      nope_adjustment.amount
    end

  end


  def monthly_total_less_adjustments

    total_nope_adjustments = 0

     employee.nope_adjustments.each do |nope_adjustment|
     total_nope_adjustments = total_nope_adjustments + nope_adjustment.amount
     end

     return total_nope_adjustments

  end

  #reimbursements collect
  def monthly_reimbursements

    employee.reimbursements.collect do |reimbursement|
      reimbursement.amount
    end

  end

  def monthly_total_reimbursements

    total_reimbursements = 0

     employee.reimbursements.each do |reimbursement|
     total_reimbursements = total_reimbursements + reimbursement.amount
     end

     return total_reimbursements

  end

  #allowances collect
  def monthly_allowances

    employee.allowances.collect do |allowance|
      allowance.amount
    end

  end

  def monthly_total_allowances

    total_allowances = 0

     employee.allowances.each do |allowance|
     total_allowances = total_allowances + allowance.amount
     end

     return total_allowances

  end


  #dope_adjustments collect
  def monthly_plus_adjustments

    employee.dope_adjustments.collect do |dope_adjustment|
      dope_adjustment.amount
    end
    
  end


  def monthly_total_plus_adjustments

    total_dope_adjustments = 0

     employee.dope_adjustments.each do |dope_adjustment|
     total_dope_adjustments = total_dope_adjustments + dope_adjustment.amount
     end

     return total_dope_adjustments

  end

  #total_allowance_reimbursement_adjustments computation
  def monthly_total_ARA
    total_ARA = monthly_total_plus_adjustments + monthly_total_reimbursements + monthly_total_allowances
    return total_ARA
  end

  #total_deduction_computation
  def monthly_total_deductions
    total_deduction = monthly_withholding_tax+monthly_total_less_adjustments
    return total_deduction
  end

  #total monthly pay
  def monthly_final_pay
    final_pay = employee.base_salary + monthly_total_ARA - monthly_total_deductions
    return final_pay
  end

  


private

  
  def set_base_salary
    self.base_salary = employee.base_salary
  end  


end
