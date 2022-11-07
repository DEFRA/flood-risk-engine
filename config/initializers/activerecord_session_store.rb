# frozen_string_literal: true

Rails.application.config.session_store :active_record_store, key: ENV.fetch("SECRET_KEY_BASE", nil)
