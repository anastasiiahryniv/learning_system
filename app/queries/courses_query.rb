class CoursesQuery
  SORTING = {
    name_asc: -> (scope) { scope.order(name: :asc) },
    name_desc: -> (scope) { scope.order(name: :desc) },
    description_asc: -> (scope) { scope.order(description: :asc) },
    description_desc: -> (scope) { scope.order(description: :desc) }
  }.freeze

  def initialize(relation:, params:)
    @scope = relation
    @params = params
  end

  def call
    scoped = make_search
    scoped = filter_by_tag(scoped)
    SORTING[sort_by].call(scoped)
  end

  private

  attr_reader :params, :scope

  def make_search
    return scope if params[:search].blank?

    scope.ransack(params[:search]).result(distinct: true)
  end

  def filter_by_tag(scoped)
    return scoped unless params[:tag].present?

    scoped.joins(:tags).where(tags: { name: params[:tag] })
  end

  def sort_by
    sorting_params_valid? ? params[:sort_by].to_sym : :name_asc
  end

  def sorting_params_valid?
    params[:sort_by] && SORTING.key?(params[:sort_by].to_sym)
  end
end
