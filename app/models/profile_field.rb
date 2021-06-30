class ProfileField < ApplicationRecord
  include ActsAsProfileField

  # Key names follow the Rails form helpers
  enum input_type: {
    text_field: 0,
    text_area: 1,
    check_box: 2,
    color_field: 3
  }

  # NOTE: @citizen428 We need to remove settings_only from here once the user
  # settings work gets merged. Maybe we can even get rid of this enum altogether.
  enum display_area: {
    header: 0,
    left_sidebar: 1,
    settings_only: 2
  }

  belongs_to :profile_field_group, optional: true

  validates :display_area, presence: true
  validates :input_type, presence: true
  validates :show_in_onboarding, inclusion: { in: [true, false] }

  def type
    return :boolean if check_box?

    :string
  end
end
