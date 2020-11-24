class UtrReportsController < ApplicationController
  before_action :set_utr_report, only: [:show, :edit, :update, :destroy]

  # GET /utr_reports
  # GET /utr_reports.json
  def index
    @utr_reports = UtrReport.all
  end

  # GET /utr_reports/1
  # GET /utr_reports/1.json
  def show
  end

  # GET /utr_reports/new
  def new
    @utr_report = UtrReport.new
  end

  # GET /utr_reports/1/edit
  def edit
  end

  # POST /utr_reports
  # POST /utr_reports.json
  def create
    @utr_report = UtrReport.new(utr_report_params)

    respond_to do |format|
      if @utr_report.save
        format.html { redirect_to @utr_report, notice: 'Utr report was successfully created.' }
        format.json { render :show, status: :created, location: @utr_report }
      else
        format.html { render :new }
        format.json { render json: @utr_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utr_reports/1
  # PATCH/PUT /utr_reports/1.json
  def update
    respond_to do |format|
      if @utr_report.update(utr_report_params)
        format.html { redirect_to @utr_report, notice: 'Utr report was successfully updated.' }
        format.json { render :show, status: :ok, location: @utr_report }
      else
        format.html { render :edit }
        format.json { render json: @utr_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utr_reports/1
  # DELETE /utr_reports/1.json
  def destroy
    @utr_report.destroy
    respond_to do |format|
      format.html { redirect_to utr_reports_url, notice: 'Utr report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utr_report
      @utr_report = UtrReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def utr_report_params
      params.require(:utr_report).permit(:utr_date, :boys, :girls)
    end
end
