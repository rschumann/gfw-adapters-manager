class DatasetsController < AuthController
  before_action :set_dataset,   except: [:index, :new, :create]
  before_action :set_selection, only: [:new, :create, :edit, :update]

  def index
    @datasets = Datasets.list
    authorize! :read, @datasets
  end

  def show
    authorize! :read, @dataset
  end

  def edit
    authorize! :read, @dataset
  end

  def update
    Dataset.update(dataset_params)
    redirect_to dataset_path(params[:id])
    authorize! :read, @dataset
  end

  def new
    authorize! :read, Dataset
  end

  def create
    Dataset.create(dataset_params)
    redirect_to datasets_path
    authorize! :read, Dataset
  end

  def refresh
    if params[:id].present?
      Dataset.refresh("dataset_#{params[:id]}")
      redirect_to dataset_path(params[:id])
    else
      Datasets.refresh('datasets')
      redirect_to datasets_path
    end
  end

  def destroy
    Dataset.delete(params[:id])
    redirect_to datasets_path
    authorize! :read, @dataset
  end

  private

    def set_dataset
      @dataset = Dataset.find(params[:id])
    end

    def set_selection
      @status = [['Pending', 0], ['Active', 1], ['Disabled', 2]]
    end

    def dataset_params
      params.require(:connector).permit!
    end
end
