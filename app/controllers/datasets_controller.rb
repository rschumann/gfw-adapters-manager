class DatasetsController < ApplicationController
  before_action :set_selection, only: [:new, :create]

  def index
    @datasets = Datasets.list
  end

  def show
    @dataset = Dataset.details(params[:id])
  end

  def new
  end

  def create
    @dataset = Dataset.create(dataset_params)
    redirect_to datasets_path
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
    @dataset = Dataset.delete(params[:id])
    redirect_to datasets_path
  end

  private

    def set_selection
      @status = [['Pending', 0], ['Active', 1], ['Disabled', 2]]
    end

    def dataset_params
      params.require(:connector).permit!
    end
end
