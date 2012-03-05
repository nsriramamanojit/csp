module ApplicationHelper

  def get_csp_name(tr)
    accounts = Account.where(:csp_code => tr.csp_code).first
    content = ""
    return "N.A".html_safe if accounts.blank?
    content << accounts.name
    content.html_safe
  end

  def get_csp_account_number(tr)
    accounts = Account.where(:csp_code => tr.csp_code).first
    return "N.A".html_safe if accounts.blank?
    content = ""
    content << accounts.account_number
    content.html_safe
  end

  def get_csp_branch(tr)
    accounts = Account.where(:csp_code => tr.csp_code).first
    return "N.A".html_safe if accounts.blank?
    content =""
    content << accounts.bank_branch
    content.html_safe
  end
  def get_csp_branch_code(tr)
    accounts = Account.where(:csp_code => tr.csp_code).first
    return "N.A".html_safe if accounts.blank?
    content =""
    content << accounts.bank_code
    content.html_safe
  end


end
