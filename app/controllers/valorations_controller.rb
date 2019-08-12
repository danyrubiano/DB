class ValorationsController < ApplicationController
  before_action :set_valoration, only: [:show, :edit, :update, :destroy]
  before_action :set_post
  before_action :authenticate_user!
  before_action :user_activo!
  
  # POST /valorations
  # POST /valorations.json
  def create
    @valoration = current_user.valorations.new(valoration_params)
    @valoration.post = @post

    respond_to do |format|
      if @valoration.save
        format.html { redirect_to @valoration.post, notice: 'Valoration was successfully created.' }
        format.json { render :show, status: :created, location: @valoration }
        @valoration.post.add_calificacion(@valoration.calificacion)
        @valoration.post.update_num_calificaciones

      else
        format.html { render :new }
        format.json { render json: @valoration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valorations/1
  # PATCH/PUT /valorations/1.json
  def update
    respond_to do |format|
      if @valoration.update(valoration_params)
        format.html { redirect_to @valoration.post, notice: 'Valoration was successfully updated.' }
        format.json { render :show, status: :ok, location: @valoration }
      else
        format.html { render :edit }
        format.json { render json: @valoration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valorations/1
  # DELETE /valorations/1.json
  def destroy
    @valoration.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Valoration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_valoration
      @valoration = Valoration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valoration_params
      params.require(:valoration).permit(:user_id, :post_id, :calificacion)
    end
end
