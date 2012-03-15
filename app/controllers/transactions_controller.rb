# Author: Chaitanya Ram N
# Date: 03022012
#########################################################
class TransactionsController < ApplicationController
  before_filter :recent_items
  layout "admin", :except => [:export]

  def index
    @transactions = Transaction.search(params[:search]).paginate(:page => params[:page], :per_page => 50).order("transaction_date DESC")

    render :layout => "application"

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
    require 'csv'
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

    if params[:theme] == "pdf"    ## for PDF
      #render :layout => nil
      html = render_to_string :layout => false
      kit = PDFKit.new(html)
      send_data(kit.to_pdf, :filename => "Account_Statement_" + params[:date_selected] +".pdf", :type => 'application/pdf')
    elsif params[:theme]=="text"    ## for Text
      require 'csv'
      total = 0
      outfile = "Transaction_Report_" + Time.now.strftime("%d-%m-%Y") + ".txt"
      csv_data = CSV.generate do |csv|
        @transactions.each do |tr|
          account = Account.where(:csp_code => tr.csp_code).first
          if account.blank?
          else
            if account.account_number == 'N.A' || account.account_number == '00000000000'
            else
              amount = (-1) * tr.amount
              amount= amount % 100 == 0 ? amount : amount - (amount % 100)
              total += amount
            end
          end
        end
        csv<<[31633006672, '03607', Time.now.strftime("%d/%m/%Y"), "%.2f"%total, nil, '3A43', 'CSP Transfer']
        @transactions.each do |tr|
          account = Account.where(:csp_code => tr.csp_code).first
          if account.blank?
          else
            if account.account_number == 'N.A' || account.account_number == '00000000000'
            else
              amount = (-1) * tr.amount
              amount= amount % 100 == 0 ? amount : amount - (amount % 100)
              total += amount
              csv << [account.account_number, account.bank_code, Time.now.strftime("%d/%m/%Y"), nil, "%.2f"%amount, account.csp_code, 'CSP Transfer']
            end
          end
        end

      end
      send_data csv_data,
                :type => 'text/plain; charset=UTF-8',
                :disposition => "attachment; filename=#{outfile}"
    else     ##for EXCEL
=begin
      outfile = "Transaction_Report_" + Time.now.strftime("%d-%m-%Y") + ".xls"
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = "attachment; filename=#{outfile}"
      headers['Cache-Control'] = ''

      render :report_excel
=end
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet
      sheet1.row(0).concat  ["SR", "KO ID", "AMOUNT", "D/W"]
      i=1
     @transactions.each do |tr|
       account = Account.where(:csp_code => tr.csp_code).first
       if account.blank?
       else
         if account.account_number == 'N.A' || account.account_number == '00000000000'
         else
           amount = (-1) * tr.amount
           amount= amount % 100 == 0 ? amount : amount - (amount % 100)

           sheet1[i,0] = i
          sheet1[i,1] = tr.csp_code
          sheet1[i,2] = amount
          sheet1[i,3] = 'W'
        i+=1
         end
       end
       end
      @outfile = "Transaction_Report_Excel_" + Time.now.strftime("%d-%m-%Y") + ".xls"

      require 'stringio'
      data = StringIO.new ''
      book.write data
      send_data data.string, :type=>"application/excel", :disposition=>'attachment', :filename => @outfile
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
  def report_excel
    @transactions = Transaction.where("amount <=? AND transaction_date =?", -1000, params[:date_selected].to_date)

  end

  ############################
  private
  def recent_items
    @recent_transactions = Transaction.order('id DESC').limit(5)
  end
end
