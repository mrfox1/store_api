class Api::V1::CategoriesController < Api::BaseController
  before_action :set_category, only: :show
  skip_before_action :authenticate, only: %i[index show]

  def index
    @categories = Category.all.order(:name)
  end

  def show
    render_errors I18n.t('errors.category_not_found'), 404 if @category.blank?
  end

  private

  def set_category
    @category = Category.find_by(id: permited_parameter[:id])
  end
end
