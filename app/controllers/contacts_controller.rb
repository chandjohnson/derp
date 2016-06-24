class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /contacts
  # GET /contacts.json
  def index
    if !Account.find_by(user: current_user.id, level: "Boss")
      if !Account.find_by(user: current_user.id, level: "Employee")
        redirect_to new_account_url
      end
    end
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    if !Account.find_by(user: current_user.id, level: "Boss")
      if !Account.find_by(user: current_user.id, level: "Employee")
        sign_out_and_redirect(current_user)
      end
    end
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    if !Account.find_by(user: current_user.id, level: "Boss")
      if !Account.find_by(user: current_user.id, level: "Employee")
        redirect_to new_account_url
      end
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if !Account.find_by(user: current_user.id, level: "Boss")
      if !Account.find_by(user: current_user.id, level: "Employee")
        redirect_to new_account_url
      end
    end
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    if !Account.find_by(user: current_user.id, level: "Boss")
      if !Account.find_by(user: current_user.id, level: "Employee")
        redirect_to new_account_url
      end
    end
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:number, :name, :comments)
    end
end
