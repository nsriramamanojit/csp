class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = Transaction.paginate(:page =>params[:page], :per_page=>20).order("csp_code ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.xml
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
  def upload

  end
  def csv_import
    csv_file = params[:file]
    n=0
    CSV.new(csv_file.tempfile,:col_sep => ",").each do |row|
      transaction = Transaction.create do |tr|
        tr.csp_code  =row[0]
        tr.amount = row[1]
        tr.transaction_date = params[:start_date]
      end
      transaction.save
      n = n + 1
    end
    flash[:notice]= "#{n} Transactions are imported successfully"
    respond_to do |format|
      format.html { redirect_to(transactions_path) }
      format.xml  { head :ok }
    end

  end
  def export
    @transactions = Transaction.where("amount <? AND transaction_date =?", -1000,params[:date_selected].to_date).order("csp_code ASC")

    #render :layout => nil
    html = render_to_string :layout => false
    kit = PDFKit.new(html, :orientation => 'Landscape', :page_size => 'A4')
    send_data(kit.to_pdf, :filename => "Account_Statement.pdf", :type => 'application/pdf')

  end
  def export_form

  end
end
