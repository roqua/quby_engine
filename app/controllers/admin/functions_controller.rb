class Admin::FunctionsController < AdminAreaController
  def index
    @functions = Function.all
  end

  def new
    @function = Function.new
  end

  def show
    @function = Function.find(params[:id])
  end

  def edit
    @function = Function.find(params[:id])
  end

  def create
    @function = Function.new(params[:function])
    if @function.save
      flash[:success] = "Function created successfully."
      redirect_to :action => :show, :id => @function.id
    else
      render :action => :new
    end
  end

  def update
    @function = Function.find(params[:id])
    @function.attributes = params[:function]

    if @function.save
      flash[:success] = "Function saved successfully."
      redirect_to edit_admin_function_path(@function)
    else
      render :action => :edit
    end
  end

  def delete
    @function.delete(params[:id])
  end
end
