class CoursesQuery
  SORTING = {
    name_asc: ->(scope) { scope.order(name: :asc) },
    name_desc: ->(scope) { scope.order(name: :desc) },
    description_asc: ->(scope) { scope.order(description: :asc) },
    description_desc: ->(scope) { scope.order(description: :desc) }
  }.freeze

  def initialize(relation:, params:, student:)
    @scope = relation
    @params = params
    @student = student
  end

  def call
    scoped = make_search
    scoped = filter_by_tag(scoped)
    SORTING[sort_by].call(scoped)
    exclude_enrolled_courses(scoped)
  end

  private

  attr_reader :params, :scope, :student

  def make_search
    return scope if params[:search].blank?

    scope.ransack(params[:search]).result(distinct: true)
  end

  def filter_by_tag(scoped)
    return scoped if params[:tag].blank?

    scoped.joins(:tags).where(tags: { name: params[:tag] })
  end

  def sort_by
    sorting_params_valid? ? params[:sort_by].to_sym : :name_asc
  end

  def sorting_params_valid?
    params[:sort_by] && SORTING.key?(params[:sort_by].to_sym)
  end

  def exclude_enrolled_courses(scoped)
    return scoped if student.nil?

    scoped.where.not(id: student.enrollments.select(:course_id))
  end
end
