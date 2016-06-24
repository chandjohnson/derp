class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /accounts
  # GET /accounts.json
  def index
    if !Account.find_by(user: current_user.id, level: "Boss")
      redirect_to contacts_url
    end
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @Account
    if !Account.exists?
      @account = Account.new(user: current_user.id, level: "Boss")
      @account.save
    elsif !Account.find_by(user: current_user.id)
      @account = Account.new(user: current_user.id, level: "Applicant")
      @account.save
    end
    sign_out_and_redirect(current_user)
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    if !Account.find_by(user: current_user.id, level: "Boss")
      redirect_to contacts_url
    end
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    if !Account.find_by(user: current_user.id, level: "Boss")
      redirect_to contacts_url
    elsif @account.level == "Applicant"
      @account.level = "Employee"
      @account.save
    end
    redirect_to accounts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user, :level)
    end
end
