# frozen_string_literal: true

module ErrorHandling # rubocop:todo Style/Documentation
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render file: 'public/404.html', layout: false
    end
  end
end
