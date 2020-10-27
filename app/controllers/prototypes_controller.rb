class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new

  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render new_prototype_path
    end
  end

  def edit
    if current_user.id != @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render edit_prototype(@prototype)
    end
  end

  def destroy
    @prototype.destroy
    redirect_to action: :index
  end



  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
