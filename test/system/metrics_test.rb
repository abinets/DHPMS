require "application_system_test_case"

class MetricsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one) # Assuming you have a users fixture
    login_as @user, scope: :user
    @metric = metrics(:one) # From test/fixtures/metrics.yml
  end

  test "visiting the index" do
    visit metrics_url
    assert_selector "h1.h2", text: I18n.t("metrics.index.title")
  end

  test "should create Metric" do
    visit metrics_url
    click_on I18n.t("scaffold.new.title", model: Metric.model_name.human)

    # Use specific values for the new metric
    new_value = 12345
    new_time_str = "2024-01-15T10:30:00"
    new_time_obj = Time.zone.parse(new_time_str)

    fill_in Metric.human_attribute_name(:value), with: new_value
    fill_in Metric.human_attribute_name(:time), with: new_time_str
    click_on I18n.t("helpers.submit.metric.create") # "Create Metric"

    assert_text I18n.t("flash.actions.create.notice", resource_name: "Metric")
    
    # Verify the new metric is on the index page (or show page if redirected there first)
    # Assuming redirect to show page, then navigate back or directly to index
    visit metrics_url # Go to index to be sure
    assert_text new_value
    assert_text I18n.l(new_time_obj, format: :long)
  end

  test "should update Metric" do
    visit metrics_url
    # Click edit for the specific metric, could be more robust with a specific selector
    find("##{dom_id(@metric)}").click_on I18n.t("scaffold.actions.edit")
    
    updated_value = 54321
    updated_time_str = "2025-02-20T15:45:00"
    updated_time_obj = Time.zone.parse(updated_time_str)

    fill_in Metric.human_attribute_name(:value), with: updated_value
    fill_in Metric.human_attribute_name(:time), with: updated_time_str
    click_on I18n.t("helpers.submit.metric.update") # "Update Metric"

    assert_text I18n.t("flash.actions.update.notice", resource_name: "Metric")

    visit metrics_url # Go to index to verify
    assert_text updated_value
    assert_text I18n.l(updated_time_obj, format: :long)
    # Assert that old data is not present if it's different enough
    assert_no_text @metric.value unless @metric.value == updated_value
  end

  test "should destroy Metric" do
    visit metrics_url
    # Make sure the metric is present before destroying
    assert_text @metric.value
    
    accept_confirm do
      find("##{dom_id(@metric)}").click_on I18n.t("scaffold.actions.destroy")
    end

    assert_text I18n.t("flash.actions.destroy.notice", resource_name: "Metric")
    
    # Verify the metric is no longer on the index page
    assert_no_text @metric.value
    # The time might be less unique, so value is a better check
  end
end
