# Author: Chaitanya Ram N
# Date: 03022012
#########################################################
class TransactionsController < ApplicationController
  before_filter :recent_items
  layout "admin", :except => [:export]

  def index
    @transactions = Transaction.search(params[:search]).paginate(:page => params[:page], :per_page => 20).order("transaction_date DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @transactions }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @transaction }
    end
  end

  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @transaction }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully created.') }
        format.xml { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml { head :ok }
    end
  end

  def upload

  end

  def csv_import
    csv_file = params[:file]
    n=0
    CSV.new(csv_file.tempfile, :col_sep => ",").each do |row|
      transaction = Transaction.create do |tr|
        tr.csp_code =row[0]
        tr.amount = row[1]
        tr.transaction_date = params[:start_date]
      end
      transaction.save
      n = n + 1
    end
    flash[:success]= "#{n} Transactions are imported successfully"
    respond_to do |format|
      format.html { redirect_to(transactions_path) }
      format.xml { head :ok }
    end
  end

  def export
    @transactions = Transaction.where("amount <=? AND transaction_date =?", -1000, params[:date_selected].to_date)

    if params[:theme] == "pdf"
      #render :layout => nil
      html = render_to_string :layout => false
      kit = PDFKit.new(html)
      send_data(kit.to_pdf, :filename => "Account_Statement_" + params[:date_selected] +".pdf", :type => 'application/pdf')
    else
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="report.xls"'
      headers['Cache-Control'] = ''
    end
  end

  def export_form
  end

  def delete_form

  end

  def remove
    @transactions = Transaction.where(:transaction_date => params[:remove_date_selected].to_date)
    flash[:error]= "#{@transactions.size} Transactions are Removed successfully"
    @transactions.delete_all
    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml { head :ok }
    end

  end

  def export_excel
    @transactions = Transaction.all

  end

  ############################
  private
  def recent_items
    @recent_transactions = Transaction.order('id DESC').limit(5)
  end
end
