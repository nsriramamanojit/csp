module ApplicationHelper

  def get_csp_name(tr)
    accounts = Account.where(:csp_code => tr.csp_code)
    content = ""
    return "----".html_safe if accounts.blank?

      for ac_name in accounts
      content << ac_name.name
      end
    content.html_safe
  end

  def get_csp_account_number(tr)
    accounts = Account.where(:csp_code => tr.csp_code)
    return "----".html_safe if accounts.blank?

    for account_number in accounts
        return account_number.account_number
    end
  end
  def get_csp_branch(tr)
    accounts = Account.where(:csp_code => tr.csp_code)
    return "----".html_safe if accounts.blank?
    #content =""
    for branch in accounts
     # content << branch.bank_branch
        return branch.bank_branch
    end
   # content.html_safe
  end

end
