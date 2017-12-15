# NotInEngine provides an object within the dummy app, that should not be
# affected by any code in the engine itself.
class NotInEnginesController < ApplicationController
  before_action :set_not_in_engine, only: %i[show edit update destroy]

  # GET /not_in_engines
  def index
    @not_in_engines = NotInEngine.all
  end

  # GET /not_in_engines/1
  def show; end

  # GET /not_in_engines/new
  def new
    @not_in_engine = NotInEngine.new
  end

  # GET /not_in_engines/1/edit
  def edit; end

  # POST /not_in_engines
  def create
    @not_in_engine = NotInEngine.new(not_in_engine_params)

    if @not_in_engine.save
      redirect_to @not_in_engine, notice: "Not in engine was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /not_in_engines/1
  def update
    if @not_in_engine.update(not_in_engine_params)
      redirect_to @not_in_engine, notice: "Not in engine was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /not_in_engines/1
  def destroy
    @not_in_engine.destroy
    redirect_to not_in_engines_url, notice: "Not in engine was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_not_in_engine
    @not_in_engine = NotInEngine.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def not_in_engine_params
    params.require(:not_in_engine).permit(:name)
  end
end
