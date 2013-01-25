class HoppersController < ApplicationController
  def index
    @hoppers = Hopper.find_actives
  end

  def new
    @lots = Lot.where :active => true, :in_use => true
  end

  def edit
    @lots = Lot.where :active => true, :in_use => true
    @hopper = Hopper.find params[:id]
    @current_lot = @hopper.find_active.lot rescue nil
  end

  def create
    @hopper = Hopper.new :number => params[:hopper][:number]
    if @hopper.save
      if @hopper.update_lot(params[:hopper][:hopper_lot])
        flash[:notice] = 'Tolva guardada con éxito'
      else
        flash[:notice] = 'La tolva fue guardada con éxito pero no se guardó el ingrediente asociado'
      end
      redirect_to :hoppers
    else
      new
      render :new
    end
  end

  def update
    @hopper = Hopper.find params[:id]
    if @hopper.update_lot(params[:hopper][:hopper_lot]) and @hopper.update_name(params[:hopper][:name])
      flash[:notice] = 'Tolva actualizada con éxito'
      redirect_to :hoppers
    else
      edit
      render :edit
    end
  end

  def destroy
    @hopper = Hopper.find params[:id]
    @hopper.eliminate
    if @hopper.errors.size.zero?
      flash[:notice] = "Tolva eliminada con éxito"
    else
      logger.error("Error eliminando tolva: #{@hopper.errors.inspect}")
      flash[:type] = 'error'
      if not @hopper.errors[:foreign_key].nil?
        flash[:notice] = 'La tolva no se puede eliminar porque tiene registros asociados'
      elsif not @hopper.errors[:unknown].nil?
        flash[:notice] = @hopper.errors[:unknown]
      else
        flash[:notice] = "La tolva no se ha podido eliminar"
      end
    end
    redirect_to :hoppers
  end

  private

  def fill
    @lots
  end
end
