FactoryGirl.define do
  factory :jpeg_offset, class: Offset do
    offset_type TargetType::JPEG
  end

  factory :gif_offset, class: Offset do
    offset_type TargetType::GIF
  end
end
