require 'rails_helper'

RSpec.describe CoursesQuery do
  let(:student) { create(:student) }
  let(:instructor) { create(:instructor) }
  let(:course1) { create(:course, name: 'B Course', tags: [tag]) }
  let(:course2) { create(:course, name: 'A Course') }
  let(:enrollment) { create(:enrollment, student:, course: course1) }
  let(:tag) { create :tag, name: 'Ruby' }

  describe 'sorting' do
    it 'returns courses sorted by name ascending' do
      query = CoursesQuery.new(relation: Course.all, params: { sort_by: 'name_asc' }, student: nil)
      result = query.call
      expect(result).to eq([course2, course1])
    end

    it 'returns courses sorted by name descending' do
      query = CoursesQuery.new(relation: Course.all, params: { sort_by: 'name_desc' }, student: nil)
      result = query.call
      expect(result).to eq([course1, course2])
    end

    it 'filters courses by tag' do
      query = CoursesQuery.new(relation: Course.all, params: { tag: 'Ruby' }, student: nil)
      result = query.call
      expect(result).to eq([course1])
    end

    it 'excludes courses the student is enrolled in' do
      query = CoursesQuery.new(relation: Course.all, params: {}, student:)
      result = query.call
      expect(result).to eq([course2])
    end

    it 'returns all courses if no search parameters are provided' do
      query = CoursesQuery.new(relation: Course.all, params: {}, student: nil)
      result = query.call
      expect(result).to eq([course1, course2])
    end

    it 'returns courses matching the search query' do
      query = CoursesQuery.new(relation: Course.all, params: { search: { name_cont: 'A' } }, student: nil)
      result = query.call
      expect(result).to eq([course2])
    end
  end
end
