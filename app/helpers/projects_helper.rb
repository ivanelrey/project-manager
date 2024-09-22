# frozen_string_literal: true

module ProjectsHelper
  def project_img_src(project_id)
    "#{project_id.to_s.last}.svg"
  end
end
