require 'test_helper'

class OptionsProcessorTest < MiniTest::Unit::TestCase
  def setup
    @processor_class = Padrino::Helpers::Pagination::OptsProcessor
  end

  def assert_result_is_hash
    assert_instance_of Hash, @result
  end

  %w(per_page total_pages total_items current_page previous_page next_page).map(&:to_sym).each do |v|
    define_method "assert_#{v}_equal" do |value|
      assert_equal value, @result[v], "Wrong @result[:#{v}]"
    end

    define_method "assert_#{v}_nil" do
      assert_nil @result[v], "Expecteed @result[:#{v}] to be nil, but was #{@result[v]}"
    end
  end

  def test_empty_page
    processor = @processor_class.new 0, 7, 1
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 7
    assert_total_pages_equal 0
    assert_total_items_equal 0
    assert_current_page_equal 1

    assert @result.has_key?(:previous_page)
    assert_previous_page_nil
    assert @result.has_key?(:next_page)
    assert_next_page_nil
  end

  def test_one_not_full_page
    processor = @processor_class.new 5, 7, 1
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 7
    assert_total_pages_equal 1
    assert_total_items_equal 5
    assert_current_page_equal 1

    assert @result.has_key?(:previous_page)
    assert_previous_page_nil
    assert @result.has_key?(:next_page)
    assert_next_page_nil
  end

  def test_one_full_page
    processor = @processor_class.new 7, 7, 1
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 7
    assert_total_pages_equal 1
    assert_total_items_equal 7
    assert_current_page_equal 1

    assert @result.has_key?(:previous_page)
    assert_previous_page_nil
    assert @result.has_key?(:next_page)
    assert_next_page_nil
  end

  def test_two_not_full_pages
    processor = @processor_class.new 12, 8, 1
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 8
    assert_total_pages_equal 2
    assert_total_items_equal 12
    assert_current_page_equal 1

    assert @result.has_key?(:previous_page)
    assert_previous_page_nil
    assert @result.has_key?(:next_page)
    assert_next_page_equal 2

    processor = @processor_class.new 12, 8, 2
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 8
    assert_total_pages_equal 2
    assert_total_items_equal 12
    assert_current_page_equal 2

    assert @result.has_key?(:previous_page)
    assert_previous_page_equal 1
    assert @result.has_key?(:next_page)
    assert_next_page_nil
  end

  def test_two_full_pages
    processor = @processor_class.new 12, 6, 1
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 6
    assert_total_pages_equal 2
    assert_total_items_equal 12
    assert_current_page_equal 1

    assert @result.has_key?(:previous_page)
    assert_previous_page_nil
    assert @result.has_key?(:next_page)
    assert_next_page_equal 2

    processor = @processor_class.new 12, 6, 2
    @result = processor.result

    assert_result_is_hash
    assert_per_page_equal 6
    assert_total_pages_equal 2
    assert_total_items_equal 12
    assert_current_page_equal 2

    assert @result.has_key?(:previous_page)
    assert_previous_page_equal 1
    assert @result.has_key?(:next_page)
    assert_next_page_nil
  end
end
