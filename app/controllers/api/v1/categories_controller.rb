class Api::V1::CategoriesController < Api::BaseController
  before_action :set_category, only: :show
  skip_before_action :authenticate, only: %i[index show]

  def index
    @categories = Category.all.order(:name)
  end

  def show
    return render_errors I18n.t('errors.category_not_found'), 404 if @category.blank?
  end

  private

  def set_category
    @category = Category.find permited_parameter[:id]
  end
end
