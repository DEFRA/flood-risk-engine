# frozen_string_literal: true

Rails.application.configure do
  # http://guides.rubyonrails.org/active_job_basics.html#backends
  config.active_job.queue_adapter =
    if !Rails.env.test? && defined?(SuckerPunch)
      :sucker_punch
    else
      :inline # no asynchronous background job processing
    end
end
