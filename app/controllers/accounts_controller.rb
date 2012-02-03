require 'csv'
class AccountsController < ApplicationController
  def index
    @accounts = Account.search(params[:search]).paginate(:page =>params[:page], :per_page=>20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
  def upload

  end

  def csv_import
    csv_file = params[:file]
    n=0
    CSV.new(csv_file.tempfile,:col_sep => ",").each do |row|
      account = Account.create do |acc|
        acc.name  =row[0]
        acc.csp_code = row[1]
        acc.mobile = row[2]
        acc.district = row[3]
        acc.bank_branch = row[4]
        acc.bank_code = row[5]
        acc.account_number = row[6]
        acc.bank_name= "SBI"
      end
      account.save
      n = n + 1
    end
    flash[:notice]= "#{n} Accounts are imported successfully"
    respond_to do |format|
      format.html { redirect_to(accounts_path) }
      format.xml  { head :ok }
    end
  end
end
